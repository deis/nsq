
|![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Warning.svg/156px-Warning.svg.png) | Deis Workflow is no longer maintained.<br />Please [read the announcement](https://deis.com/blog/2017/deis-workflow-final-release/) for more detail. |
|---:|---|
| 09/07/2017 | Deis Workflow [v2.18][] final release before entering maintenance mode |
| 03/01/2018 | End of Workflow maintenance: critical patches no longer merged |
| | [Hephy](https://github.com/teamhephy/workflow) is a fork of Workflow that is actively developed and accepts code contributions. |

# Deis NSQ
[![Build Status](https://ci.deis.io/job/nsq/badge/icon)](https://ci.deis.io/job/nsq)

Deis (pronounced DAY-iss) Workflow is an open source Platform as a Service (PaaS) that adds a developer-friendly layer to any [Kubernetes](http://kubernetes.io) cluster, making it easy to deploy and manage applications on your own servers.

![Deis Graphic](https://getdeis.blob.core.windows.net/get-deis/deis-graphic-small.png)

A NSQ image for running on a kubernetes cluster.

## Description
NSQ is a high performance realtime distributed messaging platform. This image is for running `nsqd` on a kubernetes cluster. It provides no data persistence or the `nsqlookupd` service. Access to the queue is provided through a service ip.

[v2.18]: https://github.com/deis/workflow/releases/tag/v2.18.0
