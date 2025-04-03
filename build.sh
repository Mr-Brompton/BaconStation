#!/bin/bash
docker-compose build
gnome-terminal -- bash -c "docker compose up --build; exit; exec bash"
mongoimport --authenticationDatabase=admin --db baconstation --collection movies --file /home/mumble/Documents/Projects/BaconStation/data/movies.json --username admin