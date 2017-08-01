# These are commands to run software I don't necessarily want to setup on my
# machine, but could run in a docker container

# Elasticsearch
# auth = elastic:changeme
alias dock-elasticsearch='echo "username = elastic"; echo "password = changeme"; docker run -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" docker.elastic.co/elasticsearch/elasticsearch:5.5.1'

# MongoDB
# auth = n/a
alias dock-mongo='docker run -p 27017:27017 mongo:latest'

# Redis
# auth = n/a
alias dock-redis='docker run -p 6379:6379 redis:alpine'

# PostgreSQL
# auth = postgres:postgres
alias dock-postgres='echo "username = postgres"; echo "password = postgres"; docker run -p 5432:5432 -e "POSTGRES_PASSWORD=postgres" postgres:alpine'
