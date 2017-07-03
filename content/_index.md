---
title: MIP specs
date: '2017-02-03T16:30:51+02:00'
type: index
weight: 0
draft: false
---

## Specification for the Medical Informatics Platform

{{% children description="true" %}}

### The different versions of MIP

{{<mermaid>}}
gantt
        dateFormat  YYYY-MM-DD
        title Phases in the MIP project

        section Releases
        MIP POC on mip.humanbrainproject.eu v1.0 :done, rel1, 2016-03-31,1d
        MIP Local v1.0                           :done, rel2, 2017-06-28,1d

        section Development
        Ramp up phase - implementation of most building blocks :crit, done, dev1, 2013-03-31, 1095d
        Completed Development of MIP Local       :crit, done,   dev2, after dev1, 427d
        Development of MIP Federated             :crit, active, dev3, 2017-01-01, 270d

        section Deployment
        MIP POC on mip.humanbrainproject.eu      :done,   depl1, 2013-03-31, 2016-03-31
        MIP Local at CHUV                        :done,   depl2, 2016-09-30, 2017-06-28
        MIP Local in other hospitals             :active, depl3, 2017-04-01, 2017-10-30

{{< /mermaid >}}
