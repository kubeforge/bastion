FROM alpine:latest

RUN ["apk", "update"]
RUN ["apk", "upgrade", "--available"]

RUN ["apk", "add", "openssh", "shadow"]

RUN ["mkdir", "-m", "600", "-p", "/root/.ssh"]
RUN sed -i -e "1iPort 22" -e "1iStrictModes no" -e "/^#/d;/^ *$/d"  /etc/ssh/sshd_config
RUN ["cp", "-a", "/etc/ssh", "/etc/ssh.cache"]
RUN ["rm", "-rf", "/var/cache/apk/*"]
RUN ["ssh-keygen", "-A"]
RUN ["usermod", "-p", "''", "root"]

EXPOSE 22

COPY sshd_config /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-D", "-e"]
