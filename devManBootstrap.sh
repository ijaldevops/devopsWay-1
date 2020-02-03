#!/bin/sh

garis(){
wait
local len=80 ; local i; for (( i = 0; i < len + 4; ++i )); do printf '='; done; printf "\n" 
wait; echo ""
}



echo "install Java"
#yum -y install java-1.8*
garis
echo "Set Java Path"
JAVA_HOME=`find /usr/lib/jvm/java-1.8* | head -n 3 | tail -1`
export JAVA_HOME
PATH=$PATH:$JAVA_HOME
export PATH

echo "Install git"
yum -y install git


echo "Install maven"
cd /opt
wget http://mirrors.estointernet.in/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz
wait
tar -zxvf apache-maven-3.6.1-bin.tar.gz
mv /opt/apache-maven-3.6.1-bin /opt/maven

M2_HOME=/opt/maven
M2=/opt/maven/bin

PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2
export PATH



echo "Update Bash Profile"
garis;

cat << EOF > ~/.bash_profile
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64
M2_HOME=/opt/maven
M2=/opt/maven/bin

PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2

export PATH
EOF


echo "Install kubelet"
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

garis
yum -y install kubelet kubectl docker











