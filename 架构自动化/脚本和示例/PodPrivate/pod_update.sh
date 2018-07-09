 #!/bin/bash
echo "请输入版本号"
read tag

repo_name="LDPrivateSpecs"
echo "默认私有库 $repo_name 请输入1"
read is_default
if ((is_default==1))
    then
    echo "上传至 $repo_name"
else
    echo "请输私有库名字"
    read my_repo_name
    repo_name=$my_repo_name
fi

str=$PWD
str=${str##*/}
echo 🔥执行:fastlane ManagerLib tag:$tag target:$str repo:$repo_name
fastlane ManagerLib tag:$tag target:$str repo:$repo_name

