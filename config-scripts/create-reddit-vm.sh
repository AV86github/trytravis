#!/bin/bash

gcloud compute instances create reddit-full \
--zone=europe-west3-c \
--machine-type=g1-small \
--subnet=default \
--tags=puma-server \
--image=reddit-full-1593076989 \
--image-project=infra-273514 \
--boot-disk-device-name=reddit-full \
--reservation-affinity=any \
--restart-on-failure
