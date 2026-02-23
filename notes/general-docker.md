# Docker Commands

## Create an Ubuntu Server Container (24.04 LTS)

Create the `.env` file based on the example provided in [env.example](env.example).

Execute the following command in the terminal to build the Linux (Ubuntu) Server image and then use the image to create the container:

```shell
docker compose \
  -f docker-compose-dev.yaml \
  up -d ubuntu-server
```

And then execute the following to access the bash terminal inside the container:

```shell
docker exec -it --user student customized-ubuntu-server-homelab bash
```

## Create a PostgreSQL Container

```shell
docker run -e POSTGRES_PASSWORD=mysecretpassword -d postgres
```

### Create a different version of PostgreSQL (14.7)

```shell
docker run -e POSTGRES_PASSWORD=mysecretpassword -d postgres:14.7
```

## Create a Redis Container (8.4.0)

```shell
docker pull redis:8.4.0
```

To view list of images

```shell
docker run
```

To start
