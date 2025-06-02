FROM openjdk:8-jdk-slim

ENV ELASTIC_VERSION=6.7.2

# Install dependencies
RUN apt-get update && apt-get install -y wget gnupg && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ELASTIC_VERSION.deb && \
    dpkg -i elasticsearch-$ELASTIC_VERSION.deb && \
    rm elasticsearch-$ELASTIC_VERSION.deb

# Configure Elasticsearch
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

EXPOSE 9200 9300
VOLUME ["/usr/share/elasticsearch/data"]
CMD ["/usr/share/elasticsearch/bin/elasticsearch"]