 #--------------------------------------------
# 功能：实现Debug版本的打包
# 将build.sh 和ExportOptions.plist拖入工程project所在目录
# 使用教程： 1. cd 脚本所在的目录
#           2. chmod 777 build.sh (仅第一次的时候需要)
#           3. ./build.sh
# 注：这边生成的Debug.ipa 相当于development用的IPA,证书须为对应的development证书
#--------------------------------------------


#编译方式
build_Mode='Debug'

cd ..
# 获取工程根目录
root_path=$PWD
echo "======工程根目录:${root_path}======"

# 获取ipa文件导出路径
build_outputPath(){
    scheme=$(ls | grep xcodeproj | awk -F.xcodeproj '{print $1}')
    SYSTEM_TIME=`date '+%Y-%m-%d-%T'`
    mkdir 'ipas'
    cd 'ipas'
    outputPath=$(pwd)/${scheme}_${SYSTEM_TIME}
    mkdir ${outputPath}
    echo ${outputPath}
}
ipa_path=$(build_outputPath)
echo "======ipa导出路径:${ipa_path}======"${ipa_path}

# 获取工程名称
project_name=$(ls | grep xcodeproj | awk -F.xcodeproj '{print $1}')
echo "======工程名称:${project_name}======"

#scheme名
scheme_name=${project_name}
echo "======scheme名称:${project_name}======"

# 获取xcworkSpace的路径
workspacePath=${root_path}/${project_name}.xcworkspace
echo "======xcworkSpace的路径:${workspacePath}======"

# build文件夹路径
build_path=${root_path}/build
echo "======build文件夹路径:${build_path}======"

# 获取EXportOptions.plist路径
exportOptionsPlistPath=${root_path}/build_ipa/ExportOptions.plist
echo "======EXportOptions.plist路径:${exportOptionsPlistPath}======"

#获取info.plist的文件路径
project_infoplist_path=${root_path}/${project_name}/info.plist
# 取版本号
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${project_infoplist_path})
# 取build值
bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${project_infoplist_path})
echo "======shortVersion:${bundleShortVersion},version:${bundleVersion}======"


# 进入工程路径下
cd $root_path
echo "======开始清理工程======"

# 删除bulid目录
if [ -d ${build_path} ];
    then
    rm -rf ${build_path}
    echo "======清理build文件成功======"
fi
echo "======正在清理工程...======"
xcodebuild \
clean -configuration ${build_Mode} -quiet  || exit
echo "======清理完成======"


if  [ -d ${workspacePath} ];
    then
    echo "======当前工程使用cocoapods======"
    echo "======正在编译工程 For ${build_Mode} ...======"
    xcodebuild \
    archive -workspace ${root_path}/${project_name}.xcworkspace \
    -scheme ${scheme_name} \
    -configuration ${build_Mode} \
    -archivePath ${build_path}/${project_name}.xcarchive -quiet  || exit
    echo "======编译完成======"
else
    echo "======当前工程没有使用cocoapods======"
    echo "======正在编译工程 For '${build_Mode} ...======"
    xcodebuild \
    archive -project ${root_path}/${project_name}.xcodeproj \
    -scheme ${scheme_name} \
    -configuration ${build_Mode} \
    -archivePath ${build_path}/${project_name}.xcarchive -quiet  || exit
    echo "======编译完成======"

fi


echo "======正在打包 ...======"
xcodebuild -exportArchive -archivePath ${build_path}/${project_name}.xcarchive \
-exportPath ${ipa_path} \
-exportOptionsPlist ${exportOptionsPlistPath} \
-quiet || exit
echo "======打包完成======"

echo "======删除build文件夹======"
if [[ -d build ]];
    then
    rm -rf build -r
fi

#配置蒲公英API Key
APIKey='5c88d7d1b1489f6e40419750276a7b8e'
#配置蒲公英User Key
UserKey='eb965f14edfbea223a7ce42b9325db86'
#描述说明
Des='当前的shorVersion:${bundleShortVersion}'

echo "======开始上传到蒲公英 ...======"
curl -F "file=@${ipa_path}/${project_name}.ipa" \
-F "uKey=${UserKey}" \
-F "_api_key=${APIKey}" \
-F "updateDescription=${Des}" \
https://www.pgyer.com/apiv1/app/upload --verbose

echo "~~~~~~~~~~~~~~~~~~~~~~~~~"
if [ $? = 0 ]
    then
        echo "🎉🎉🎉🎉🎉🎉==上传蒲公英成功==🎉🎉🎉🎉🎉🎉"
    else
        echo "💣💣💣💣💣💣==上传蒲公英失败==💣💣💣💣💣💣"
fi




