#!/bin/sh

run_bridge()
{
   cd /home/arm
   su -l arm -s /bin/bash -c "/home/arm/restart.sh"
}

main()
{
   run_bridge
}

main $*

