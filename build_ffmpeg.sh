#!/bin/bash
cd "$(dirname $0)" || exit 1
readonly WORK_PATH=$(pwd)
source "$WORK_PATH/tools.sh"

readonly FFMPEG_PATH=$1
readonly BUILD_PATH=$WORK_PATH/build

function main()
{
    if [ x"$FFMPEG_PATH" == "x" ]; then
        log_error "ffmpeg source path can not be empty"
        log_info "Usage: ./build_ffmpeg.sh /xxx/ffmpeg"
        exit 1
    fi

    if [ ! -d $FFMPEG_PATJ ]; then
        echo "ffmpeg path '$FFMPEG_PATH' not exist"
        exit 1
    fi

    cd $FFMPEG_PATH || exit 1

    ./configure \
        --prefix="$HOME/.local" \
        --extra-cflags="-I$BUILD_PATH/include" \
        --extra-ldflags="-L$BUILD_PATH/lib" \
        --pkg-config-flags="--static" \
        --enable-gpl \
        --enable-nonfree \
        --enable-static \
        --disable-shared \
        --enable-libfdk-aac \
        --enable-libmp3lame \
        --enable-libopus \
        --enable-libx264 \
        --enable-libx265 \
        --enable-libvpx

    make -j && make install && make clean
    log_info "build ffmpeg success"
}

main
