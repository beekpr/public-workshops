# Creating and Managing Services

Services provide stable endpoints for Pods based on a set of labels.

In this lab you will create the `demo-app` service and "expose" the `secure-demo-app` Pod externally. You will learn how to:

* Create a service
* Use label selectors to expose a limited set of Pods externally

With minikube the loadbalancer service type doesn't work as nicely as it does on a normal cloud provider.
If you run on one of AWS, Azure or Google it will provision a new ELB for you so you have a world accessible endpoint for your service.
The loadbalancer is connected to NodePort the service exposes and firewall rules are updated by cloud provider to make it all work.

You can simulate this behaviour by messing with your routes and DNS settings locally but it can be error prone so we will avoid it for this workshop.

## Tutorial: Create a Service

Explore the demo-app service configuration file:

```
cat services/demo-app.yaml 
```

Create the demo-app service using kubectl:

```
kubectl create -f services/demo-app.yaml
```

So if we were on AWS this would create an ELB behind the scenes and setup security groups so it all automatically works.


## Exercise: Verify service creation

What is the port it is bound to? What is the NodePort? What is the cluster ip? Other pods can reference the service by using its cluster ip.

## Exercise: Interact with the Demo App Service Remotely

> This will NOT work out the box as the pod is mis-configured - can you see why? Next Exercise will tell you what is wrong.

We can connect to there service by finding the ip of our minikube cluster ```export IP=$(minikube ip)``` and getting the NodePort from our service
```export PORT=$(kubectl get service demo-app -o jsonpath="{.spec.ports[0].nodePort}" )```

We could also use ```minikube service demo-app``` to open a browser window to service, you will need to update protocol to ```https```


### Hints

```
# From a pod running on node try this:
curl --insecure --connect-timeout 5 https://$IP:$PORT
```

### Quiz

* Why are you unable to get a response from the `demo-app` service?

## Exercise: Explore the demo-app Service

### Hints

```
kubectl get services demo-app
```

```
kubectl describe services demo-app
```

### Quiz

* How many endpoints does the `demo-app` service have?
* What labels must a Pod have to be picked up by the `demo-app` service?

## Tutorial: Add Labels to Pods

Currently the `demo-app` service does not have any endpoints. One way to troubleshoot an issue like this is to use the `kubectl get pods` command with a label query.

```
kubectl get pods -l "app=demo-app"
```

```
kubectl get pods -l "app=demo-app,secure=enabled"
```

> Notice this label query does not print any results

Use the `kubectl label` command to add the missing `secure=enabled` label to the `secure-demo-app` Pod.

```
kubectl label pods secure-demo-app 'secure=enabled'
```

View the list of endpoints on the `demo-app` service:

```
kubectl describe services demo-app
```

### Quiz

* How many endpoints does the `demo-app` service have?
* Can you make a request now?


## Tutorial: Remove Labels from Pods

In this exercise you will observe what happens when a required label is removed from a Pod.

Use the `kubectl label` command to remove the `secure` label from the `secure-demo-app` Pod.

```
kubectl label pods secure-demo-app secure-
```

View the list of endpoints on the `demo-app` service:

```
kubectl describe services demo-app
```

### Quiz

* How many endpoints does the `demo-app` service have?

## Summary

In this lab you learned how to expose Pods using services and labels.
