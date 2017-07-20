---
chapter: true
date: 2017-02-03T17:18:42+01:00
pre: <b>4. </b>
title: Hospital Database
weight: 500
---

# Import of data in LDSM

Once the harmonised data is available in the i2b2, it is made available in the LDSM through csv files and exposed to the Web Portal and Exareme as tables.

The current schema is based on the requirement of the Web Portal and the available variables. Currently (July 2017), the schema used is a big table containing one column per variable, and one line per patient and visit. The schema will be further refined in the coming months based on available data and MIP requested features.

MIPMap is used to extract all the relevant data from the i2b2 harmonised database and create csv files with the expected schema. The current table is named harmonised_clinical_data.csv. Currently, this file is directly saved in the "datasets" folder of PostgresRAW-UI. Once the LDSM is moved to a different server, this will be replaced by a scp command to copy the file on the distant server. Authentification will be key-pair-based.

All files in the LDSM dataset folder are automatically detected by PostgresRAW-UI, which infers their schema and registers the files as tables in PostgresRAW. The data can then be queried in PostgresRAW in the table harmonised_clinical_data.
