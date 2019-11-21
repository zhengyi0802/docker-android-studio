#!/bin/bash

echo "checkout image if loaded in docker"
 result=`docker images|grep studio-bionic`
if [ -z "$result" ]; then
   echo "load image from harddisk"
   sudo docker load --input /work/docker/images/studio-bionic.tar
fi

echo "set privilege for X11"
setfacl -m user:1000:r ${HOME}/.Xauthority

echo "set /dev/kvm privilege"
sudo chmod 777 /dev/kvm

echo "docker run"
docker run -it --net=host --rm \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /work/Workspace:/work/Workspace \
       -v /work/Android:/work/Android \
       -v /work/home/puser:/home/puser \
       -v /dev/kvm:/dev/kvm \
       --privileged -v /dev/bus/usb:/dev/bus/usb \
       -e XAUTHORITY=$XAUTHORITY \
       -e DISPLAY=unix$DISPLAY \
       -e uid=1000 \
       -e gid=1000 \
       --name studio \
       chevylin0802/studio-bionic \
       /opt/android-studio/bin/studio.sh


