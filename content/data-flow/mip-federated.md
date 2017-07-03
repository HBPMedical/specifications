---
date: 2017-07-03T11:44:00+02:00
title: Flow in MIP Federation
creatordisplayname: Ludovic CLAUDE
creatoremail: ludovic.claude@chuv.ch
lastmodifierdisplayname: Ludovic CLAUDE
lastmodifieremail: ludovic.claude@chuv.ch
toc: true
weight: 10
---

MIP Federated brings together several hospitals and clinical data centers to build a Federation.

Data are collected at each hospital (clinical data) or clinical data centers (research data), then
a user of MIP can query and do machine learning or statistical analyses but with the strong imperative that
only data aggregates are exchanged between the hospital or data centers and the central node hosting the user-facing web site.

<!--more-->

## Flow of data in MIP Federation

{{<mermaid align="left">}}
graph BT
        subgraph Hospital #1 databases
        in_data(EHR database, PACS)
        end
        subgraph MIP Local at Hospital #1
        subgraph Data Capture
        dc_anon>Depersonalisation]
        end
        subgraph Data Factory
        df_preprocessing>Pre-processing, feature extraction]
        end
        subgraph Algorithm Factory and Local database
        hd_af(Features database and algorithms)
        end
        end
        in_data -->|Patients with consent| dc_anon
        dc_anon --> df_preprocessing
        df_preprocessing -->hd_af

        subgraph Hospital #2 databases
        in2_data(EHR database, PACS)
        end
        subgraph MIP Local at Hospital #2
        subgraph Data Capture
        dc2_anon>Depersonalisation]
        end
        subgraph Data Factory
        df2_preprocessing>Pre-processing, feature extraction]
        end
        subgraph Algorithm Factory and Local database
        hd2_af(Features database and algorithms)
        end
        end
        in2_data -->|Patients with consent| dc2_anon
        dc2_anon --> df2_preprocessing
        df2_preprocessing --> hd2_af

        subgraph Central node
        inc_data(Research cohorts)
        end
        subgraph MIP Local on central node
        subgraph Data Capture
        dcc_anon>Depersonalisation]
        end
        subgraph Data Factory
        dfc_preprocessing>Pre-processing, feature extraction]
        end
        subgraph Algorithm Factory and Local database
        hdc_af(Features database and algorithms)
        end
        end
        inc_data -->|Subjects with consent| dcc_anon
        dcc_anon --> dfc_preprocessing
        dfc_preprocessing --> hdc_af

        subgraph Federation layer
        web(Web analysis)
        dist_soft(Distributed database and algorithms)
        web --- dist_soft
        end
        hd_af -->|Aggregates|dist_soft
        hd2_af -->|Aggregates|dist_soft
        hdc_af -->|Aggregates|dist_soft

        user((User)) --- web
{{< /mermaid >}}
