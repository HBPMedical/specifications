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

More detailed documentation regarding the anonymisation process in MIP can be found here: [MIP anonymisation strategy](https://github.com/HBPMedical/specifications/blob/master/content/data-capture/mip_anonymisation_strategy.md)


{{% excerpt %}}
### Data folder organisation for the anonymisation processing

The software [GNUBILA Pandora FedEHR](https://corporate.gnubila.fr/fedehr) is used to perform the de-personalisation of all EHR and imaging data.

```
    /data
    ├── anonymiser             -- This folder contains all the data being processed.
    │   ├── db                 -- This contains the database of the internal IDs to public IDs mappings
    │   ├── in                 -- Files to be processed.
    │   ├── out                -- Files successfuly anonymised.
    │   ├── pacs               -- Used when Pandora FedEHR is configured to connect to a PACS system
    │   │   ├── csv            --  * EHR data
    │   │   ├── dicoms         --  * Imaging data
    │   │   └── download       --  * Temporary folder for file being retrieved
    │   ├── quarantine         -- Files for which the anonymisation failed:
    │   │   ├── csv            --  * EHR data files
    │   │   ├── dicom          --  * Imaging data files
    │   │   ├── pacs           --  * EHR data retrieved through a PACS connexion
    │   │   └── unknown        --  * Any other kind of failures
    │   └── scripts            -- Anonymisation configurations for:
    │       ├── csv            --  * EHR data files
    │       └── dicom          --  * Imaging data files
    └── ldsm
```
{{% /excerpt %}}

Please be aware that as part of the anonymisation, files are **moved** from the
input folder to the quarantine folder, or to the output folder (after the
modification have been applied).

Make sure to place a copy into the input folder, if you need to keep the 
original file.
