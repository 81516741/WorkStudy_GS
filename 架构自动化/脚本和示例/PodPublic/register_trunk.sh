 #!/bin/bash
echo 注册trunk
echo 请输入注册的邮箱
read email
echo 请输入注册的描述
read des
echo 🔥开始注册
pod trunk register $email  $des  --verbose

