FROM ubuntu:latest

#RUN apt-get update\
# && apt-get install -y curl

COPY akey_version_update.sh .
COPY kube_original.yaml . 
