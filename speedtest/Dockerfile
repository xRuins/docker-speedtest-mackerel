FROM python:3.5-alpine
LABEL MAINTAINER Ruins <ruinscorocoro+gh@gmail.com>

ARG SCRIPT_DESTINATION="/usr/local/bin/post-speedtest-mackerel.sh"
ARG CRON_TIME_DESCRIPTOR
ARG APIKEY
ARG SERVER_ID
ARG SERVICE_NAME

COPY docker-entrypoint.sh /
COPY post-speedtest-mackerel.sh $SCRIPT_DESTINATION
RUN set -x \
    	&& chmod u+x docker-entrypoint.sh \
    	&& chmod u+x $SCRIPT_DESTINATION \
	&& apk update \
    	&& apk add dcron curl \
	&& easy_install speedtest-cli \
    	&& echo "${CRON_TIME_DESCRIPTOR} ${SCRIPT_DESTINATION} ${APIKEY} ${SERVICE_NAME} ${SERVER_ID}" \
	   >> /etc/crontabs/root \
        && chmod 0644 /etc/crontabs/root
CMD ["/docker-entrypoint.sh"]
