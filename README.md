## Flutter客户端打包
[toc]



视频地址: [https://www.bilibili.com/video/av35800108/index_24.html](https://www.bilibili.com/video/av35800108/index_24.html)


#### 配置APP的图标
找到相关图标目录

>    **项目根目录/android/app/src/main/res/**


进入之后你会看到很多mipmap-为前缀命名的文件夹，后边的是像素密度，可以看出图标的分辨率。

> mdpi (中) ~160dpi
> hdpi （高） ~240dip
> xhdpi （超高） ~320dip
> xxhdpi （超超高） ~480dip
> xxxhdpi （超超超高） ~640dip

将对应像素密度的图片放入对应的文件夹中,图片记得用png格式，记得名字要统一，才能一次性进行配置。



#### AndroidManifest.xml 文件

这个文件主要用来配置APP的名称、图标和系统权限，所在的目录在:

> **项目根目录/android/app/src/main/AndroidManifest.xml**

```xml
    android:label="flutter_app"   //配置APP的名称，支持中文
    android:icon="@mipmap/ic_launcher" //APP图标的文件名称
```



#### 生成 keystore

##### 1.输入`flutter doctor -v`找到找到keytool.exe的位置
```
f
flutter doctor -v
```
![ad3ac96f88af3878493e63e58126c21c.png](en-resource://database/1387:1)


> 注意: 如果系统是windows, 在`终端工具`输入带有空格的文件夹名字(例如"Program Files").要用双引号包围

```bash
 cd 'C:\Program Files (x86)'
```

![a8c348e16b31fa0097b6d48d7d53d3be.png](en-resource://database/1389:1)

##### 2.用keytool.exe,执行命令生成key


windows系统加上双引号即可:
```bash
  $  'keytool.exe位置/keytool'  -genkey -v -keystore  生成目录/key.jks  -keyalg RSA -keysize 2048 -validity 10000 -alias key
```
**或者** 

cd到keytool位置再执行
```bash
  $   keytool -genkey -v -keystore   生成目录/key.jks  -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

![aa3854d89604103806d4655526991209.png](en-resource://database/1391:1)



这个时候在`生成目录`里面多了一个`key.jks`文件
有了这个key.jks文件后，可以到项目目录下的`android`文件夹下，创建一个名为key.properties的文件，并打开粘贴下面的代码。

```
storePassword=<password from previous step>    //输入上一步创建KEY时输入的 密钥库 密码
keyPassword=<password from previous step>    //输入上一步创建KEY时输入的 密钥 密码
keyAlias=key
storeFile=<E:/key.jks>    //key.jks的存放路径
```

我的文件最后是这样的：
```
storePassword=123123
keyPassword=123123
keyAlias=key
storeFile=D:/key.jks
```



#### 配置key注册


key生成好后，需要在`build.gradle`文件中进行配置。这个过程其实很简单，就是粘贴复制一些东西，你是不需要知道这些文件的具体用处的。



##### 1. 进入`项目目录的/android/app/build.gradle`文件，在android{这一行前面,加入如下代码：

```
def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
```

##### 2. 把如下代码进行替换

```
buildTypes {
    release {
        signingConfig signingConfigs.debug
    }
}
```

替换成的代码：

```
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

#### 生成apk

直接在终端中输入：

```
flutter build apk
```
这时候就打包成功了.
![8ed79cec0311623a524d37611f02f812.png](en-resource://database/1393:1)

#### 测试安装apk

打包成功后 执行
```bash
$  flutter install
```
