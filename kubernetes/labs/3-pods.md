# Creating and managing pods

At the core of Kubernetes is the Pod. Pods represent a logical application and hold a collection of one or more containers and volumes. In this lab you will learn how to:

* Write a Pod configuration file
* Create and inspect Pods
* Interact with Pods remotely using kubectl

In this lab you will create a Pod named `demo-app` and interact with it using the kubectl command line tool.

## Tutorial: Creating Pods

Explore the `demo-app` pod configuration file [../resources/pods/demo-app.yaml](../resources/pods/demo-app.yaml):

```
cat pods/demo-app.yaml
```

Create the `demo-app` pod using kubectl:

```
kubectl create -f pods/demo-app.yaml
```

## Exercise: View Pod details

Use the `kubectl get` and `kubect describe` commands to view details for the `demo-app` Pod:

### Quiz

* What is the IP address of the `demo-app` Pod?
* What node is the `demo-app` Pod running on?
* What containers are running in the `demo-app` Pod?
* What are the labels attached to the `demo-app` Pod?
* What arguments are set on the `app` container?

## Exercise: Interact with a Pod remotely

Pods are allocated a private IP address by default and cannot be reached outside of the cluster. Use the `kubectl port-forward` command to map a local port to a port inside the `demo-app` pod.

### Hints

Use two terminals. One to run the `kubectl port-forward` command, and the other to issue `curl` commands.

```
kubectl port-forward demo-app 10080:80
```

```
curl http://127.0.0.1:10080
```

```
curl http://127.0.0.1:10080/secure
```

```
curl -u user http://127.0.0.1:10080/login
```

> Type "password" at the prompt.

```
curl -H "Authorization: Bearer <token>" http://127.0.0.1:10080/secure
```

> Use the JWT token from the previous login.

## Exercise: View the logs of a Pod

Use the `kubectl logs` command to view the logs for the `demo-app` Pod:

```
kubectl logs demo-app
```

> Use the -f flag and observe what happens.

## Exercise: Run an interactive shell inside a Pod

Use the `kubectl exec` command to run an interactive shell inside the `demo-app` Pod:

```
kubectl exec demo-app --stdin --tty -c app -- /bin/sh
```

or (for short)

```
kubectl exec -ti demo-app -c app -- /bin/sh
```

### Quiz
* What does the ```-c app``` do?

## Exercise: Interact with a Pod remotely

Create your own pod running the ubuntu:precise image. Remember to delete it when you are done.

## Summary

In this lab you learned how to create and interact with pods.