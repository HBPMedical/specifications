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
  │   └── 20161029
  │       └── scan_research_id
  │           └── dicom_name_generated_01.dcm
  │           └── dicom_name_generated_02.dcm
  │           └── dicom_name_generated_03.dcm
  └── EHR
      └── 20161029
          ├── table1.csv
          └── table2.csv

```

{{% notice warning %}}
After de-identification, we should ensure that patient IDs present in the EHR data match patient IDs present in the DICOM headers.
{{% /notice %}}
