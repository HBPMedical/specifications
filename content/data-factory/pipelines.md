---
date: 2017-07-04T11:16:30+01:00
title: Processing pipelines
creatordisplayname: Ludovic CLAUDE
creatoremail: ludovic.claude@chuv.ch
lastmodifierdisplayname: Ludovic CLAUDE
lastmodifieremail: ludovic.claude@chuv.ch
toc: true
weight: 32
---

The processing pipelines provided out-of-the-box by the Data Factory enable an
automated processing of data made available to MIP Local or MIP Federated.


## Overview of all pipelines

{{<mermaid align="left">}}
graph LR
        data_in(Anonymised data from Data Capture or other sources)
        data_out(Reorganised data)
        reorg_pipeline> Reorganisation pipeline]
        data_in --> reorg_pipeline
        reorg_pipeline --> data_out
{{< /mermaid >}}


## Reorganisation pipeline

{{<mermaid align="left">}}
graph LR
        data_in(Anonymised data from Data Capture or other sources)
        data_out(Reorganised data)
        processing> Reorganisation of MRI scans and EHR data]
        data_in --> processing
        processing --> data_out
{{< /mermaid >}}
