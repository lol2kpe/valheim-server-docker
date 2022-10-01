#!/usr/bin/env bash

echo \ &&
echo "--- Stopping and deleting the Valheim server container ---" &&
echo \ &&
docker rm $(docker stop $(docker ps -a | grep valleballe-server | awk '{print $1}'))

echo \ &&
echo "--- Removing volume lol2kpe/valleballe-server ---" &&
echo \ &&
docker image rm lol2kpe/valleballe-server

echo \ &&
echo "--- Building / creating updated valleballe-server ---" &&
echo \ &&
docker build -t lol2kpe/valleballe-server . --no-cache

echo \ &&
echo "--- Creating container and starting server ---" &&
echo \ &&
./start_docker_valheim_server.sh

echo \ &&
echo "--- Valheim server should now be updated if no errors were present ---" &&
echo \