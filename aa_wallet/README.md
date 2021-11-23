# aa_wallet 简介            v 1.0.10

    一款基于MVVM+Provider的快速开发框架。

# 主要特性
    1、MVVM+Provider，低耦合、逻辑分明、页面代码清晰。Provider提供的状态管理使页面控制和展现更为灵活方便
    
    2、全局异常捕捉：接口业务型和语法型，业务型可根据需要进行处理（如未登录、未授权、超时、无网等等）并实现页面自动切换，语法型可以跳转到指定页面避免红屏（还可在此页面做日志上传）。
    
    3、全局cookie默认SharedPreferences，基础拦截器自动上传app版本等（可以根据需求自定）
    
    4、页面侧滑退出，路由管理模块，常用页面跳转动画的封装等
    
    5、全局toast、骨架屏、缓存、格式化文字、图片选择裁剪和上传、瀑布流和各种Util这些都是优秀的插件所提供的功能（再次感谢所有开源作者）
    
    6、基于Intl的国际化、APP主题切换。

# GITHUB 集成
    当你clone下项目后，可以看到一下几个文件:
    --const         /// 项目配置 包括主题 包括颜色
    --core          /// 框架核心文件夹
      --entity
        --respones  /// 响应实体类
          --base_respones.dart  ///响应实体类 主要做 网络拦截
      --以后有时间继续写
    --generated     /// I10n 在你编辑语言文件后自动生成的 ，请不要编辑这个文件夹下的内容
    --I10n          /// I10n插件创建，也可能是得你自己手动创建，具体看pubspec.yaml 框架修改
    --utils         /// 你的项目使用的工具类 一般通用类都会归放到core里面去
    --page          /// 你的项目页面
    --main.dart     /// 入口
    --res.dart      /// AssetRefGenerator 自动生成 资源影视 具体可查看 
                        https://github.com/ChinaStyle812/AssetsRefGenerator/blob/master/README_zh.md

    我暂时没有打算把core摘出来，通过pub来集成，因为个人可能都有自己的定制需求，pub集成并不便于按照自己的需求修改。 
    况且，直接clone集成还是非常简单的
    
# 使用指南
    1、将项目clone(master分支)下来，（注意，clone后不要无脑next，其中一步更换项目名时，换为你的）

    2、修改项目名（文件夹名），并删除目录下的.git文件夹（隐藏文件）

    3、使用AS或者VSCode打开项目，然后分别修改flutter、Android、ios项目的包名、应用ID以及应用名等信息。

    4、更换 pubspec.yaml中name属性为你的项目名称, 点一下pub get （这时你的项目爆红）

    Flutter目录修改

    * 修改项目根目录`pubspec.yaml`文件, 修改项目名、描述、版本等信息。

    ![](https://gitee.com/willzh/aa_wallet/blob/master/Resource/1.png)

    【注意】这里修改完`pubspec.yaml`中的`name`属性后，flutter项目的包名将会修改，这里我推荐大家使用全局替换的方式修改比较快。例如我想要修改`name`为`flutter_app`,在VSCode中你可以选择`lib`文件夹之后右击，选择`在文件夹中寻找`, 进行全局替换:

    ![](https://gitee.com/willzh/aa_wallet/blob/master/Resource/2.png)

    * 修改`lib/core/http/app_servers.dart`中的网络请求配置，包括：服务器地址、超时、拦截器等设置

    # Android目录修改

    * 修改android目录下的包名。

    在VSCode中你可以选择`android`文件夹之后右击，选择`在文件夹中寻找`, 进行全局替换。

    ![](https://gitee.com/willzh/aa_wallet/blob/master/Resource/3.png)

    【注意】修改包名之后，记住需要将存放`MainActivity.kt`类的文件夹名也一并修改，否则将会找不到类。

    * 修改应用ID。修改`android/app/build.gradle`文件中的`applicationId`

    * 修改应用名。修改`android/app/src/main/res/values/strings.xml`文件中的`app_name`

    # IOS目录修改

    ios修改相对简单，直接使用XCode打开ios目录进行修改即可。如下图所示：

    ![](https://gitee.com/willzh/aa_wallet/blob/master/Resource/ios_1.jpeg)

    ![](ttps://gitee.com/willzh/aa_wallet/blob/master/Resource/ios_2.png)

    5、全局查找 aa_wallet 替换为上面 name 的值(这时项目恢复正常)

    6、page页面下的app_main_page.dart 和 splash 文件保留 其他可酌情删除

    7、根目录的 README.md也删除

    8、环境变量 可以参考
    # Flutter
    export PUB_HOSTED_URL=https://pub.flutter-io.cn
    export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
    export PATH=~/flutter/bin:$PATH
    export DART_HOME=~flutter/bin/cache/dart-sdk/bin
    export FLUTTER_HOME=~/flutter/bin
    # Flutter END

    9、如果您使用了以上的配置 可以使用 apptools 工具类来生成 相对应的 全局 文件
       非常重要 一定要运行 不然报错 非常重要 一定要运行 不然报错 非常重要 一定要运行 不然报错
       mac 系统 请 用这样的命令 ./apptools.sh 之后输入 1 || 回车 如果配置和上面一样的话
       win 系统 请 用这样的命令  apptools.bat 之后输入 1 || 回车 如果配置和上面一样的话

    10、打包命令 Android only
       mac 系统 请 用这样的命令 ./apptools.sh 之后再选着 5 选项 如果配置和上面一样的话
       win 系统 请 用这样的命令  apptools.bat 之后再选着 5 选项 如果配置和上面一样的话
       flutter build apk --no-shrink
       或者(推荐 上面的命令行用的就是这条)  flutter build apk --target-platform android-arm,android-arm64 --split-per-abi
       或者  flutter build appbundle --target-platform android-arm,android-arm64,android-x64


