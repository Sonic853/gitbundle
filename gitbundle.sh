#!/bin/bash
# Batch to shellscript

# git clone <url>
# cd <filename>
# git bundle create ../<filename>.git.bundle --all
# cd ..
# rm -rf <filename>

# gitbundle url [filename]

usage()
{
    echo ""
    echo usage:
    echo ./gitbundle.sh url [filename]
    echo ""
    echo url: git url or local git folder
    echo filename: bundle filename
    echo ""
    echo example:
    echo ./gitbundle.sh https://github.com/Sonic853/UdonLabToolkit
    echo ./gitbundle.sh https://github.com/Sonic853/UdonLabToolkit.git UdonLabToolkit.git.bundle
    echo ./gitbundle.sh /home/Sonic853/Git/UdonLabToolkit
    echo ./gitbundle.sh /home/Sonic853/Git/UdonLabToolkit UdonLabToolkit.bundle
    echo ./gitbundle.sh AGitFolder AGitFile.git.bundle
    echo ""
    # 等待用户输入回车
    read -p "Press any key to continue."
    exit
}

startclone()
{
    git clone $url $foldername
    cd $foldername
    echo ""
    echo Start create bundle...
    git bundle create ../$filename --all
    cd ..
    checkfile()
    {
        rm -rf $foldername
        if [ -d "$foldername" ]; then
            sleep 1
            checkfile
        fi
    }
    checkfile
    echo ""
    echo $filename created. use command:
    echo ""
    echo git clone $filename
    echo ""
    echo to clone the repository.
    exit
}

checkfileandfolder()
{
    if [ -d "$foldername" ]; then
        echo $foldername already exists.
        exit
    fi

    if [ -f "$filename" ]; then
        echo $filename already exists.
        exit
    fi

    startclone
}

basename()
{
    # https://github.com/Sonic853/UdonLabToolkit.git -> UdonLabToolkit
    echo $1 | sed 's/.*\///' | sed 's/\.git//'
}

checkfilename()
{

    setfilenamewithbundle()
    {
        foldername=$filename.gitbundlecache
        filename=$filename.git.bundle
        checkfileandfolder
    }

    setfilename()
    {
        foldername=$(basename $url).gitbundlecache
        checkfileandfolder
    }
    # 判断 %2 是否为空，如果为空，则使用url的最后一段作为文件名

    if [ -z "$filename" ]; then
        filename=$(basename $url)
        setfilenamewithbundle
    else
        setfilename
    fi
}

bundleonly()
{
    # 记录当前路径
    currentpath=$(pwd)
    # 判断 %url% 是否是本地路径

    if [ ! -d "$url" ]; then
        usage
    fi

    if [ -z "$filename" ]; then
        filename=$(basename $url).git.bundle
    fi

    if [ -f "$currentpath/$filename" ]; then
        echo $filename already exists.
        exit
    fi
    cd "$url"
    git bundle create $currentpath/$filename --all
    cd $currentpath
    echo ""
    echo $filename created. use command:
    echo ""
    echo git clone $filename
    echo ""
    echo to clone the repository.
    exit
}

startcheck()
{
    checkend()
    {
        # 判断 %url% 是否以 .git 结尾，如果不是，则添加 .git
        if [ "${url: -4}" == ".git" ]; then
            checkfilename
        else
            url=$url.git
            checkfilename
        fi
    }

    # https://github.com/Sonic853/UdonLabToolkit
    # https://github.com/Sonic853/UdonLabToolkit.git
    # git@github.com:Sonic853/UdonLabToolkit.git
    # ssh://git@github.com/Sonic853/UdonLabToolkit.git

    if [ "${url:0:4}" == "http" ]; then
        checkend
    elif [ "${url:0:4}" == "git@" ]; then
        checkend
    elif [ "${url:0:4}" == "ssh:" ]; then
        checkend
    else
        bundleonly
    fi
}

url=$1
filename=$2

if [ ! -z "$url" ]; then
    startcheck
else
# 提示输入
    echo Please input git url:
    read url

    if [ -z "$url" ]; then
        usage
    fi

    echo Please input bundle filename, press enter to use default filename:
    read filename
    startcheck
fi

end