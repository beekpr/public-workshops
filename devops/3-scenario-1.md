# Part 3 - Scenario 1: Find node with full disk

Somewhere in our fleet of containers there a node with a very full root mountpoint ("/")

Using either [Grafana](http://graphs.workshop.devops.beekeeper.rocks) or [Prometheus](http://metrics.workshop.devops.beekeeper.rocks), see if you can find the culprit.


## Tips
Try typing _node_ in the query field and let the autocomplete help you find the correct metric

## Exercise

- How much disk free is left on th e node?
- When did the disk usage start?
