# Part 3 - Scenario 3: Explain previous graph

In the previous scenario we found the guilty container, and saw some weird behaviour in the graph. What could be happening to the container to explain the sudden drop in memory? Why are the lines a different colour in [Prometheus](http://metrics.workshop.devops.beekeeper.rocks) 

Using either [Grafana](http://graphs.workshop.devops.beekeeper.rocks) or [Prometheus](http://metrics.workshop.devops.beekeeper.rocks) see if you can find what happened to the container.


## Tips
Try typing _container_status_ into the query field and let the autocomplete help you find out what happened to the container.

There will be a lot of noise as we record many metrics, you can filter the metrics by doing things like:
    
    
    metric_name{namespace!="",namespace!~".*-system", container_name!="POD"}


## Exercise

- What counter has increased that tells us something happened?
- What does that mean?
- Why is there or (can there be) a gap between the lines?
