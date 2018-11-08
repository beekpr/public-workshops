# Part 4: Metrics to alert on

As you saw in the previous scenario having a container killed by the operating system is not a good thing. We would normally want to trigger an alert in these cases so that someone can manually intervene to fix the issue or our automation can fix the broken container.

Using the skills you learned in [Part 2](2-building-grafana-dashboards.md) create a graph in [Grafana](http://graphs.workshop.devops.beekeeper.rocks) that you can use to detect this issue. You will want to create your alert based on some threshold line on this graph.

## Tips
You need to use a _Graph_ panel, not a _Singlestat_ panel, to be able to create an alert.

You can make use of useful functions like

`delta` which compares value at start and end of the window given by a bracket operator

e.g. `delta(metric_name[10m])`

You can make use of regular expressions to filter out namespaces

e.g. `metric_name{namespace!~".*-system"}`

You can also display different graphs per namespace by using `sum(...) by (namespace)`

Once you have a graph that you are confident you could create an alert off of you can go the the _Alert_ tab and configure when it would fire. You need to update the _Alert Config_. Right now we have no channel to deliver the alerts. You can go to the global _Alerting_ button on the right (it looks like an alarm bell) and choose _Notification Channels_. Here you can register a channel of your choice, e.g. Slack, Telegram or a simple webhook. If you don't have anything fancy just create a webhook one by using a URL from `http://postb.in/`, you can later go to that URL to check for alerts.

## Exercise

- What other alerts would you create for your cluster and applications?
