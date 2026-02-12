# GitHub Theme Test Dockerfile
FROM ubuntu:24.04

LABEL maintainer="Raimu"
ENV DEBIAN_FRONTEND=noninteractive
ENV APP_VERSION=1.0.0

RUN apt-get update && apt-get install -y \
    vim \
    curl \
    git

WORKDIR /app
COPY . /app

EXPOSE 8080
CMD ["python3", "app.py"]
