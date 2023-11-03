# gitbundle
快速将远程 Git 仓库和本地仓库打包成一个文件

![Snipaste_2023-11-03_23-40-26.png](https://vip2.loli.io/2023/11/04/iWf3RwEsOYG6eNZ.png)

[中文](README_zh.md) | [English](README.md)
## 使用方法
```
gitbundle <远程或本地路径> [打包文件名]
```
## 解包
```Shell
git clone <打包文件名> <仓库名>
```
## 示例 (Windows)
```Batchfile
gitbundle https://github.com/Sonic853/UdonLabToolkit
gitbundle https://github.com/Sonic853/UdonLabToolkit.git UdonLabToolkit.git.bundle
gitbundle D:\Git\UdonLabToolkit
gitbundle D:\Git\UdonLabToolkit UdonLabToolkit.bundle
gitbundle AGitFolder AGitFile.git.bundle

@REM 解包
gitbundle https://github.com/Sonic853/UdonLabToolkit.git UdonLabToolkit.git.bundle
git clone UdonLabToolkit.git.bundle UdonLabToolkit
```
## 示例 (Linux)
```Shell
./gitbundle.sh https://github.com/Sonic853/UdonLabToolkit
# 如果你已经将 gitbundle.sh 安装到 /usr/bin/gitbundle 并设置了 chmod +x
gitbundle https://github.com/Sonic853/UdonLabToolkit.git UdonLabToolkit.git.bundle
gitbundle /home/Sonic853/Git/UdonLabToolkit
gitbundle /home/Sonic853/Git/UdonLabToolkit UdonLabToolkit.bundle
gitbundle AGitFolder AGitFile.git.bundle

# 解包
gitbundle https://github.com/Sonic853/UdonLabToolkit.git UdonLabToolkit.git.bundle
git clone UdonLabToolkit.git.bundle UdonLabToolkit
```