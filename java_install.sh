#!/bin/bash
echo "java environment install"
tools_path="/opt/tools"

if [! -d "$tools_path" ];then
    mkdir -p  $tools_ath
fi

cd $tools_ath
echo "start download jdk"
wget  --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz    
echo "start download maven"
wget  http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz 
echo "start download gradle"
wget  https://services.gradle.org/distributions/gradle-4.4.1-bin.zip
#解压安装包
for file in `ls`
do
  if [ ! -f "$file" ];then
     #gradle 为zip包
     if [[ $file =~ "gradle" ]];then
        unzip $file
     else
        tar -xzvf $file
     fi
     rm -rf $file
  fi   
done

# 构造绝对路径
java_home="$tools_path/`ls |grep jdk`"
maven_home="$tools_path/`ls |grep maven`"
gradle_home="$tools_path/`ls |grep gradle`"
# 建立软链接
ln -s /opt/java $java_home
ln -s /opt/maven $maven_home
ln -s /opt/gradle $gradle

echo  "配置环境变量"

echo -e "export JAVA_HOME=/opt/java
export GRADLE_HOME=/opt/gradle
export MAVEN_HOME=/opt/maven
export PATH=\$JAVA_HOME/bin:\$GRADLE_HOME/bin:\$MAVEN_HOME/bin:\$PATH" > java.sh
#使环境变量生效
source /etc/profile
