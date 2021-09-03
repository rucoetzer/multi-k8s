docker build -t rucoetzer/multi-client:latest -t rucoetzer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rucoetzer/multi-server:latest -t rucoetzer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rucoetzer/multi-worker:latest -t rucoetzer/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rucoetzer/multi-client:latest
docker push rucoetzer/multi-client:$SHA
docker push rucoetzer/multi-server:latest
docker push rucoetzer/multi-server:$SHA
docker push rucoetzer/multi-worker:latest
docker push rucoetzer/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=rucoetzer/multi-client:$SHA
kubectl set image deployments/server-deployment server=rucoetzer/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=rucoetzer/multi-worker:$SHA