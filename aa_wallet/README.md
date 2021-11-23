# aa_wallet 简介            v 1.0.10


# 使用指南

    1、环境变量 可以参考
    # Flutter
    export PUB_HOSTED_URL=https://pub.flutter-io.cn
    export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
    export PATH=~/flutter/bin:$PATH
    export DART_HOME=~flutter/bin/cache/dart-sdk/bin
    export FLUTTER_HOME=~/flutter/bin
    # Flutter END

    2、如果您使用了以上的配置 可以使用 apptools 工具类来生成 相对应的 全局 文件
       非常重要 一定要运行 不然报错 非常重要 一定要运行 不然报错 非常重要 一定要运行 不然报错
       mac 系统 请 用这样的命令 ./apptools.sh 之后输入 1 || 回车 如果配置和上面一样的话
       win 系统 请 用这样的命令  apptools.bat 之后输入 1 || 回车 如果配置和上面一样的话

    3、打包命令 Android only
       使用build_apk.sh 进行打包 Release 表示正式版本 采用正式环境 Debug采用测试环境 而Charles 是正式环境可以抓包的
       配合 环境 是在 lib/const/env_config 里面配置相对应环境


