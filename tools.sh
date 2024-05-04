#!/bin/bash

function log_info()
{
    echo -e "\033[1;32m[INFO] $1\033[0m"
}

function log_error()
{
    echo -e "\033[1;31m[ERROR] $1\033[0m"
}

function fetch_package()
{
    local pkg_name=$(basename -- $1)
    if [ -f $pkg_name ]; then
        return
    fi
    wget $1
    check_result "$?" "fetch $pkg_name"
}

function find_and_untar()
{
    local pkg_name="$1.tar.gz"
    if [ ! -f $pkg_name ]; then
        log_error "$pkg_name not exist"
        exit 1
    fi

    tar -zxvf $pkg_name
    check_result "$?" "untar $pkg_name"
}


