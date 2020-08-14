#!/bin/bash
/opt/Purity/bin/puredb tune --clear
/opt/Purity/bin/pureadm stop
rm -f /root/*.bdev
. /usr/lib/python2.7/dist-packages/pure/tests/jenkins/configs/workload_vm.cfg
. /usr/lib/python2.7/dist-packages/pure/tests/jenkins/configs/platform_vm.cfg
/opt/Purity/bin/pureadm tune PURITY_TEST 1
/opt/Purity/bin/pureadm tune PS_PREFER_AIO 1
/opt/Purity/bin/pureadm tune PS_STORAGE_FILES 1
/opt/Purity/bin/pureadm tune PS_SSDRESET_NUM_NVRAM 4
/opt/Purity/bin/pureadm tune PS_SSDRESET_NUM_SSD 20
/opt/Purity/bin/pureadm tune PS_SSDRESET_NUM_CACHE 0
/opt/Purity/bin/pureadm tune PS_MAX_DEVICES_OVERRIDE 24
#/opt/Purity/bin/pureadm tune PS_SSDRESET_NVRAM_SIZE_MB 2048
/opt/Purity/bin/pureadm tune PS_SSDRESET_SSD_SIZE_MB 6216
/opt/Purity/bin/pureadm tune PS_STORAGE_CAPACITY_OVERRIDE_GB 200
/opt/Purity/bin/pureadm tune PS_SYNCREP_ENABLED 1
/opt/Purity/bin/pureadm lo-mem enable
rmmod ps_bdrv
. /etc/default/purity
cd /root
export PS_STORAGE_FILES=1
reset_apartment -f THIS_IS_BEING_USED_AS_A_PART_OF_TEST_INFRASTRUCTURE_OR_MY_RESUME_IS_UP_TO_DATE
pureadm start
sleep 10

purenetwork setattr --servicelist management ct0.eth0
purenetwork setattr --servicelist iscsi ct0.eth1
purenetwork setattr --servicelist replication ct0.eth2
purenetwork setattr --mode static ct0.eth0
purenetwork setattr --mode static ct0.eth1
purenetwork setattr --mode static ct0.eth2
purenetwork setattr --mode static ct0.eth3
purenetwork setattr --mode static ct0.eth4
purenetwork enable ct0.eth0
purenetwork enable ct0.eth1
purenetwork enable ct0.eth2
purenetwork enable ct0.eth3
purenetwork enable ct0.eth4 

