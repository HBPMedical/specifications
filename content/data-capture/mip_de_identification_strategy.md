# MIP de-identification strategy

This goal of the document is to clarify how de-identification is performed in MIP, using Gnubila's Pandora FedEHR software, version 2.0.2.
It also lists possible approaches for the de-identification of DICOM files.

Pandora FedEHR can treat CSV files and DICOM files. The functionalities used for MIP de-identification are described below. Also see the [documentation](https://nexus.gnubila.fr/service/local/repositories/maatg-fr-releases/content/fr/maatg/pandora/clients/pandora-clients-fedehr-anonymiser-all/2.0.2/pandora-clients-fedehr-anonymiser-all-2.0.2.pdf) available online.


## Context

The de-identification step documented here is only one mechanism in the overall privacy protection approach of the MIP. Strictly speaking, this step performs "de-identification" and "pseudonymisation": once done, individual patients can still be distinguished based on pseudonymised identifiers, but they are not identified with personal data anymore.

The pseudonymised DICOM files are not intended to be available for the MIP users either locally or at the Federation level. Still, pseudonymisation is a valuable tool to decrease risks, also considering that the pseudonymised files might be hosted on a server which will be accessible from the web at the Federation stage.


## Responsibilities

The partners providing data are responsible of the satisfactory de-identification of their data. HBP SP8 provides guidelines and help regarding the functionalities of the FedEHR software, its configuration and its usage.


## De-identification principles for MIP

Following the general principles defined in the [Medical Informatics Platform (SP8): Privacy Impact Assessment](https://drive.google.com/drive/folders/0B5CgbpurVVlHZlRpeG40ZlVoTjA) and further internal consultations, the MIP de-identification principles (recommendations) can be summarised as:

- Information that is not needed for research purposes must be removed.
- Patients should be identified with a unique identifier through all data sources: this is necessary to link data sources together (in particular imaging data and EHR data). This identifier will be pseudonymised, i.e. replaced with a generated pseudo-identifier (hash). The link between the original identifier and the pseudo-identifier can be stored by Pandora FedEHR in a dedicated database.
- All other identifiers present in the original data (visit id, etc.) will also be pseudonymised.
- The birth dates will be reduced to the year.
- All other dates will be reduced to the month: this level of detail is required for longitudinal studies.
- Patient names, addresses and similar personal information should not appear in data provided for the platform. If they do, they are removed at the de-identification level.
- Specific de-identification rules can be defined for other fields based on the MIP or the partner's requirements.
- The de-identification rules for EHR data (CSV files) are defined in collaboration with the partner institution. The rules and the result of the de-identification must be validated by the partner.
- DICOM files de-identification will reject DICOM tagged files that are not tagged "primary" (see details below in the [DICOM files section](#dicom_files)). The partner institution must acknowledge the limitations of the imaging de-identification process, in particular the fact that no pixel blanking will be performed, and validate the result of the de-identification.


## Requirement regarding identifiers

Information regarding common identifiers shared among different data sources (multiple EHR CSV files, DICOM files) must be provided to the de-identification configuration team. This is particularly important for identifiers used to link two or more data sources (for instance linking a scan to a patient visit): these identifiers must be pseudonymised in an identical manner in all sources in order to keep the links.

Note: this information must also be transferred to the teams working on the pre-processing and harmonisation of the data for coordination purposes.



## CSV files

### Format

A clean CSV file format is required for running the de-identification software and integrating the data in the MIP. In this sense, the formatting should respect the following rules:

- Use a file name without spaces nor non-standard characters.
- Use column names without spaces nor non-standard characters.
- Use a unique and well-defined separator. By default, the expected separator is the comma ','. Other separators such as the semi-colon ';' can be used, but the choice should be consistent over all CSV files provided to the MIP.
- Quote all text fields. Problems will appear if some text fields contains the separator characters or new lines and are not quoted.
- Follow a unique and well-defined pattern for dates, such as dd/MM/yyyy (any pattern is acceptable). Date field must not contain anything else (no text, annotations, incomplete dates, etc.)
- Enter only one type of data per column (either numerical, date, text, etc.)
- If possible, leave the field empty for null values (i.e. two separators without any character in between, such as ',,' if the comma is used as separator, ';;' if the semi-colon is used). If other tags are used for null values, inform the MIP de-identification team.
- Use the unicode file encoding UTF-8. The correct display of text is not guarantied if other encodings are used.



### De-identification

A de-identification profile must be created for each file schema. The schema of a CSV file is the list of its columns and the type (and possibly format) of the data contained in each column. 

The same de-identification profile can be used for all files sharing the same schema. The profile must define a rule for each column (remove, keep or transform using the specified rule).

The de-identification will fail if:

- The data in a column (in particular date columns) does not fit the expected format.
- A column defined in the profile is not found in the file.
- The file contains a column for which no rule has been defined.

This behaviour allows to automate the de-identification step: if a data file contains a new column for which no rule has been defined, it will not be accepted. The anonymisation will fail and further configuration will be required.



## DICOM files

DICOM format files are composed of two parts:

- A varying number of tags, either standardised or user-defined.
- The pixel data storing the image itself (it is formally also structured as a tag, but we distinguish it here for clarity).

The DICOM standard defines how tags should be organised, the content of standard tags (4000+) and the location of user-specific or manufacturer-specific tags. The pixel data part contains the image, and can also contain user-defined overlays.

The de-identification process intends to be as strict as possible, and can integrate any rule requested by the partner providing the imaging data. However it cannot fully guaranty that the depersonalisation is complete in case of images that do not follow the DICOM specifications (i.e. if personal information is stored in a tag where it should never have been).

The de-identification contains three parts:

1. File and folder names.
2. Removal or pseudonymisation of information stored in DICOM tags.
3. Blanking of pixels in the image (to erase potential embedded private information).

The third part is generally incompatible with the automated image analysis performed by the MIP, and is thus discouraged. The MIP de-identification excludes pixel anonymisation. Only clean primary DICOM images must be provided by the partners, without any incrusted information in the image.

The Pandora FedEHR software uses configuration files for the last two parts (DICOM de-identification profile and DICOM pixel de-identification profile). Once defined, the same de-identification profiles are used for all DICOM files.

A de-identification script is provided to de-identify large amounts of data; this script takes care of the files and folder names removal.

### 1. File and folder names

The script `anonymise-dicom-and-names.sh` removes the names of the DICOM files and folders. It generates folders numbered sequentially in the output directory. It then renames the de-identified DICOM files again with sequential numbers. The order of the DICOM files in the same sequence is preserved.

The following example shows how the original and de-identified directories will be organised.

```
/data_source_folder
├── folder_to_anonymise
│   ├── patient_8930265
│   |   ├── dicom_8930265.457.135678.1.dcm
│   |   ├── dicom_8930265.457.135678.2.dcm
│   |   ├── dicom_8930265.457.135678.3.dcm
│   ├── patient_99832119
│   |   ├── dicom_99832119.486.173512.1.dcm

/data_source_folder
├── anonymised
|   ├── folder_to_anonymise
|   │   ├── 0000
|   │   |   ├── 0000.dcm
|   │   |   ├── 0001.dcm
|   │   |   ├── 0002.dcm
|   │   ├── 0001
|   │   |   ├── 0000.dcm

```

### 2. Tag de-identification

Thousands of tags can possibly be present in any DICOM file, which makes if difficult to ensure that all potentially private tags are correctly de-identified. In order to avoid this problem, the MIP strategy is to remove all tags that are not strictly needed.

This approach will interfere with DICOM viewer software, as they usually expect an unspecified list of tags to always be present. The `dcmdump` utility of the DCMTK toolkit can be used to explore the tags stored in a DICOM file.

The MIP de-identification strategy for DICOM files can be summarised as follows:


#### - MIP selected tags (mandatory and optional tags):

The list of tags used by the Data Factory (~ 40, mandatory or optional) can be found on the [MIP specifications website](https://hbpmedical.github.io/specifications/data-factory/images/).

The rules to de-identify the MIP selected tags must be defined in all cases. This can be done using the file `Template_DICOM_anonymisation_profile.xlsx` available [here]().

The principles exposed earlier are applied by default. The identifiers shared with other data sources must be pseudonymised following the same rules to maintain the link.

If necessary, the MIP / DGDS can impose standard rules for all hospitals (so that the Data Factory input is similar at all hospitals).


#### - Tag (0008,0008): 

This tag is intended to distinguish original DICOM files generated by the acquisition machine and files that were edited afterward. 

As previously mentioned, only DICOM files containing the key word "primary" in this tag will be accepted by the de-identification process. If the tag is missing or does not contain "primary", the file will be quarantined.


#### - Tags 0008,0018 (SopInstanceUID), 0020,000D (StudyInstanceUID) and  0008,0016 (SOP Class UID):

These tags are kept by default by the Pandora FedEHR anonymiser, as they are considered "compulsory" tags. The first two are identifiers that will be pseudonymised by the MIP standard profile; the third is one of the pre-defined SOP classes and can be kept as is.


#### - Other tags:

The MIP default strategy is to remove all other tags present in the DICOM files.

It is the safest approach, although it will remove information that could possibly have been used in the future. This approach is also the simplest: data providing partners only need to review the de-identification rules for the limited number of MIP selected tags, and can rely on the fact that all others will be removed. 

However, this strategy limits the use of advanced visualisation software to open the de-identified DICOM. These tools usually expect several tags to be present, which might be removed by the de-identification process. The list MIP selected tags can be extended at the partners request to keep more information.

Different de-identification strategies could be chosen for the remaining tags (see the next section for the current functionalities of FedEHR). In this case, the data providing partner must provide the complete list of tags that must be removed, modified or pseudonymised. The partner is fully responsible for the accuracy and completeness of the de-identification rules provided.



#### FedEHR functionalities

The FedEHR software provides "removeActions" functionalities for removing tags on a global scale:

```
- tag: curves # Remove curves tags and all information the tags contain
- tag: overlays # Remove overlay tags and all information the tags contain.
- tag: privategroups # Remove private groups
- tag: unspecifiedelements # Remove all unchecked elements 
```

Notes:

- Overlay information might be stored either in the overlay tags, or in the image pixels. In the second case, the information will not be removed by the "overlay" rule above. 
- The "privategroups" rule will remove all tags listed in section 7.8.1 of [this webpage](http://dicom.nema.org/dicom/2013/output/chtml/part05/sect_7.8.html).
- The "unspecifiedelements" rule removes all tags not explicitly mentioned in the de-identification profile. This should cover the previous three options, but Gnubila recommends to use all together to increase security.
- By default, these rules still keep a certain number of tags:
    - The individual tags 0008,0016 (SOP Class UID), 0008,0018 (SopInstanceUID) and 0020,000D (StudyInstanceUID)
    - The groups 0002,XXXX (FMI group), 0028,XXXX (image description) and 7FE0,XXXX (the image)


#### Altered ("secondary") DICOM files

Original DICOM files that are generated by the acquiring machine are the most likely to follow the DICOM standard than user-modified files. In particular, modified files can contain overlays which data is stored with the pixel data. In this particular case, removing the overlay tags will not remove the overlay data. 

The original images should contain the key-word "primary" in the tag 0008,0008. In order to avoid images that could have been annotated, only "primary" images will be accepted by default.
 
This restriction can be removed in case of well-curated research datasets. In this case, it is imperative to verify that no overlays comprising personal informations have been added to the image as part of the pixel information.



### 3. Pixel de-identification

The pixel de-identification step allows to blank a part of the image based on its coordinates. It can be used if a known part of the image contains information, for instance incrusted text, that must be removed.

By default, **no pixel de-identification is performed as part of the MIP de-identification process**.

For completeness, the last part of this document exposes some general information on this subject.

#### Automatic incrustation of text 

Gnubila has provided a default pixel-removal script, which deletes the image zones where personal informations might have been written directly on the image by the producing machine. The machine that generated the image is recognised based on the tags, among a broad list of machines used by Gnubila's partners and clients. 

In case the producing machine model is not recognised, the pixel de-identification will fail and the images will be put in quarantine. They can be de-identification by adding a new rule for the unrecognised model, or by explicitly skipping this step.

This profile is **not** used for MIP, as it is not compatible with the image processing features of the MIP Data Factory. 

#### Manual annotation of images

The other potential source of incrusted text are editions performed on the file after acquisition. It is necessary to ensure that such annotations do not appear in files uploaded in the MIP, as it is impossible to automatically detect all possible text incrustations.

DICOM files contain a tag which (if used correctly) indicates "primary" when the image was just produced by the machine, and "secondary" if it has been edited. As secondary files are more likely to contain unchecked annotations incrusted in the images, the MIP strategy is to accept only primary clinical images.

