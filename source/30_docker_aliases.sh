#!/usr/bin/env zsh

# docker cleanup helpers
alias docker-containers-stop='[[ "$(docker ps -a -q)" != "" ]] && docker stop $(docker ps -a -q); true'
alias docker-containers-remove='docker-containers-stop && [[ "$(docker ps -a -q)" != "" ]] && docker rm $(docker ps -a -q); true'
alias docker-volumes-remove='docker-containers-remove && [[ "$(docker volume ls -f dangling=true -q)" != "" ]] && docker volume rm $(docker volume ls -f dangling=true -q); true'
alias docker-images-remove='[[ "$(docker images -a -q)" != "" ]] && docker rmi -f $(docker images -a -q); true'
alias docker-clean='docker-containers-stop; docker-containers-remove; docker-volumes-remove; docker-images-remove; docker system prune -f -a; true'

function docker-restart () {
  docker container restart $(docker ps -a | grep $1 | awk '{print $1}')
}

function docker-logs () {
  docker logs -f $(docker ps -a | grep $1 | awk '{print $1}') --tail 100
}

function dock() {
  case $1 in
    # https://github.com/localstack/localstack
    # API Gateway at http://localhost:4567
    # Kinesis at http://localhost:4568
    # DynamoDB at http://localhost:4569
    # DynamoDB Streams at http://localhost:4570
    # Elasticsearch at http://localhost:4571
    # S3 at http://localhost:4572
    # Firehose at http://localhost:4573
    # Lambda at http://localhost:4574
    # SNS at http://localhost:4575
    # SQS at http://localhost:4576
    # Redshift at http://localhost:4577
    # ES (Elasticsearch Service) at http://localhost:4578
    # SES at http://localhost:4579
    # Route53 at http://localhost:4580
    # CloudFormation at http://localhost:4581
    # CloudWatch at http://localhost:4582
    # SSM at http://localhost:4583
    localstack)
      docker run \
        --init \
        --name 'dock_localstack' \
        --publish '4566:4566' \
        --env 'SERVICES=s3' \
        --env 'DOCKER_HOST=unix:///var/run/docker.sock' \
        localstack/localstack
        # --volume '/private/tmp/localstack:/tmp/localstack' \
        # --volume '/var/run/docker.sock:/var/run/docker.sock' \
      docker stop 'dock_localstack'
      docker rm --volumes 'dock_localstack'
      ;;

    # https://hub.docker.com/_/mongo/
    mongo)
      echo 'mongodb://localhost:27017'
      echo ''
      if is_apple_silicon; then local image="arm64v8/mongo:latest"; else local image="mongo:latest"; fi
      docker run \
        --name 'dock_mongo' \
        --publish '27017:27017' \
        $image
        # --volume "$(pwd)/.data/mongo:/data/db" \
      docker stop 'dock_mongo'
      docker rm --volumes 'dock_mongo'
      ;;
    mongo-store)
      echo 'mongodb://localhost:27017'
      echo ''
      if is_apple_silicon; then local image="arm64v8/mongo:latest"; else local image="mongo:latest"; fi
      docker run \
        --name 'dock_mongo' \
        --publish '27017:27017' \
        --volume "$(pwd)/.data/mongo:/data/db" \
        $image
      docker stop 'dock_mongo'
      docker rm --volumes 'dock_mongo'
      ;;

    # https://hub.docker.com/_/redis/
    redis)
      echo 'redis://127.0.0.1:6359'
      echo ''
      if is_apple_silicon; then local image="arm64v8/redis:alpine"; else local image="redis:alpine"; fi
      docker run \
        --name 'dock_redis' \
        --publish '6379:6379' \
        $image
        # --volume "$(pwd)/.data/redis:/data"
      docker stop 'dock_redis'
      docker rm --volumes 'dock_redis'
      ;;
    redis-store)
      echo 'redis://127.0.0.1:6359'
      echo ''
      if is_apple_silicon; then local image="arm64v8/redis:alpine"; else local image="redis:alpine"; fi
      docker run \
        --name 'dock_redis' \
        --publish '6379:6379' \
        --volume "$(pwd)/.data/redis:/data"
        $image
      docker stop 'dock_redis'
      docker rm --volumes 'dock_redis'
      ;;

    # https://hub.docker.com/_/postgres/
    postgres)
      echo 'postgres://postgres:postgres@localhost:5432/postgres'
      echo ''
      if is_apple_silicon; then local image="arm64v8/postgres:alpine"; else local image="postgres:alpine"; fi
      docker run \
        --name 'dock_postgres' \
        --publish '5432:5432' \
        --env 'POSTGRES_USER=postgres' \
        --env 'POSTGRES_PASSWORD=postgres' \
        --env 'POSTGRES_DB=postgres' \
        $image
        # --volume "$(pwd)/.data/postgres:/var/lib/postgresql/data" \
      docker stop 'dock_postgres'
      docker rm --volumes 'dock_postgres'
      ;;

    postgres-store)
      echo 'postgres://postgres:postgres@localhost:5432/postgres'
      echo ''
      if is_apple_silicon; then local image="arm64v8/postgres:alpine"; else local image="postgres:alpine"; fi
      docker run \
        --name 'dock_postgres' \
        --publish '5432:5432' \
        --env 'POSTGRES_USER=postgres' \
        --env 'POSTGRES_PASSWORD=postgres' \
        --env 'POSTGRES_DB=postgres' \
        --volume "$(pwd)/.data/postgres:/var/lib/postgresql/data" \
        $image
      docker stop 'dock_postgres'
      docker rm --volumes 'dock_postgres'
      ;;

    # https://hub.docker.com/_/nats-streaming/
    nats-streaming)
      echo 'nats://localhost:4222'
      echo 'http://localhost:8222'
      echo ''
      docker run \
        --name 'dock_nats-streaming' \
        --publish '4222:4222' \
        --publish '8222:8222' \
        nats-streaming:latest -store file -dir '/datastore' -m 8222
        # --volume "$(pwd)/.data/nats-streaming:/datastore" \
      docker stop 'dock_nats-streaming'
      docker rm --volumes 'dock_nats-streaming'
      ;;
    nats-streaming-store)
      echo 'nats://localhost:4222'
      echo 'http://localhost:8222'
      echo ''
      docker run \
        --name 'dock_nats-streaming' \
        --publish '4222:4222' \
        --publish '8222:8222' \
        --volume "$(pwd)/.data/nats-streaming:/datastore" \
        nats-streaming:latest -store file -dir '/datastore' -m 8222
      docker stop 'dock_nats-streaming'
      docker rm --volumes 'dock_nats-streaming'
      ;;

    # https://www.docker.elastic.co
    elasticsearch)
      echo 'http://elastic:changeme@localhost:9200'
      echo ''
      docker run \
        --name 'dock_elasticsearch' \
        --publish '9200:9200' \
        --publish '9300:9300' \
        --env 'discovery.type=single-node' \
        docker.elastic.co/elasticsearch/elasticsearch:7.9.3
        # --volume "$(pwd)/.data/elasticsearch:/usr/share/elasticsearch/data" \
      docker stop 'dock_elasticsearch'
      docker rm --volumes 'dock_elasticsearch'
      ;;
    elasticsearch-store)
      echo 'http://elastic:changeme@localhost:9200'
      echo ''
      docker run \
        --name 'dock_elasticsearch' \
        --publish '9200:9200' \
        --publish '9300:9300' \
        --env 'discovery.type=single-node' \
        --volume "$(pwd)/.data/elasticsearch:/usr/share/elasticsearch/data" \
        docker.elastic.co/elasticsearch/elasticsearch:7.9.3
      docker stop 'dock_elasticsearch'
      docker rm --volumes 'dock_elasticsearch'
      ;;

    # https://maildev.github.io/maildev/
    maildev)
      echo 'smtp://localhost:1025/?ignoreTLS=true'
      echo ''
      docker run \
        --name 'dock_maildev' \
        --publish '1080:80' \
        --publish '1025:25' \
        maildev/maildev
      docker stop 'dock_maildev'
      docker rm --volumes 'dock_maildev'
      ;;

    *)
      echo "Unknown dock: '${1}'"
      echo "supported docks:"
      echo "  localstack"
      echo "  mongo"
      echo "  mongo-store"
      echo "  redis"
      echo "  redis-store"
      echo "  postgres"
      echo "  postgres-store"
      echo "  nats-streaming"
      echo "  nats-streaming-store"
      echo "  elasticsearch"
      echo "  elasticsearch-store"
      echo "  maildev"
      echo ""
      ;;
  esac
}
