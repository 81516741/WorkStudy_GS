 #!/bin/bash
echo 请输入上传蒲公英的描述
read des
fastlane build des:$des
