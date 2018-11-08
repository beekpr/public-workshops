# Part 1: Querying Prometheus

## Requirements

If you are doing the workshop live, you will be given access to a temporary Prometheus & Grafana on which we will do the exercises - all you will need is a web browser.
 
## A first look at the Prometheus UI

Navigate to [Prometheus](http://metrics.workshop.devops.beekeeper.rocks).

You should see the Prometheus UI, with the following tabs:
- Graph: default view, where we can you can query time-series (We will only look at this)
- Status: current state of scraped targets, service discovery as well as various configuration
- Help: link to the Prometheus official documentation (essential!)

## Request Rate

One of the  apps we will be working with in this workshop is a dummy app `http-simulator`. This service exposes similar metrics as a real HTTP API, and simulated various levels of activity, latency and errors.

First let's make sure that this app is working correctly:

    up{app="http-simulator"}
    
Now let's look at the number of requests that this service has received since it started up:

    http_requests_total{app="http-simulator"}

The `{name="value"}` operator filters the `http_requests_total` metrics for a specific label.

Results show a lot of different time series, with a lot of different labels. Can you tell what the difference is between each of these time series?

Each time-series in the list is for the same `http_requests_total` metric, but with different label sets. This is very powerful, because now we're able to make the distinction between different endpoints and their status code.

Let's imagine you're only interested in the number of successful requests for the `/login` endpoint. To achieve this, you can add more label filters:

    http_requests_total{app="http-simulator", status="200", endpoint="/login"}

Now we may also be interested in the total number of successful requests, regardless of the endpoint:

    http_requests_total{app="http-simulator", status="200"}
    
This is still returning multiple time-series, but we can aggregate them using the `sum()` function:

    sum(http_requests_total{app="http-simulator", status="200"})
 
This is interesting, but does not exactly tell us much in terms of request rate. The graph just keeps going up.

We can also use the bracket operator to look at all the values for the last 5 minutes `[5m]`. This will only fetch values from now to 5 minutes ago
    
    http_requests_total{app="http-simulator", status="200"}[5m]

Prometheus will show an error, as this is a "range query", and cannot be directly represented on a graph. If instead we want to look at the number of requests per second, we can use the `rate()` function.

    sum(rate(http_requests_total{app="http-simulator", status="200"}[5m]))

We should now have a single time-series, displaying the number of successful requests per second. The `[5m]` operator used inside the `rate()` function means that the rate is calculated over a 5 minutes rolling-window. The shorter this period, the more _spikey_ the graph will be.

### Exercises

- What's the overall request rate (with a 1 minute rolling-window) for the http-simulator service?
- How many requests per minute are errors?
- What's the error rate (in %) of requests to the /users endpoint?

## Latency distribution

Latency cannot be accurately measured through sums and averages, because it's a distribution problem. The `http-simulator` exposes an _Histogram_ metric for this purpose, called `http_request_duration_milliseconds`. Histogram metrics are actually multiple metrics, with the `_buckets` suffix.

    http_request_duration_milliseconds_bucket{app="http-simulator"}

Again, this metric is labeled by endpoint and status, so let's look at only the successful login requests for now:

    http_request_duration_milliseconds_bucket{app="http-simulator", status="200", endpoint="/login"}

The remaining time series should only differ by their `le` label, which stands for "Less than or equal". For example, the counter with the label `le=50` is the number of successful login requests that took at most 50ms to complete.

In addition of buckets, Histograms expose 2 other metrics:
- `_sum` (total sum of observed values)
- `_count` (total count of observed values)

These can be useful to derive rates out of the buckets. Let's imagine our login SLO (Service Level Objective) is that 99% of requests respond within 200ms, we can try to query for the % of login requests within the SLO.

    sum(http_request_duration_milliseconds_bucket{app="http-simulator", status="200", endpoint="/login", le="200"}) / sum(http_request_duration_milliseconds_count{app="http-simulator", status="200", endpoint="/login"}) * 100

Another approach is to query Prometheus for the actual 99-percentile, using the `histogram_quantile()` function:

    histogram_quantile(0.99, rate(http_request_duration_milliseconds_bucket{app="http-simulator", status="200", endpoint="/login"}[5m]))

This percentile tells us how many milliseconds are needed for 99% of all successful login requests to return.

What does it look like for the 90th percentile?

### Exercises

- What is the median latency of all requests to the http-simulator service?
- What is the 90-percentile latency of all error requests to the http-simulator service, for each endpoint?
- Does the `/users` endpoint fulfill the SLO of _3 Nines_ requests responding within 400ms?
