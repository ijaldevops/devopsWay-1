# devopsWay-1
```sh
Note : it will be implement in CentOS 7
```
Master Node will be having function as image generator as well as node controller for kubernetes cluster. It will be in the outside of the cluster
```sh
So in this Master we need to install these packages or applications :
1. git
2. maven
3. docker
4. kubelet
5. Jenkins
```

Jenkins we put in the last step so we can test by Jenkins the previous app like git, maven and docker in the manager

Before they are installed we need the java 

```sh
yum -y install java-1.8*
```

Update ~/.bash_profile , in this step we still use user root
``` sh
JAVA_HOME=`find /usr/lib/jvm/java-1.8* | head -n 3 | tail -1`
export JAVA_HOME
PATH=$PATH:$JAVA_HOME
export PATH
```
Check the PATH by echoing $PATH and check the version
echo $PATH
java -version

in this example we use version 1.8.0
```sh
    openjdk version "1.8.0_242"
    OpenJDK Runtime Environment (build 1.8.0_242-b08)
    OpenJDK 64-Bit Server VM (build 25.242-b08, mixed mode)
```

1. Installing git
    we should have git account of course, for this step we will use github

    ```sh
    yum -y install git
    ```

2. Installing maven
    Change to directory /opt/ for app
    ``` sh
    cd /opt
    ```
    
    Downloading maven package from the maven official website

    ```sh
    wget http://mirrors.estointernet.in/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz

    tar -zxvf apache-maven-3.6.1-bin.tar.gz
    mv /opt/apache-maven-3.6.1-bin /opt/maven

    #set Maven Path
    M2_HOME=/opt/maven
    M2=/opt/maven/bin

    PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2
    export PATH
    ```
    Updating bash_profile for maven 
    ```sh
    cat << EOF > ~/.bash_profile
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi

    JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64
    M2_HOME=/opt/maven
    M2=/opt/maven/bin

    PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2
    ```

3. Installing docker
    Install docker, so in this box we can build the image needed and push it to dockerhub
    ``` sh
    yum -y install docker
    ```
    make it running and alive! 
    ```sh
    systemctl enable docker
    systemctl start docker
    ```

4. Installing kubelet and kubectl
    This is optional by the way, we need to install it if we want to control the cluster whithout login to kubernetes master node
    ```sh

    cat <<EOF > /etc/yum.repos.d/kubernetes.repo
    [kubernetes]
    name=Kubernetes
    baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
    EOF
    ```
    ```sh
    yum -y install kubelet kubectl 

    systemctl enable kubelet
    systemctl start kubelet
    ```


5. Installing Jenkins
    ```sh
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    yum -y install jenkins
    ```
Open the web http://ipMaster:8080
for the first login attempt follow the fist landing page to get the initial key after login success change the password in admin >> configure




