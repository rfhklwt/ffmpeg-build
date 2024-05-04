#!/bin/bash
cd "$(dirname $0)" || exit 1
readonly BUILD_PATH=$(pwd)
source "$BUILD_PATH/tools.sh"

# 存放依赖库的链接
readonly NASM='nasm-2.16.03'

# 视频库
readonly X264='x264-master'
readonly X265='x265_3.6'
readonly VPX='libvpx-1.14.0'

# 音频库
readonly AAC='fdk-aac-2.0.3'
readonly LAME='lame-3.100'
readonly OPUS='opus-1.5.2'

readonly OUTPUT_PATH=$BUILD_PATH/build
readonly PKG_PATH=$BUILD_PATH/package
readonly INSTALL_PATH=$BUILD_PATH/tmp

mkdir -p $OUTPUT_PATH
mkdir -p $INSTALL_PATH

function clean_env()
{
    rm -rf $INSTALL_PATH
}

function check_result()
{
    local result=$1

    if [ $result -ne 0 ]; then
        log_error "$2 failed"
        clean_env
        exit 1
    fi

    log_info "$2 success"
}

function install_package()
{
    local pkg_name=$1
    cd $INSTALL_PATH || exit 1
    find_and_untar $pkg_name
    cd $pkg_name || exit 1
    ./configure --prefix=$OUTPUT_PATH --enable-static --disable-shared
    make -j && make install && make clean
    check_result "$?" "install $pkg_name"
}

function install_x264()
{
    install_package $X264
}

function install_x265()
{
    local pkg_name=$X265
    cd $INSTALL_PATH || exit 1
    find_and_untar $pkg_name
    cd $pkg_name/source
    cmake -B build -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$OUTPUT_PATH" -DENABLE_SHARED=OFF -DENABLE_ASSEMBLY=ON -DENABLE_LIBNUMA=OFF
    cd build
    make -j && make install && make clean
    check_result "$?" "install $pkg_name"
}

function install_vpx()
{
    install_package $VPX
}

function install_aac()
{
    install_package $AAC
}

function install_lame()
{
    install_package $LAME
}

function install_opus
{
    install_package $OPUS
}

function install_all()
{
    install_x264
    install_x265
    install_vpx
    install_aac
    install_lame
    install_opus
}

function main()
{
    cp $PKG_PATH/*.tar.gz $INSTALL_PATH/
    install_all
    clean_env
}

main
