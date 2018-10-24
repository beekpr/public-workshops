# Playing around with kubectl

## Cluster Info
Lets see if your cluster is up and running (shout if it is not)
```
$ kubectl cluster-info
```

## Explore the kubectl CLI

Check the health status of the cluster components:

```
$ kubectl get cs
```

List pods:

```
$ kubectl get pods
```

List services:

```
$ kubectl get services
```

### Quiz:
* How do we get a list of namespaces?
* How do we see what pods are running in kube-system namespace?
* How do we see all the labels associated with pods in kube-system namespace?
* How do we list nodes?
* How do we get the output as json or yaml?

### Bonus:

* How do describe a node?
* What is the node's kernel version

## Describe API objects

Lets explain the structure of pods:
```
$ kubectl explain pod
```

### Quiz:
* How do we get the structure of the pod.spec field?

## Summary

In this lab you learned the ins and outs of the kubernetes command line client.