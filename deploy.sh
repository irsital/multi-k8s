docker build -t irsital/multi-client:latest -t irsital/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t irsital/multi-server:latest -t irsital/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t irsital/multi-worker:latest -t irsital/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push irsital/multi-client:latest
docker push irsital/multi-server:latest
docker push irsital/multi-worker:latest

docker push irsital/multi-client:$SHA
docker push irsital/multi-server:$SHA
docker push irsital/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=irsital/multi-client:$SHA
kubectl set image deployments/server-deployment server=irsital/multi-server:$SHA
kubectl set image deployments/worker-deployment server=irsital/multi-worker:$SHA
