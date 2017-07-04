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
        data_out(Research-grade data)
        reorg_pipeline> Reorganisation pipeline]
        ehr_pipeline> EHR ingestion pipeline]
        metadata_pipeline> Metadata ingestion pipeline]
        preprocessing_pipeline> MRI pre-processing and feature extraction pipeline]
        normalisation_pipeline> Normalisation and data export pipeline]
        data_in --> reorg_pipeline
        reorg_pipeline --> ehr_pipeline
        reorg_pipeline --> metadata_pipeline
        reorg_pipeline --> preprocessing_pipeline
        ehr_pipeline --> normalisation_pipeline
        metadata_pipeline --> normalisation_pipeline
        preprocessing_pipeline --> normalisation_pipeline
        normalisation_pipeline --> data_out
{{< /mermaid >}}


## Reorganisation pipeline

This pipeline takes data organised on the disk in its original format and reorganise it into
something that fits the layout expected by the following pipelines (EHR, pre-processing, metadata).

{{<mermaid align="left">}}
graph LR
        data_in(Anonymised data from Data Capture or other sources)
        data_out(Reorganised data)
        processing> Reorganisation of MRI scans and EHR data]
        data_in --> processing
        processing --> data_out
{{< /mermaid >}}

## EHR pipeline

{{<mermaid align="left">}}
graph LR
        data_in(CSV files or other files containing EHR data)
        data_out(I2B2 capture database)
        processing> ETL with light mapping of EHR data to I2B2 schema]
        data_in --> processing
        processing --> data_out
{{< /mermaid >}}

## Metadata pipeline

{{<mermaid align="left">}}
graph LR
        data_in(Metadata extracted from MRI scans)
        data_out(I2B2 capture database)
        processing> ETL with light mapping of metadata to I2B2 schema]
        data_in --> processing
        processing --> data_out
{{< /mermaid >}}
