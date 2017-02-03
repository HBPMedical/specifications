---
title: Specifications for Data Capture
date: '2017-02-03T16:34:51+02:00'
weight: 0
draft: false
---

## Goals

The main role of the __Data Capture__ is to take data coming several clinical systems in a hospital, collect that data and remove any identifying information from them, then export that data as a collection of CSV files and DICOM/Nifti files to be processed by the [__Data Factory__](../data-factory).

```
  disparate clinical data => collection + de-identification => export to exchange directory
```
