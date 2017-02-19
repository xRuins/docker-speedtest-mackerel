# Detail

This repository includes docker-compose.yml and concerns to post speettest result for Mackerel.
The container genereted by docker-compose.yml will post throughput of your network as a service metrics.

# Configurations

Set several parameters to post Mackerel in `docker-compose.yml`.
The parameters is defined as build args.

## Parameters

* APIKEY
  - Mackerel API Key
* SERVICE_NAME
  - Name of service to post service metrics
* SERVER_ID
  - ID of server used in speedtest-cli
* CRON_TIME_DISCRIPTOR
  - Specification of the time when speedtest and posting are executed. The format equals to crond's one. (e.g. "0 * * *" executes a script per hour)
  To get list of server ids, execute `docker run --rm -it python:3.5-alpine sh -c "easy_install speedtest-cli && speedtest --list"` .
