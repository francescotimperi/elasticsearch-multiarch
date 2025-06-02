# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM openjdk:8-jdk-slim

ENV ELASTIC_VERSION=6.7.2

# Install dependencies
RUN apt-get update && apt-get install -y wget gnupg && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ELASTIC_VERSION.deb && \
    dpkg -i elasticsearch-$ELASTIC_VERSION.deb && \
    rm elasticsearch-$ELASTIC_VERSION.deb


# Create non-root user and set permissions
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch

# Set working directory and switch user
WORKDIR /usr/share/elasticsearch
USER elasticsearch

# Add config
COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

EXPOSE 9200 9300
VOLUME ["/usr/share/elasticsearch/data"]

ENV xpack.ml.enabled=false

CMD ["bin/elasticsearch"]