# ksem_idmpump
using TCP Modbus to send fed-in energy from Kostal Smart Energy Meter to iDM AERO SLM 6-17

### Linux usage (you might want to use directly with cron)
install bc and mbpoll [https://github.com/epsilonrt/mbpoll](https://github.com/epsilonrt/mbpoll)

adjust IPs in ksem_idm.sh file

```./ksem_idm.sh```

### Docker usage
adjust IPs in ksem_idm.sh file

adjust execution in ksem_idm_cron file

```sudo docker build -t ksem_idm:1.0 .```

```sudo docker run -d --name ksem_idm ksem_idm:1.0```

```sudo docker logs ksem_idm```

```sudo docker rm -f ksem_idm```

