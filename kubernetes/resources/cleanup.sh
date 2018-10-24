kubectl delete -f deployments
kubectl delete -f nginx
kubectl delete -f pods
kubectl delete -f services
kubectl delete configmaps nginx-frontend-conf
kubectl delete configmaps nginx-proxy-conf
kubectl delete secrets tls-certs