# Workshop: Cloud Native Monitoring with Prometheus & Grafana

## Objectives

This workshop covers:

- The core concepts of Prometheus
- Querying Prometheus to gain insights on how your applications behave
- Building Grafana dashboards combining multiple metrics
- Using metrics to identify production issues in simulated scenarios
- Alerting on metrics to prevent issues in future
- Tracing requests in a microservice architecture to identify potential issues

## Table of Content

- [Part 1](1-querying-prometheus.md): Querying Prometheus
- [Part 2](2-building-grafana-dashboards.md): Building Grafana Dashboards
- [Part 3 - Scenario 1](3-scenario-1.md): Find node with full disk
- [Part 3 - Scenario 2](3-scenario-2.md): Memory intensive container
- [Part 3 - Scenario 3](3-scenario-3.md): Explain previous graph
- [Part 4](4-alerting.md): Metrics to alert on
- [Part 5](5-tracing.md): Tracing Requests

## Additional resources

- [Prometheus documentation](https://prometheus.io/docs/introduction/overview/)
- Prometheus Blog Series:
    - [Metrics and Labels](https://pierrevincent.github.io/2017/12/prometheus-blog-series-part-1-metrics-and-labels/)
    - [Metric Types](https://pierrevincent.github.io/2017/12/prometheus-blog-series-part-2-metric-types/)
    - [Exposing and collecting metrics](https://pierrevincent.github.io/2017/12/prometheus-blog-series-part-3-exposing-and-collecting-metrics/)
    - [Instrumenting code in Go and Java](https://pierrevincent.github.io/2017/12/prometheus-blog-series-part-4-instrumenting-code-in-go-and-java/)
    - [Alerting rules](https://pierrevincent.github.io/2017/12/prometheus-blog-series-part-5-alerting-rules/)
- [Robust Perception Blog](https://www.robustperception.io/blog/)
- [Prometheus: Best Practices and Beastly Pitfalls](https://www.youtube.com/watch?v=_MNYuTNfTb4)  by Julius Voltz (PromCon 2017)

## Credits
- Part 1, 2 mainly taken from work by Pierre Vincent's [Prometheus Workshop](https://github.com/PierreVincent/prometheus-workshop)
- Part 5 uses setup from istio bookinfo sample [Bookinfo](https://github.com/istio/istio/tree/master/samples)