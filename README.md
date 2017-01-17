mbed Device Connector integration bridge image importer for AWS IoT Device Gateway 

Original Date: May 3, 2016

1/17/2017: Updated with the latest bridge. Happy New Year!

Container Bridge source (Apache 2.0 licensed - Enjoy!): https://github.com/ARMmbed/connector-bridge.git


Container Bridge Instance Installation:

1). Clone this repo into a Linux instance that supports docker images

2). cd into the cloned repo and run: ./run-reload-bridge.sh


If Starting on a non-EC2 Docker instance: 

3). Note the public IP address of your linux runtime - update "start-bridge.sh" and replace "192.168.1.230" with yours

4). invoke: ./start-bridge.sh

If Starting on an EC2 Docker instance:

3). invoke: ./start-bridge-aws-ec2.sh

Once the container instance is live, you must configure the bridge and bind it between your mbed Connector account and your IoT Account in AWS

<<< TBD>>>

2). Create your IAM Access Key ID and Secret Access Key to enable the AWS CLI in your container. Record those values
    You will also need to record the region of your service (i.e. us-east-1, us-west-2, etc...). Please record that as well. 
    For more information on creating the KeyID and Access Key see: https://aws.amazon.com/cli/

3). Next go to https://connector.mbed.com and create your mbed Connector Account

4). Once your Connector account is created, you need to "Access Keys" to create a Connector API Key/Token. Record the Token Value

Now that you have your:

    - AWS Region (i.e. us-east-1)
    
    - AWS Access Key ID for the AWS IoT CLI

    - AWS Secret Access Key for the AWS IoT CLI

    - Connector API Key/Token generated

Go to:  https://[[your containers public IP address]]:8234

    - username: "admin" (no quotes)

    - password: "admin" (no quotes)

Enter each of Key ID, Access Key, and Connector API Token

    - Please press "SAVE" after *each* is entered... 

    - After all 4 are entered and saved, press "RESTART"

Your AWSIoT-Connector bridge should now be configured and operational. 

For your mbed endpoint, you can clone and build (via yotta) this: https://github.com/ARMmbed/mbed-ethernet-sample

    - This sample assumes you are using the NXP K64F + mbed Application Shield

Enjoy!

Current Known Issues:

    - 5/6/2016: In the MQTT Console of AWS IoT, please do not enter the clientID corresponding to the endpoint name of your device. Doing so will 
      kick your bridge off of the MQTT broker. The workaround is to first "deregister" the device (SW2 pressed in the sample code above), then 
      reset the device. 

    - 5/6/2016: The bridge makes a best effort to clean out unused or orphaned certificates but there are instances where some cannot be cleaned 
      out and must be detached/dactivated manually. 


Copyright 2015. ARM Ltd. All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. 
