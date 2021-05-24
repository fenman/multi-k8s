docker build -t dickfennema/multi-client-k8s:latest -t dickfennema/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t dickfennema/multi-server-k8s:latest -t dickfennema/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t dickfennema/multi-worker-k8s:latest -t dickfennema/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push dickfennema/multi-client-k8s:latest
docker push dickfennema/multi-server-k8s-pgfix:latest
docker push dickfennema/multi-worker-k8s:latest

docker push dickfennema/multi-client-k8s:$SHA
docker push dickfennema/multi-server-k8s:$SHA
docker push dickfennema/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dickfennema/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=dickfennema/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=dickfennema/multi-worker-k8s:$SHA