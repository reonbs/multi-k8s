docker build -t reonbs/multi-client:latest -t reonbs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t reonbs/multi-server:latest -t reonbs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t reonbs/multi-worker:latest -t reonbs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push reonbs/multi-client:latest
docker push reonbs/multi-server:latest
docker push reonbs/multi-worker:latest

docker push reonbs/multi-client:$SHA
docker push reonbs/multi-server:$SHA
docker push reonbs/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=reonbs/multi-server:$SHA
kubectl set image deployments/client-deployment client=reonbs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=reonbs/multi-worker:$SHA



#lets know y
