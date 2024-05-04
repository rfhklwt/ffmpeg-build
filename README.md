## 简介
提供一个编译ffmpeg的简便脚本

## 使用方式

### 1. 拉取ffmpeg源码
* 首先需要拉取ffmpeg的源码仓，并切换到你想要的版本，这里以最新的7.0版本为例
```sh
cd /opt/
git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
cd ffmpeg
git checkout n7.0
```

### 安装依赖库

* macOS系统下，执行如下：
```sh
brew install automake sdl nasm
```

* 接着安装依赖库，执行如下命令即可：
```sh
./build_package.sh
```

> 考虑到大多数人网络不佳，这里将依赖库的包都存放在`package`路径下，依赖库的来源可以在 README.md 里看到，如果有最新版本可以手动下载替换。

* 最后安装 FFmpeg，执行如下命令
```sh
./build_ffmpeg.sh /opt/ffmpeg
```

> 其中`/opt/ffmpeg`为 FFmpeg 的源码路径。

NOTE: 该脚本编译`FFmpeg`的时候将二进制文件都存储在`$HOME/.local`目录下，因此你需要手动执行如下命令:
```
echo "export PATH=$HOME/.local/bin:$PATH" >> ~/.bashrc
```

最后执行
```sh
ffmpeg -v
```

显示如下即为大功告成
```sh
$ ffmpeg --version
ffmpeg version n7.0 Copyright (c) 2000-2024 the FFmpeg developers
  built with Apple clang version 15.0.0 (clang-1500.3.9.4)
  configuration: --prefix=/Users/qling-alter/.local --extra-cflags=-I/Users/qling-alter/qling/code/ffmpeg-build/build/include --extra-ldflags=-L/Users/qling-alter/qling/code/ffmpeg-build/build/lib --pkg-config-flags=--static --enable-gpl --enable-nonfree --enable-static --disable-shared --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libx264 --enable-libx265 --enable-libvpx
  libavutil      59.  8.100 / 59.  8.100
  libavcodec     61.  3.100 / 61.  3.100
  libavformat    61.  1.100 / 61.  1.100
  libavdevice    61.  1.100 / 61.  1.100
  libavfilter    10.  1.100 / 10.  1.100
  libswscale      8.  1.100 /  8.  1.100
  libswresample   5.  1.100 /  5.  1.100
  libpostproc    58.  1.100 / 58.  1.100
```

