FROM lironer/mongodb-tools:latest
RUN apt-get update && apt-get install -y cron python3
COPY mongoexport-job /etc/cron.d/mongoexport-job
COPY exporter-entrypoint.sh /usr/local/bin/exporter-entrypoint.sh
RUN chmod 0644 /etc/cron.d/mongoexport-job
RUN crontab /etc/cron.d/mongoexport-job
RUN chmod +x /usr/local/bin/exporter-entrypoint.sh
CMD ["/usr/local/bin/exporter-exporter-entrypoint.sh"]