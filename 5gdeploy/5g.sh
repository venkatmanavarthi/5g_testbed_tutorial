#!/bin/bash

# combinations for the tests
TEST_COMBINATION=(
    "--cp=free5gc --up=free5gc --ran=gnbsim" 
    "--cp=free5gc --up=free5gc --ran=oai" 
    "--cp=free5gc --up=free5gc --ran=packetrusher"
    "--cp=free5gc --up=free5gc --ran=srsran"
    "--cp=free5gc --up=free5gc --ran=ueransim"
    "--cp=oai --up=oai --ran=gnbsim"
    "--cp=oai --up=oai --ran=oai"
    "--cp=oai --up=oai --ran=ueransim"
    "--cp=oai --up=oai-vpp --ran=oai"
    "--cp=oai --up=oai-vpp --ran=packetrusher"
    "--cp=oai --up=oai-vpp --ran=ueransim"
    "--cp=open5gs --up=open5gs --ran=oai"
    "--cp=open5gs --up=open5gs --ran=packetrusher"
    "--cp=open5gs --up=open5gs --ran=srsran"
    "--cp=open5gs --up=open5gs --ran=ueransim"
)


# running performance test on each combination
for each_test in "${TEST_COMBINATION[@]}"; do    
    echo "Running " $each_test
    
    psuhd ~/5gdeploy/scenario

    ./generate.sh 20231017 \
    +gnbs=2 +phones=1 +vehicles=1 \
    $each_test


    popd

    # getting scenario up
    psuhd ~/compose
    bash compose.sh up
    

    #generate the test


    # move the test result


    # dismantle the scenario
    bash compose.sh down
    popd
    
    # remove the scenario configurations
    rm -rf ~/compose
done