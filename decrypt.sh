#!/bin/bash
usage() { echo "Usage: $0 [-f encryptedFile]" 1>&2; exit 1;}
while getopts f: flag
do
    case "${flag}" in
        f) zipFile=${OPTARG};;
        \?) usage;;
        *) usage;;
    esac
done

if [ -z "${zipFile}" ]; then
    usage
fi

rm -rf /working
mkdir /working

targetDir="$(dirname "${zipFile}")"
unzip -q "${zipFile}" -d /working

openssl rsautl -decrypt -inkey /keys/private.pem -in /working/key.bin.enc -passin file:/keys/passphrase -out /app/key.bin

rm /working/key.bin.enc

for file in /working/*.enc; do
  fileName="$(basename "${file}")"
  newName=${fileName%".enc"}
  openssl enc -d -aes-256-cbc -in ${file} -out ${targetDir}/${newName} -pass file:/app/key.bin 
done
