FROM centos:latest

ARG USERUID
ARG USERGID
ARG USERNAME
ARG USERPASS
ARG ROOTPASS
ARG PORT
EXPOSE 22

RUN yum install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo "root:${ROOTPASS}" | chpasswd && \
    groupadd -r ${USERNAME} -g ${USERGID} && \
    useradd -u ${USERUID} \
        --no-log-init \
        -r \
        --create-home \
        --shell /bin/bash \
        -g ${USERNAME} \
        ${USERNAME} && \
    echo "${USERNAME}:${USERPASS}" | chpasswd && \
    # sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config && \
    # sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config && \
    /usr/bin/ssh-keygen -A

CMD ["/usr/sbin/sshd", "-D"]
