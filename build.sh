#!/bin/bash

docker build -f DockerFile-ssl -t creator:1.0 .

docker build -f DockerFile-decrypt -t decryptor:1.0 .

docker build -f DockerFile-encrypt -t encryptor:1.0 .