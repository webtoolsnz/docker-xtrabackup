FROM debian:stretch-slim

LABEL maintainer="Jonathan Guo<jonathan@webtools.co.nz>"

ENV BACKUP_DIR="/backups/mysql"
ENV MYSQL_HOST="localhost"
ENV MYSQL_PORT="3306"
ENV MYSQL_USER="root"
ENV MYSQL_PASSWORD=""

# Copy backup script
COPY mysql-backup.sh /usr/local/bin/mysql-backup

# Ensure the backup script is executable
RUN chmod 700 /usr/local/bin/mysql-backup && \
# Install dependencies
    DEPENDENCIES="lsb-release wget gnupg2" && \
    apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y $DEPENDENCIES && \
# Install percona repository
    wget --no-check-certificate https://repo.percona.com/apt/percona-release_0.1-6.$(lsb_release -sc)_all.deb && \
    dpkg -i percona-release_0.1-6.$(lsb_release -sc)_all.deb && \
# Install percona xtrabackup and mysql-client
    apt-get autoclean && \
    apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    percona-xtrabackup-24 \
    mysql-client && \
# Tidy up
    rm -f percona-release_0.1-6.$(lsb_release -sc)_all.deb && \
    apt-get remove --purge -y ${DEPENDENCIES} && \
    rm -rf /var/lib/apt/lists/* && \
    unset DEPENDENCIES
