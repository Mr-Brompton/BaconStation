#!/bin/bash
gnome-terminal -- bash -c "docker compose up; exec bash"
mongoimport --authenticationDatabase=admin --db baconstation --collection movies --file /home/mumble/Documents/Projects/BaconStation/data/movies.json --username admin