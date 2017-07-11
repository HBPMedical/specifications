---
date: 2017-07-04T11:16:30+01:00
title: Capture Database
description: Database with an I2B2 schema for storing all information harvested onsite
creatordisplayname: Ludovic CLAUDE
creatoremail: ludovic.claude@chuv.ch
lastmodifierdisplayname: Ludovic CLAUDE
lastmodifieremail: ludovic.claude@chuv.ch
toc: true
weight: 34
---

### Database with an I2B2 schema storing all information harvested onsite

The __Capture__ database enables the collection of lots of information coming from the hospital EHR data or
from research cohort metadata in an unaltered way.

At this point, no attempt is made to select or transform the data to fit into the [MIP Common Data Elements](../cde).

This database serves purely the data curation process: data elements are identified, described, collected and managed in a database.

To support the capture of as much information as possible, we have adopted the widely used I2B2 database schema,
a variant of the star schema commonly used in [data marts](https://en.wikipedia.org/wiki/Data_mart)

![I2B2 star schema](/specifications/images/i2b2_schema.gif)

An interesting consequence of this choice is that as several research databases and hospital data exports for research use I2B2,
the data importation process is a simple database copy.
