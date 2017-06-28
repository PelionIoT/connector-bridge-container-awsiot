#!/bin/bash

setup_locale() {
   locale-gen en_US en_US.UTF-8
}

setup_connector_bridge() 
{
    cd /home/arm
    unzip -q ./connector-bridge.zip
    /bin/rm -f ./connector-bridge.zip
    chown -R arm.arm connector-bridge *.sh
    chmod -R 700 connector-bridge *.sh
    cd /home/arm
    ln -s connector-bridge service
}

setup_properties_editor()
{
   cd /home/arm
   /bin/rm -rf properties-editor 2>&1 1> /dev/null
   unzip -q ./properties-editor.zip
   /bin/rm -f ./properties-editor.zip
   chown -R arm.arm properties-editor
   chmod -R 700 properties-editor
   cd properties-editor/conf
   ln -s ../../connector-bridge/conf/service.properties .
   cd ../..
}

setup_ssh()
{
    cd /home/arm
    tar xpf ssh-keys.tar
    /bin/rm -f ssh-keys.tar
    mkdir /var/run/sshd
    chmod 600 .ssh/*
    chmod 700 .ssh
    echo "MaxAuthTries 10" >> /etc/ssh/sshd_config
}

setup_aws_cli() {
    cd /home/arm
    tar xpf aws-cli.tar
    /bin/rm -f aws-cli.tar
    chown -R arm.arm .aws
    chmod 755 .aws
    chmod 600 .aws/*
    cd /home/arm/connector-bridge
    ln -s /usr/local/bin/aws .
    cd /home/arm
}

setup_passwords()
{
    echo "root:arm1234" | chpasswd
    echo "arm:arm1234" | chpasswd
}

setup_sudoers() 
{
    usermod -aG sudo arm
    echo "%arm ALL=NOPASSWD: ALL" >> /etc/sudoers
}

setup_java() {
    echo "Using defaulted JRE..."
}

cleanup()
{
   /bin/rm -f /home/arm/configure_instance.sh 2>&1 1>/dev/null
}

main() 
{
    setup_locale
    setup_passwords
    setup_sudoers
    setup_ssh
    setup_java
    setup_aws_cli
    setup_properties_editor
    setup_connector_bridge
    cleanup
}

main $*
