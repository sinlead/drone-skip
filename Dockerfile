FROM alpine/git
ADD check_latest.sh /bin/
RUN chmod +x /bin/check_latest.sh
ENTRYPOINT /bin/check_latest.sh
