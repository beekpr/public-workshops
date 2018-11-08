# Part 5 - Tracing Requests

Up until now we have been using pretty straightforward single service applications. DevOps becomes much more tricky when you add multiple services into the picture.

![Bookinfo Architecture](images/architecture.svg "Bookinfo Architecture")

You can visit our wonderful [bookstore](http://books.workshop.devops.beekeeper.rocks). When visiting, you may be lucky and the page loads and you see some book reviews and ratings. If you open Developer Tools in your browser and refresh the page a couple of times you will notice that most of the time, the page takes 3 seconds or longer to load or times out completely after 6 seconds.

We have luckily recorded a lot of useful metrics for this service (`istio_request_duration_seconds_bucket`)

We could calculate the request duration over a one-minute sliding window for the _bookinfo_ namespace and separate it out by service (_destination_workload_)

    rate(istio_request_duration_seconds_bucket{destination_workload_namespace="bookinfo", reporter="destination"}[1m])

However, this shows us all the quantiles. Let's look at the median 0.5 quantile:

    histogram_quantile(0.5, rate(istio_request_duration_seconds_bucket{destination_workload_namespace="bookinfo", reporter="destination"}[1m]))
    
Let's compare this to the 99 percentile

    histogram_quantile(0.99, rate(istio_request_duration_seconds_bucket{destination_workload_namespace="bookinfo", reporter="destination"}[1m]))


This graph doesn't really help us, as it is just and average of all percentiles. So let's break it down by percentiles by service and look at the 99 percentile

    histogram_quantile(0.99, sum(rate(istio_request_duration_seconds_bucket{destination_workload_namespace="bookinfo"}[1m])) by (destination_workload, le))


What looks interesting about this graph? You probably noticed it is very hard to figure out what is going on here.

Lets make use of some request tracing tools to see what is going on. Go to [Jaegar](http://tracing.workshop.devops.beekeeper.rocks) and let's look at some traces.

Select the `productpage` _Service_ and click _Find Traces_

## Exercise

- Which service is responsible for the issue?
- Can you make some assumptions about the way the product page service works?
- Do you think the product page service has any timeouts?
- Do you think the product page service has any retries?
- Can you use therd  Istio Workload Dashboain Grafana to see the same results? Try setting _Namespace_ to _bookinfo_ and _Workload_ to _productpage_v1_ and see if you can spot the service which is the culprit.
