#!/bin/bash

docker build -f DockerFile-ssl -t creator:1.0 .

docker build -f DockerFile-decrypt -t akacodemonkey/decryptor:1.0 .

docker build -f DockerFile-encrypt -t akacodemonkey/encryptor:1.0 .