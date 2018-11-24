#!/bin/bash

export local_path=/Users/lixiang/Documents/docker/docker_jmeter/test
export container_path=/test

rm ${local_path}/jmeter-server.log
rm ${local_path}/test.jtl 
rm ${local_path}/test.log

docker run \
  --net docker_jmeter_default \
  -v ${local_path}:${container_path} \
  jmeter_xl -X -n \
  -Jclient.rmi.localport=7000 \
  -R j-slave-1,j-slave-2 \
  -t ${container_path}/test.jmx \
  -l ${container_path}/test.jtl \
  -j ${container_path}/test.log \
  -Jv_data=${container_path}/data.csv
