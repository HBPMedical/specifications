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

{{<mermaid align="left">}}
graph LR
        data_in(Anonymised data from Data Capture)
        data_out(Reorganised data)
        processing> Reorganisation of MRI scans and EHR data]
        data_in --> processing
        processing --> data_out
{{< /mermaid >}}
