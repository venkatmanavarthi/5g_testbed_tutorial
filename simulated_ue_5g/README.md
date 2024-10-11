# OAI 5G CN + Simulated UE

#### Requirements
    1. Ubuntu Server 22.04
    2. Docker

#### Initial Setup 
<a href="https://docs.docker.com/engine/install/ubuntu/">Install Docker</a><br>
<a href="https://docs.docker.com/engine/install/linux-postinstall/">Docker Post Installation Steps on Linux</a>

#### Clone the Repository
    git clone https://github.com/venkatmanavarthi/5g_testbed_tutorial
    cd 5g_testbed_tutorial/simulated_ue_5g

#### Pulling all the container images
    docker pull mysql:8.0
    docker pull oaisoftwarealliance/oai-amf:v2.0.0
    docker pull oaisoftwarealliance/oai-smf:v2.0.0
    docker pull oaisoftwarealliance/oai-upf:v2.0.0
    docker pull oaisoftwarealliance/trf-gen-cn5g:focal
    docker pull oaisoftwarealliance/oai-gnb:develop
    docker pull oaisoftwarealliance/oai-nr-ue:develop

#### Running the CN Control Plane
    docker compose up -d mysql oai-amf oai-smf oai-upf oai-ext-dn
    docker compose ps -a
![](./images%20/2.png)
![](./images%20/4.png)

#### Start the gNB
    docker compose up -d oai-gnb
    # check if gNB appeared in amf logs
    docker logs rfsim5g-oai-amf
![](./images%20/3.png)
![](./images%20/5.png)


#### Start the UE
    docker compose up -d oai-nr-ue
    # check if UE registed with amf
    docker logs rfsim5g-oai-amf
![](./images%20/6.png)

#### ifconfig on UE
    docker exec -it rfsim5g-oai-nr-ue /bin/bash
![](./images%20/7.png)

#### Iperf test
```
# Start iperf server on UE
docker exec -it rfsim5g-oai-nr-ue /bin/bash
iperf -B 12.1.1.2 -u -i 1 -s
```
![](./images%20/ue.png)
```
# iperf client on data network container
docker exec -it rfsim5g-oai-ext-dn /bin/bash
iperf -c 12.1.1.2 -u -i 1 -t 20 -b 10M
```
![](./images%20/dn.png)


#### Clean Up
    docker compose down
