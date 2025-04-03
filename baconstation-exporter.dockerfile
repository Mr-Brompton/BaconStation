FROM lironer/mongodb-tools:latest
RUN apt-get update && apt-get install -y cron
COPY mongoexport-job /etc/cron.d/mongoexport-job
RUN chmod 0644 /etc/cron.d/mongoexport-job
RUN crontab /etc/cron.d/mongoexport-job
CMD ["cron", "-f"]