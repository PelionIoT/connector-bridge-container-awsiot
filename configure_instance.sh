#!/bin/bash

setup_locale() {
   locale-gen en_US en_US.UTF-8
}

setup_bridge() 
{
    cd /home/arm
    unzip -q ./connector-bridge.zip
    /bin/rm -f ./connector-bridge.zip
    chown -R arm.arm mds *.sh
    chmod -R 700 mds *.sh
}

setup_configurator()
{
   cd /home/arm
   /bin/rm -rf configurator 2>&1 1> /dev/null
   unzip -q ./configurator-1.0.zip
   /bin/rm -f ./configurator-1.0.zip
   chown -R arm.arm configurator
   chmod -R 700 configurator
   cd configurator/conf
   if [ -f deviceserver.properties ]; then
       rm deviceserver.properties 2>&1 1> /dev/null
   fi
   if [ -f gateway.properties ]; then
       rm gateway.properties 2>&1 1> /dev/null
   fi
   ln -s ../../mds/connector-bridge/conf/gateway.properties .
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
    cd /home/arm/mds/connector-bridge
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
    # update-alternatives --set java /usr/lib/jvm/java-8-oracle/jre/bin/java
    # update-alternatives --set java /usr/lib/jvm/java-7-oracle/jre/bin/java
    echo "Using OpenJDK 7 JRE..."
}

setup_crontab() {
    su -l arm -s /bin/bash -c "crontab /home/arm/crontab"
}

cleanup()
{
   /bin/rm -f /home/arm/configure_instance.sh 2>&1 1>/dev/null
}

main() 
{
    setup_locale
    setup_bridge
    setup_configurator
    setup_ssh
    setup_aws_cli
    setup_passwords
    setup_sudoers
    setup_java
    setup_crontab
    cleanup
}

main $*
