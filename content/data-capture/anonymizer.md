---
date: 2017-02-28T20:08:35+01:00
title: Anonymisation module
toc: true
weight: 205
---

A module that performs anonymisation is provided by MIP when the hospital does not have the tools to perform the de-personalisation of all data.

{{% alert theme="warning" %}}
The following is used only when the GNUBILA Pandora FedEHR anonymiser has been setup.
{{% /alert %}}

{{% excerpt %}}
### Data folder organisation for the anonymisation processing

The software [GNUBILA Pandora FedEHR](https://corporate.gnubila.fr/fedehr) is used to perform the de-personalisation of all EHR and imaging data.

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

Please be aware that as part of the anonymisation, files are **moved** from the input folder either to the quarantine folder, or to the output folder (and modified).
