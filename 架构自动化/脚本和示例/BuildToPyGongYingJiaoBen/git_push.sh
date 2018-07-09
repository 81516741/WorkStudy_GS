 #!/bin/bash
echo 请输入提交的描述
read des
git pull origin master
git add .
git commit -m $des
git push origin master
