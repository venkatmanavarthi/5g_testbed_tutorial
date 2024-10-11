# OAI 5G CN + USRP B210 + COTS UE 

#### Requirements
    1. Ubuntu Server 22.04 # Intel CPU Preferred
    2. Docker
    3. USRP B200/B210
    4. 5G Supported Phone / Modem
    5. Programmable Sim Cards
    6. Sim Card Reader Writer

#### Docker Setup 
<a href="https://docs.docker.com/engine/install/ubuntu/">Install Docker</a><br>
<a href="https://docs.docker.com/engine/install/linux-postinstall/">Docker Post Installation Steps on Linux</a>

#### Note: Make sure USRP B210 is connected to server using USB 3.0, USRP B210 doesnt work on USB 2.0
#### Check USRP Connection
    lsusb
![](./images/usrp.png)


#### Clone the Repository
    git clone https://github.com/venkatmanavarthi/5g_testbed_tutorial
    cd 5g_testbed_tutorial/cots_ue_5g

#### Running the CN
    docker compose up -d
    docker ps -a
![](./images/1.png)
docker logs -f oai-amf
![](./images/2.png)

#### Running gNB (USRP B210) in docker container
```
docker run --rm --entrypoint='' -e PYTHONUNBUFFERED=1 -v /usr/local/share/uhd/images:/usr/local/share/uhd/images oaisoftwarealliance/oai-gnb:develop /opt/oai-gnb/bin/uhd_images_downloader.py
```
![](./images/4.png)
```
docker run --name gnb0 --rm --privileged --network host --entrypoint '' -v /dev:/dev -v /usr/local/share/uhd/images:/usr/local/share/uhd/images:ro -v gnbband78usrpb210.conf:/opt/oai-gnb/etc/gnb.conf:ro oaisoftwarealliance/oai-gnb:develop /opt/oai-gnb/bin/nr-softmodem -O /opt/oai-gnb/etc/gnb.conf --sa -E --continuous-tx
```
#### Clean Up
    docker compose down