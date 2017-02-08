---
date: 2017-02-03T18:07:35+01:00
next: /data-factory
prev: /data-capture
title: output
toc: true
weight: 5
---

The __Data Capture__ should export its data into a folder made available to the [__Data Factory__](../data-factory)

```

  ├── DICOM
  │   └── 20161029                              -- daily folder, date represents date of importation
  │       └── scan_research_id                  -- see description below
  │           └── dicom_name_generated_01.dcm   -- set of DICOM files
  │           └── dicom_name_generated_02.dcm   -- set of DICOM files
  │           └── dicom_name_generated_03.dcm   -- set of DICOM files
  └── EHR
      └── 20161029                              -- daily folder, date represents date of importation
          ├── table1.csv                        -- pre-defined name for 1st table containing EHR data, depends on hospital data
          └── table2.csv                        -- pre-defined name for 2nd table containing EHR data, depends on hospital data
          └── ...                               -- more (or less) tables as needed, depends on hospital data

```

scan_research_id: an ID for research, with no identifier coming the clinical database and representing one visit for one patient. During this visit, there may be more than one scan acquisition session, each session can have several sequences, a sequence can have several repetitions and acquire as many brain scan. One brain scan can be spread into several DICOM files where each file represents a slice of the brain.

{{% notice warning %}}
After de-identification, we should ensure that patient IDs present in the EHR data match patient IDs present in the DICOM headers.
{{% /notice %}}
