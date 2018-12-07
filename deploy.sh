#!/bin/bash

echo "Building docker containers..."
docker build -t irsital/multi-client:latest -t irsital/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t irsital/multi-server:latest -t irsital/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t irsital/multi-worker:latest -t irsital/multi-worker:$SHA -f ./worker/Dockerfile ./worker

echo "Pushing tag:latest to dockerhub..."
docker push irsital/multi-client:latest
docker push irsital/multi-server:latest
docker push irsital/multi-worker:latest

echo "Pushing tag:${SHA} to dockerhub..."
docker push irsital/multi-client:$SHA
docker push irsital/multi-server:$SHA
docker push irsital/multi-worker:$SHA

echo "Applying configuration to Kubernetes..."
kubectl apply -f k8s

echo "Update kubenetes Deployments with new images..."
kubectl set image deployments/client-deployment server=irsital/multi-client:$SHA
kubectl set image deployments/server-deployment server=irsital/multi-server:$SHA
kubectl set image deployments/worker-deployment server=irsital/multi-worker:$SHA

echo "Done."
