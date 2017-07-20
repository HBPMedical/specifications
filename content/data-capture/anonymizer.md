---
date: 2017-02-28T20:08:35+01:00
title: GNUBILA Pandora FedEHR file organisation
toc: true
weight: 25
---

{{% alert theme="warning" %}}
The following is used only when the GNUBILA Pandora FedEHR anonymiser has been setup.
{{% /alert %}}

{{% excerpt %}}
### Data folder organisation for the anonymisation processing
```
  /data
  ├── anonymiser             -- This folder contains all the data being processed.
  │   ├── db                 -- This contains the database of the internal IDs to public IDs mappings.
  │   ├── in                 -- Files to be processed. 
  │   ├── out                -- Files successfuly anonymised.
  │   ├── quarantine         -- Files for which the anonymisation failed:
  │   │   ├── csv            --   * EHR data files
  │   │   ├── dicom          --   * Imaging data files
  │   │   ├── pacs_csv       --   * EHR data retrieved through a PACS connexion
  │   │   └── unknown        --   * Any other kind of failures
  │   └── scripts            -- Anonymisation configurations for:
  │       ├── csv            --   * EHR data files
  │       └── dicom          --   * Imaging data files
  └── ldsm
```
{{% /excerpt %}}

Please be aware that as part of the anonymisation, files are **moved** from the input folder to the quarantine folder, or to either the output folder (and modified).
