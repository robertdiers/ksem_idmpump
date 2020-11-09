# ksem_idmpump
using TCP Modbus to send fed-in energy from Kostal Smart Energy Meter to iDM AERO SLM 6-17

### Docker usage
adjust IPs in ksem_idm.sh file

adjust execution in ksem_idm_cron file

```sudo docker build -t ksem_idm:1.0 .```

```sudo docker run ksem_idm:1.0```

