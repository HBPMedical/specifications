---
date: 2017-02-03T18:07:35+01:00
title: Data Capture output
creatordisplayname: Ludovic CLAUDE
creatoremail: ludovic.claude@chuv.ch
lastmodifierdisplayname: Ludovic CLAUDE
lastmodifieremail: ludovic.claude@chuv.ch
toc: true
weight: 5
---

The __Data Capture__ should export its data into a folder made available to the [__Data Factory__](../data-factory)

There are several options possible, to adapt to the local requirements:

{{% excerpt %}}

### Depersonalised DICOM + EHR data export

```

  ├── DICOM
  │   └── 2016                                      -- yearly folder, date represents the date of export
  │       └── 20161029                              -- daily folder, date represents the date of export
  │           └── scan_research_id                  -- see description below
  │               └── dicom_name_generated_01.dcm   -- set of DICOM files
  │               └── dicom_name_generated_02.dcm   -- set of DICOM files
  │               └── dicom_name_generated_03.dcm   -- set of DICOM files
  └── EHR
      └── 2016                                      -- yearly folder, date represents the date of export
          └── 20161029                              -- daily folder, date represents the date of export
              ├── table1.csv                        -- pre-defined name for 1st table containing EHR data, depends on hospital data
              └── table2.csv                        -- pre-defined name for 2nd table containing EHR data, depends on hospital data
              └── ...                               -- more (or less) tables as needed, depends on hospital data

```

### Depersonalised Nifti + EHR data export

```

  ├── NIFTI
  │   └── 2016                                      -- yearly folder, date represents the date of export
  │       └── 20161029                              -- daily folder, date represents the date of export
  │           └── scan_research_id                  -- see description below
  │               └── dicom_name_generated_01.nifti -- Nifti file
  │               └── dicom_name_generated_01.json  -- metadata for the Nifti file
  │               └── dicom_name_generated_02.nifti -- Nifti file
  │               └── dicom_name_generated_02.json  -- metadata for the Nifti file
  └── EHR
      └── 2016                                      -- yearly folder, date represents the date of export
          └── 20161029                              -- daily folder, date represents the date of export
              ├── table1.csv                        -- pre-defined name for 1st table containing EHR data, depends on hospital data
              └── table2.csv                        -- pre-defined name for 2nd table containing EHR data, depends on hospital data
              └── ...                               -- more (or less) tables as needed, depends on hospital data

```

scan_research_id: an ID for research, with no identifier coming the clinical database and representing one visit for one patient. During this visit, there may be more than one scan acquisition session, each session can have several sequences, a sequence can have several repetitions and acquire as many brain scan. One brain scan can be spread into several DICOM files where each file represents a slice of the brain.

{{% alert theme="warning" %}}
After de-identification, we should ensure that patient IDs present in the EHR data match patient IDs present in the DICOM headers.
{{% /alert %}}

{{% /excerpt %}}
