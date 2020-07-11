FROM node:14.5.0-alpine3.10

# Will execute gravitee_boot.sh



RUN mkdir -p /app/runtime
# TODO : Inject K8S Secret SSH KEY PAIR from you gitlab user
COPY * /app/runtime
COPY gravitee_init_api.sh /gravitee-job/init
COPY gravitee_init_users.sh /gravitee-job/init



RUN apt-get update -y && apt-get install curl jq git openssh-server openssh-client

# TODO UDI GID mapping to non-root user
CMD [ "/app/runtime/boot.sh" ]
