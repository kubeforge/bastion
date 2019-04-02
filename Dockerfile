FROM alpine:latest

RUN ["apk", "update"]
RUN ["apk", "upgrade", "--available"]

RUN ["apk", "add", "openssh"]

RUN ["mkdir", "-m", "600", "-p", "/root/.ssh"]
RUN sed -i -e "1iStrictModes no" -e "/^#/d;/^ *$/d"  /etc/ssh/sshd_config
RUN ["cp", "-a", "/etc/ssh", "/etc/ssh.cache"]
RUN ["rm", "-rf", "/var/cache/apk/*"]
RUN ["ssh-keygen", "-A"]

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]
