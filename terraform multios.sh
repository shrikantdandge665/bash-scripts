# Bash script  to install terraform binary in linux machine without package manager

# Check If terraform installed by running command 'terraform -help'
#!/bin/bash
#Checking Os name
FILE=/etc/os-release
if [ -e $FILE ]; then
 . $FILE
 echo "$ID${VERSION_ID:+.${VERSION_ID}} is the os-release"
 RELEASE=$ID
else
 echo "The file $FILE does not exist. This is not suppored OS. Failing Command"
 exit
fi
#Checking OS architecture
ARCH=$(uname -m)
#installing agent and updating os packages
if [[ $RELEASE == 'amzn' || $RELEASE == 'centos' || $RELEASE == 'rhel' ]]; then
  yum update -y
  if [[ `echo $ARCH` == 'x86_64' ]]; then
    wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
    tar -zxvf go1.20.4.linux-amd64.tar.gz -C /usr/local/
    export PATH=$PATH:/usr/local/go/bin
    sudo echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
    source /etc/profile
    git clone https://github.com/hashicorp/terraform.git
    cd terraform
    go install
    mv ~/go/bin/terraform /usr/local/bin/
  fi
elif [[ $RELEASE == 'debian' || $RELEASE == 'ubuntu' ]]; then
  apt-get update && apt-get upgrade -y
  if [[ `echo $ARCH` == 'x86_64' ]]; then
    wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
    tar -zxvf go1.20.4.linux-amd64.tar.gz -C /usr/local/
    export PATH=$PATH:/usr/local/go/bin
    sudo echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
    source /etc/profile
    git clone https://github.com/hashicorp/terraform.git
    cd terraform
    go install
    mv ~/go/bin/terraform /usr/local/bin/
  fi
else
  echo "This is not supported OS. Failing Command."
  exit 1
fi

