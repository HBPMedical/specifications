---
chapter: true
title: Data Capture
description: Goals of Data Capture
pre: <b>2. </b>
creatordisplayname: Ludovic CLAUDE
creatoremail: ludovic.claude@chuv.ch
lastmodifierdisplayname: Ludovic CLAUDE
lastmodifieremail: ludovic.claude@chuv.ch
date: '2017-02-03T16:34:51+02:00'
weight: 20
draft: false
---

The main role of the __Data Capture__ is to take data coming several clinical systems in a hospital, collect that data and remove any identifying information from them, then export that data as a collection of CSV files and DICOM/Nifti files to be processed by the [__Data Factory__](../data-factory).

<!-- more -->

{{<mermaid align="left">}}
graph LR
        data_in(Disparate clinical data)
        data_out(Export to data exchange directory)
        processing> Collection + curation + de-identification]
        data_in --> processing
        processing --> data_out
{{< /mermaid >}}
