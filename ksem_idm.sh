#!/bin/bash

# please use your local IPs here
ip_ksem=192.168.2.10
ip_idm=192.168.2.18

# read KSEM (Adress 4) (KSEM Software Version 1.2.1)
output_ksem=$(mbpoll -r 4 -c 1 -1 $ip_ksem)

# extract the actual value
#echo $output_ksem
output_ksem_array=($output_ksem)
fed_in_energy=${output_ksem_array[-1]}

# we need to ignore the value in brackets if it exists
#echo $fed_in_energy
if [[ $fed_in_energy == *"("* ]]; then
  #echo "ignoring $fed_in_energy"
  fed_in_energy=${output_ksem_array[-2]}
fi

# need to divide to get kW
fed_in_energy=$(echo "scale=4; $fed_in_energy/10000" | bc -l )

# print it out
now=$(date +"%d.%m.%Y %T")
echo "$now - current fed-in energy from KSEM $ip_ksem (kW): " $fed_in_energy

# send value to iDM pump (Adress 74) (-0: First reference is 0 (PDU addressing) instead 1)
output_idm=$(mbpoll -0 -r 74 -t 4:float $ip_idm $fed_in_energy)

# check for "Written 1 references"
#echo $output_idm
now=$(date +"%d.%m.%Y %T")
if [[ $output_idm == *"Written 1 references"* ]]; then
  echo "$now - successfully send $fed_in_energy (kW) to iDM $ip_idm"
else
  echo "$now - failed sending $fed_in_energy to $ip_idm"
  echo $output_idm
fi

# now we want to read the updated value
output_idm=$(mbpoll -0 -r 74 -c 1 -1 -t 4:float $ip_idm)

# extract the actual value
#echo $output_idm
output_idm_array=($output_idm)
output_idm_energy=${output_idm_array[-1]}

# print it out
now=$(date +"%d.%m.%Y %T")
echo "$now - read value iDM (kW): " $output_idm_energy

# now we want to read the expexted load
output_idm=$(mbpoll -0 -r 4122 -c 2 -1 -t 4:float $ip_idm)

# extract the actual value
#echo $output_idm
output_idm_array=($output_idm)
output_idm_energy=${output_idm_array[-1]}

# print it out
now=$(date +"%d.%m.%Y %T")
echo "$now - read load iDM (kW): " $output_idm_energy





