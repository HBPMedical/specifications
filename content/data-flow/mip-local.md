---
date: 2017-07-03T11:44:00+02:00
title: Flow in MIP Local
creatordisplayname: Ludovic CLAUDE
creatoremail: ludovic.claude@chuv.ch
lastmodifierdisplayname: Ludovic CLAUDE
lastmodifieremail: ludovic.claude@chuv.ch
toc: true
weight: 101
---

MIP Local is installed in participating hospitals and used to collect clinical data
provided by the hospital. Only patients with consent are selected, and no data ever leaves
the hospital premises.

<!--more-->

## Flow of data in MIP Local installed at a hospital

{{<mermaid align="left">}}
graph BT
        subgraph Clinical data or research cohorts
        in_ehr(EHR database)
        in_pacs(PACS)
        end

        subgraph Data Capture
        subgraph Anonymiser
        dc_anon_ehr>Depersonalisation of EHR data]
        dc_anon_mri>Depersonalisation of MRI scans]
        end
        end

        subgraph Data Factory
        subgraph Workflow engine
        airflow_mri_preprocessing>MRI pre-processing] --> airflow_feature_extraction>Feature Extraction]
        airflow_ehr_version>Versioning] --> airflow_ehr_harmonise>Harmonisation]
        end
        df_i2b2(I2B2 database)
        airflow_feature_extraction --> df_i2b2
        airflow_ehr_harmonise --> df_i2b2
        end

        subgraph Algorithm Factory
        hd_features(Features database) --- af_worker(Algorithms)
        end

        in_ehr -->|Patients with consent| dc_anon_ehr
        in_pacs -->|Patients with consent| dc_anon_mri
        dc_anon_ehr --> airflow_ehr_version
        dc_anon_mri --> airflow_mri_preprocessing
        df_i2b2 --> hd_features
{{< /mermaid >}}
