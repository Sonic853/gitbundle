# gitbundle
Quickly bundle remote Git repositories and local repositories

![Snipaste_2023-11-03_23-40-26](https://github.com/Sonic853/gitbundle/assets/8389962/a48bc6b9-6dd9-416c-8ed2-541e3b1787d5)

[中文](README_zh.md) | [English](README.md)
## Usage
```
gitbundle <remote or local path> [bundle file name]
```
## Unbundle
```Shell
git clone <bundle file name> <repository name>
```
## Example (Windows)
```Batchfile
gitbundle https://github.com/Sonic853/UdonLabToolkit
gitbundle https://github.com/Sonic853/UdonLabToolkit.git UdonLabToolkit.git.bundle
gitbundle D:\Git\UdonLabToolkit
gitbundle D:\Git\UdonLabToolkit UdonLabToolkit.bundle
gitbundle AGitFolder AGitFile.git.bundle

@REM Unbundle
gitbundle https://github.com/Sonic853/UdonLabToolkit.git UdonLabToolkit.git.bundle
git clone UdonLabToolkit.git.bundle UdonLabToolkit
```
## Example (Linux)
```Shell
./gitbundle.sh https://github.com/Sonic853/UdonLabToolkit
# if you have install gitbundle.sh to /usr/bin/gitbundle and set it chmod +x
gitbundle https://github.com/Sonic853/UdonLabToolkit.git UdonLabToolkit.git.bundle
gitbundle /home/Sonic853/Git/UdonLabToolkit
gitbundle /home/Sonic853/Git/UdonLabToolkit UdonLabToolkit.bundle
gitbundle AGitFolder AGitFile.git.bundle

# Unbundle
gitbundle https://github.com/Sonic853/UdonLabToolkit.git UdonLabToolkit.git.bundle
git clone UdonLabToolkit.git.bundle UdonLabToolkit
```
<!-- ## Install (Windows)
```Batchfile
copy gitbundle.bat C:\Windows\System32\gitbundle.bat
```
## Install (Linux)
```Shell
sudo cp gitbundle.sh /usr/bin/gitbundle
sudo chmod +x /usr/bin/gitbundle
``` -->