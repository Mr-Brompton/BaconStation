#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker volume prune
docker volume remove baconstation_baconstation-data