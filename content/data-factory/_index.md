---
chapter: true
title: Data Factory
description: Goals of Data Factory
pre: <b>3. </b>
creatordisplayname: Ludovic CLAUDE
creatoremail: ludovic.claude@chuv.ch
lastmodifierdisplayname: Ludovic CLAUDE
lastmodifieremail: ludovic.claude@chuv.ch
date: '2017-02-03T16:34:51+02:00'
weight: 300
draft: false
---

## Goals

The main role of the __Data Factory__ is to take data coming from [__Data capture__](../data-capture) , process it offline (without any user interaction) then store the results into a database of the __Hospital Database Bundle__.

<!-- more -->

{{<mermaid align="left">}}
graph LR
        data_in(Anonymised data)
        data_out(Data store)
        processing> Pre-processing + ETL + automated curation]
        data_in --> processing
        processing --> data_out
{{< /mermaid >}}
