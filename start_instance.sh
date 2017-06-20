#!/bin/bash

update_hosts()
{
    sudo /home/arm/update_hosts.sh
    rm /home/arm/update_hosts.sh
}

run_supervisord()
{
   /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf 2>&1 1>/tmp/supervisord.log
}

run_connector_bridge()
{
   cd /home/arm
   su -l arm -s /bin/bash -c "/home/arm/restart.sh &"
}

run_properties_editor()
{
  cd /home/arm/properties-editor
  su -l arm -s /bin/bash -c "/home/arm/properties-editor/runPropertiesEditor.sh 2>&1 1> /tmp/properties-editor.log &"
}

enable_long_polling() {
   LONG_POLL="$2"
   if [ "${LONG_POLL}" = "use-long-polling" ]; then
        DIR="connector-bridge/conf"
        FILE="service.properties"
        cd /home/arm
        sed -e "s/mds_enable_long_poll=false/mds_enable_long_poll=true/g" ${DIR}/${FILE} 2>&1 1> ${DIR}/${FILE}.new
        mv ${DIR}/${FILE} ${DIR}/${FILE}.poll
        mv ${DIR}/${FILE}.new ${DIR}/${FILE}
        chown arm.arm ${DIR}/${FILE}
   fi
}

set_mdc_api_token() {
   API_TOKEN="$2"
   if [ "$2" = "use-long-polling" ]; then
        API_TOKEN="$3"
   fi
   if [ "${API_TOKEN}X" != "X" ]; then
        DIR="connector-bridge/conf"
        FILE="service.properties"
        cd /home/arm
        sed -e "s/mbed_connector_api_token_goes_here/${API_TOKEN}/g" ${DIR}/${FILE} 2>&1 1> ${DIR}/${FILE}.new
        mv ${DIR}/${FILE} ${DIR}/${FILE}.mdc_api_token
        mv ${DIR}/${FILE}.new ${DIR}/${FILE}
        chown arm.arm ${DIR}/${FILE}
   fi
}

set_aws_iot_region() {
   REGION="$3"
   if [ "$2" = "use-long-polling" ]; then
        REGION="$4"
   fi
   if [ "${REGION}X" != "X" ]; then
        DIR="connector-bridge/conf"
        FILE="service.properties"
        cd /home/arm
        sed -e "s/AWS_region_goes_here/${REGION}/g" ${DIR}/${FILE} 2>&1 1> ${DIR}/${FILE}.new
        mv ${DIR}/${FILE} ${DIR}/${FILE}.aws_iot_region
        mv ${DIR}/${FILE}.new ${DIR}/${FILE}
        chown arm.arm ${DIR}/${FILE}
   fi
}

set_aws_iot_access_key_id() {
   ACCESS_KEY="$4"
   if [ "$2" = "use-long-polling" ]; then
        ACCESS_KEY="$5"
   fi
   if [ "${ACCESS_KEY}X" != "X" ]; then
        DIR="connector-bridge/conf"
        FILE="service.properties"
        cd /home/arm
        sed -e "s/AWS_Access_Key_ID_goes_here/${ACCESS_KEY}/g" ${DIR}/${FILE} 2>&1 1> ${DIR}/${FILE}.new
        mv ${DIR}/${FILE} ${DIR}/${FILE}.aws_iot_access_key_id
        mv ${DIR}/${FILE}.new ${DIR}/${FILE}
        chown arm.arm ${DIR}/${FILE}
   fi
}

set_aws_iot_access_key_secret() {
   ACCESS_KEY_SECRET="$5"
   if [ "$2" = "use-long-polling" ]; then
        ACCESS_KEY_SECRET="$6"
   fi
   if [ "${ACCESS_KEY_SECRET}X" != "X" ]; then
        DIR="connector-bridge/conf"
        FILE="service.properties"
        cd /home/arm 
        sed -e "s/AWS_Secret_Access_Key_goes_here/${ACCESS_KEY_SECRET}/g" ${DIR}/${FILE} 2>&1 1> ${DIR}/${FILE}.new
        mv ${DIR}/${FILE} ${DIR}/${FILE}.aws_iot_access_key_secret
        mv ${DIR}/${FILE}.new ${DIR}/${FILE}
        chown arm.arm ${DIR}/${FILE}
   fi
}

set_aws_creds() {
   REGION="$3"
   ACCESS_KEY="$4"
   ACCESS_KEY_SECRET="$5"
   if [ "$2" = "use-long-polling" ]; then
        REGION="$4"
        ACCESS_KEY="$5"
        ACCESS_KEY_SECRET="$6"
   fi
   if [ "${REGION}X" != "X" ]; then
       cd /home/arm
       su -l arm -s /bin/bash -c "/home/arm/configurator/scripts/set_aws_creds.sh ${REGION} ${ACCESS_KEY} ${ACCESS_KEY_SECRET}" 
   fi
}

set_perms() {
  cd /home/arm
  chown -R arm.arm .
}

main() 
{
   update_hosts
   enable_long_polling $*
   set_mdc_api_token $*
   set_aws_iot_region $*
   set_aws_iot_access_key_id $*
   set_aws_iot_access_key_secret $*
   set_aws_creds $*
   set_perms $*
   run_properties_editor
   run_connector_bridge
   run_supervisord
}

main $*
