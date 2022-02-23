## A simple BalenaCloud integration with Splunk using Fluentd

This is a simple [Splunk][splunk-link] log integration using fluentd that works with any of the devices supported by [Balena][balena-link].

This image includes two containers: writelogs and sendlogs. 

In writelogs, the src/main.sh script continually writes random events to logs/logs.txt. /logs is a shared volume accessible from both continers.

In sendlogs, fluentd tails the logs.txt file and sends to a Splunk Enterprise or Splunk Cloud HTTP endpoint collector (HEC) using the [Splunk-fluentd output plugin][splunk-fluentd-plugin].  

To get this project up and running on the Splunk end, you'll need to have a working [Splunk Cloud][splunk-cloud-trial] or [Splunk Enterprise][splunk-enterprise-trial] environment with the [HTTP Event Collector (HEC)][splunk-hec] enabled and accessible from the internet. You'll also need to create a HEC authentication token and have a target events index enabled.

On the Balena end, signup for a balena account [here][signup-page], set up a device, and have a look at the [Getting Started tutorial][gettingStarted-link]. Once you are set up with balena, you will need to clone this repo locally.

Follow these [steps][push-balena] to push the code to your fleet to enable the data collection. Make sure to change the Dockerfile.template file to match the architecture of the target device for the [build][balena-build].

Once deployed, add the four OS environment variables below to enable the connection to Splunk:

```
SPLUNK_HOST = IP address or hostname of remote Splunk host
```

```
SPLUNK_PORT = HEC port for the remote Splunk host
```

```
SPLUNK_TOKEN = the Splunk authentication token for HEC access
```

```
SPLUNK_INDEX = the name of the Splunk target index where the data will be stored
```

Note: The Splunk index must be an events index (not metrics).

This is how the variables should look on the Balena console:
![Balena Variables](/img/balena_console_vars.png)

Once running correctly, you should see this in your logs:
![log output](/img/balena_console_output.png)

In this example, the log file source and sourcetype are hard coded in the fluentd.conf. These can also be set as OS variables in Balena if preferred.

Here's an example search in Splunk. Note that the events are forwarded by fluentd as JSON:
![splunk_dashboard](/img/splunk_search.png)


[balena-link]:https://balena.io/
[signup-page]:https://dashboard.balena-cloud.com/signup
[gettingStarted-link]:http://balena.io/docs/learn/getting-started/
[splunk-cloud-trial]:https://www.splunk.com/en_us/download/splunk-cloud.html
[splunk-enterprise-trial]:https://www.splunk.com/en_us/download/splunk-enterprise.html
[splunk-hec]:https://docs.splunk.com/Documentation/Splunk/8.2.4/Data/UsetheHTTPEventCollector
[splunk-link]:https://www.splunk.com
[push-balena]:https://www.balena.io/docs/learn/deploy/deployment/
[balena-build]:https://www.balena.io/docs/learn/develop/dockerfile/
[splunk-fluentd-plugin]:https://github.com/splunk/fluent-plugin-splunk-hec/
