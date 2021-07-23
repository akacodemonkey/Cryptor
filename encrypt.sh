#!/bin/bash
usage() { echo "Usage: $0 [-f file]" 1>&2; exit 1;}
while getopts f: flag
do
    case "${flag}" in
        f) file=${OPTARG};;
        \?) usage;;
        *) usage;;
    esac
done

if [ -z "${file}" ]; then
    usage
fi

rm -rf /working
mkdir /working

targetDir="$(dirname "${file}")"
fileName="$(basename "${file}")"

openssl rand -base64 32 > /app/key.bin
openssl rsautl -encrypt -inkey /keys/public.pem -pubin -in /app/key.bin -out /working/key.bin.enc 
openssl enc -aes-256-cbc -salt -in ${file} -out /working/${fileName}.enc -pass file:/app/key.bin 
cd //working || exit

zip -q ${targetDir}/protected.zip key.bin.enc ${fileName}.enc

