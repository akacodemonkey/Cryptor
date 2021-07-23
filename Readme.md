## two containers that allows files to be shared securely 

Build will generate two containers with a paired public key in one (encryptor) and a private key in the other (decryptor).

encrypt file

````bash
docker run -v ${PWD}:/files encryptor:1.0 -f /files/test.txt
````

This will result in the creation of a `protected.zip` file containing the original file symmetrically encrypted and a second file containing the symmetrical key, symmetriclly encrypted.

To decrypt

````bash
docker run -v ${PWD}:/files decryptor:1.0 -f /files/protected.zip
````

Just an exercise in bash and multistage docker builds really