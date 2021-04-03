FROM debian:stable-slim

# install wget, gnupg2, software-properties-common, bc, cron and mbpoll
RUN apt update
RUN apt -y upgrade
RUN apt -y install wget gnupg2 software-properties-common bc cron
RUN wget -O- http://www.piduino.org/piduino-key.asc | apt-key add -
RUN add-apt-repository 'deb http://apt.piduino.org stretch piduino'
RUN apt update
RUN apt -y install mbpoll

# copy files
COPY ksem_idm.sh /app/ksem_idm.sh
COPY ksem_idm_cron /etc/cron.d/ksem_idm_cron

# set workdir
WORKDIR /app

# give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/ksem_idm_cron

# apply cron job
RUN crontab /etc/cron.d/ksem_idm_cron

# run the command on container startup
CMD ["cron", "-f"]
