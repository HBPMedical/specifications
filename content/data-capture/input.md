---
date: 2017-02-28T20:08:35+01:00
title: Data Capture input
toc: true
weight: 21
---

Data Capture collects available data from hospital databases or research cohorts.

In addition, clinical data are de-personalised to protect patient privacy.

It should also track consent and trigger the appropriate mechanisms to remove data
from the platform in case the patient has removed her consent.

## Ideal forms of data repository for MIP

The MIP has been designed to support a very wide range of methods to gather data,
however some datasets are easier to include in the MIP if they meet some criteria.

### De-personalised data

It can be seen as safer and more secure for a hospital to take care of the de-personalisation of its data,
especially as this procedure may expose the hospital to ethical and legal questions.

We encourage hospitals to provide de-personalised data to MIP, and we can also help to put in place a technical solution,
FedEHR(c) Anonymizer(c), provided by our partner [__Gnubila__.](http://gnubila.fr/)

### I2B2 compatible databases

MIP uses internally in its [__Data Factory__](../../data-factory) several databases based on the I2B2 schema.
If your data has been prepared for data sharing and follows the [__I2B2 standard__](https://www.i2b2.org/),
this effort will fasten the inclusion of your data in the platform.

### PACS system

MIP can connect to and query any PACS system compatible with the DICOM standard.

To better protect your clinical PACS, we recommend that you put in place a research PACS that
will contain only the selection of medical images available for research.

## Other ways of integrating data in the MIP

Provided some development or configuration on our side, we can support the following methods of integrating data into MIP.

### Files extract

We can ingest data extract provided as a set of files.

For MRI data, files can be in the DICOM or NIFTI formats. We support in particular the [__BIDS organisation of data__](http://bids.neuroimaging.io/)

For EHR data, files can be in CVS, TSV, JSON or XML formats.

### Web services

We can customise the data capture to use online research databases with a Web Service API.
