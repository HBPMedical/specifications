# MIP anonymisation strategy

This goal of the document is to clarify how anonymisation is performed in MIP, using Gnubila FedEHR software.
It also lists possible approaches for the anonymisation of DICOM files.

The anonymiser can treat CSV files and DICOM files. Its functionalities are described below, with [future functionalities] identified with brackets.


## Context

The anonymisation step documented here is only one mechanism in the overall privacy protection approach of the MIP. Strictly speaking, this step should be called "pseudonymisation": once it is performed, individual patients can still be distinguished based on pseudonymised identifiers, but they are not identified with personal data anymore.

The pseudonymised DICOM files are not intended to be available for the MIP users either locally or at the Federation level. Still, pseudonymisation is a valuable tool to decrease risks, also considering that the pseudonymised files might be hosted on a server which will be accessible from the web at the Federation stage.


## Anonymisation principles [to be confirmed]

Following the general principles defined in the <a href="https://drive.google.com/drive/folders/0B5CgbpurVVlHZlRpeG40ZlVoTjA"> Medical Informatics Platform (SP8): Privacy Impact Assessment</a>  and further internal consultations, the MIP anonymisation principles can be summarised as:

- Patients should be identified with a unique identifier specific to the partner providing the data. This identifier will be pseudonymised, i.e. replaced with a generated pseudo-identifier (hash). The link between the original identifier and the pseudo-identifier is stored by the anonymiser in a dedicated database.
- All other identifiers present in the original data (visit id, etc.) will also be pseudonymised.
- The birth dates will be reduced to the year.
- All other dates will be reduced to the month by default, or to the year if explicitly requested. [To be confirmed]
- Patient names, addresses and similar personal information should not appear in documents provided for the platform. If they do, they are removed at the anonymisation level.
- Specific rules can be defined for other fields based on the MIP or the partner's requirements.
- By default, information that is not needed for research purposes should be removed.
- The anonymisation rules for EHR data (CSV files) are defined in collaboration with the partner institution. The rules and the result of the anonymisation must be validated by the partner.
- DICOM files will be anonymised in two steps, the first one rejecting the DICOM tagged as "secondary" (see details below in the _DICOM files_ section), and the second one including them. The partner institution must be informed of the limitations of the imaging anonymisation process, chose whether secondary DICOMs must be rejected or included, and validate the result of the anonymisation. 

## Requirement regarding identifiers

Information regarding common identifiers shared among different data sources must be provided to the anonymisation team. This is particularily important for identifiers used to link two data sources: they must be anonymised in an identical manner in both sources in order to keep the links.

Note: this information must also be transfered to the teams working on the pre-processing and harmonisation of the data for coordination purposes.



## CSV files

### Format

A clean csv file format is required for running the anonymiser and integrating the data in the MIP. In this sense, the formatting should respect the following rules:

- Use a file name without spaces nor non-standard characters.
- Use column names without spaces nor non-standard characters.
- Use a unique and well-defined separator. By default, the expected separator is the comma ','. Other separators such as the semi-colon ';' can be used, but the choice should be consistent over all csv files provided to the MIP.
- Quote all text fields. Problems appear if some text fields contains the separator characters or new lines.
- Follow a unique and well-defined pattern for dates, such as dd/MM/yyyy (any pattern is acceptable).
- Enter only one type of data per column (either numerical, date, text, etc.)
- If possible, leave the field empty for null values (i.e. two separators without any character in between ',,'). If other tags are used for null values, inform the MIP anonymisation contact.
- Use the unicode file encoding UTF-8. If another encoding is used, inform the MIP anonymisation contact.



### Anonymisation

An anonymisation profile must be created for each file schema. The schema of a csv file is the list of its columns and the type (and possibly format) of the data contained in each column. 

The same anonymisation profile can be used for all files sharing the same schema. 

The anonymisation profile must define a rule for each column (remove, keep or transform).

The anonymisation will fail if:

- A column defined in the profile is not found in the file.
- The data in a column (for instance a date) does not fit the expected format.
- [requested, not yet available] The file contains a column for which no rule has been defined.


As an alternative to the last rule [not yet available either], if the file contains a column for which no rule has been defined, this column will be removed.

The current status is not satisfactory: if the file contains a column for which no rule has been defined, this column is kept without raising any alarm. If the anonymisation process is automated, this means that a column containing private information could be added to a know schema and it would pass through the anonymiser untouched.



## DICOM files

DICOM files are composed of two parts:

- a varying number of tags, either standardised or user-defined,
- the pixel data storing the image itself (it is also structured as a tag, but we distinguish it here for clarity).

The DICOM standard defines how tags should be organised, the content of standard tags (4000+) and the location of user-specific or manufacturer-specific tags. The pixel data part contains the image, and can also contain user-defined overlays.

The anonymisation process intends to be as strict as possible, and can integrate any rule requested by the partner providing the imaging data. However it cannot fully guaranty that the depersonalisation is complete in case of images that do not follow the DICOM specifications.

The anonymisation contains three parts:

1. File and folder names.
2. Removal or anonymisation of information stored in DICOM tags.
3. Blanking of pixels in the image (to erase potential embedded private information).

The anonymiser must be configured for the last two parts (dicom anonymisation profile and dicom pixel anonymisation profile). Once defined, the same anonymisation profiles are used for all DICOM files.

### 1. File and folder names

The names of the DICOM files and folders will be removed; random names will be generated, which maintain the order of DICOM files in the same sequence.

### 2. Tag anonymisation

The list of tags used by the Data Factory (~ 40, mandatory or optional) can be found on the <a href=https://hbpmedical.github.io/specifications/data-factory/images/>MIP specifications website</a>. We will call these the "MIP selected tags".


- For the MIP selected tags (mandatory and optional tags):

The rules to anonymise the MIP selected tags must be defined in all cases. This can be done using the file `Template_DICOM_anonymisation_profile.xlsx` available <a href=>here</a>.

If necessary, the MIP / DGDS can impose standard rules for all hospitals (so that the Data Factory input is similar at all hospitals).


- Tag (0008,0008): this tag is intended to distinguish original DICOM files generated by the acquisition machine and files that were edited afterward. The anonymisation process will treat both cases separately as further explained below under "Pixel anonymisation".

- For the other tags:

Different anonymisation strategies can be chosen for the remaining tags (see the next section for the current functionalities of the anonymiser). Here are the two main options:

1. MIP default approach: all other tags are removed.
It is the safest approach, but it will remove useful information that could otherwise be used in the future. This approach is also the simplest: the data providing partner reviews the anonymisation rules for the limited number of MIP selected tags and know that all others will be removed. However, this strategy limits the use of advanced visualisation software to open the anonymised DICOM. These tools usually expect several tags to be present, which might be removed by the anonymisation process. The list MIP selected tags can be extended at the partners request to keep more information.

2. The data providing partner provides the list of tags they want removed, modified or pseudonymised. In this case, the partner is responsible for the accuracy and completeness of the anonymisation rules provided.



#### Anonymiser functionalities

The anonymiser provides "removeActions" functionalities for removing tags on a global scale:

- tag: curves # Remove curves tags and all information the tags contain

- tag: overlays # Remove overlay tags and all information the tags contain. 
	- Note: overlay information might be stored either in the overlay tags, or in the image pixels. In the second case, the information will not be removed by this functionality of the anonymiser. 

- tag: privategroups # Remove private groups, i.e. all tags listed in section 7.8.1 of <a href=http://dicom.nema.org/dicom/2013/output/chtml/part05/sect_7.8.html>this web page</a>.

- tag: unspecifiedelements # Remove all unchecked elements (i.e. all tags not explicitly mentioned in the anonymisation profile). 

In theory the last option should cover the previous three options, but Gnubila recommand to use all together to increase security.

By default, these rules keep a certain number of tags:

- The individual tags 0008,0016 (SOP Class UID), 0008,0018 (SopInstanceUID) and 0020,000D (StudyInstanceUID)
- The groups 0002,XXXX (FMI group), 0028,XXXX (image description) and 7FE0,XXXX (the image)
- The tags intended to define groups of "Private Data Elements", i.e. tags xxxx,00YY where xxxx is odd.


#### General anonymisation checks

Original DICOM files that are generated by the acquiring machine are the most likely to follow the DICOM standard than user-modified files. In particular, modified files can contain overlays which data is stored with the pixel data. In this particular case, removing the overlay tags will not remove the overlay data. 

The original images should contain the key-word "primary" in the tag 0008,0008. In order to check if the images were annotated, only "primary" images will be accepted by default.
 
This restriction can be removed if necessary. In this case, it is imperative to verify if overlays comprising personal informations might have been added to the image as part of the pixel information, and to devise a mean to remove such overlay information.



### 3. Pixel anonymisation

The pixel anonymisation step allows to blank a part of the image based on its coordinates. It can be used if a know part of the image contains information, for instance incrusted text, that must be removed.

#### Automatic incrustation of text 

Gnubila has provided a default pixel-anonymiser script, which deletes the image zones where personal informations might have been written directly on the image by the producing machine. The machine that generated the image is recognised based on the tags, among a broad list of machines used by Gnubila's partners and clients. 

This profile is used by default in MIP. In case the producing machine model is not recognised, the pixel anonymiser will fail and the image will be put in quarantine. They can be anonymised by adding a new rule for the unrecognised model, or by explicitely skipping this step.

#### Manual annotation of images

The other potential source of incrusted text are editions performed on the file after acquisition. It is necessary to ensure that such annotations do not appear in files uploaded in the MIP, as it is almost impossible to detect all possible text incrustations.

DICOM files contain a tag which (if used correctly) indicates "primary" when the image was just produced by the machine, and "secondary" if it has been edited. As secondary files are more likely to contain unchecked annotations incrusted in the images, the anonymisation is performed in two steps: 

- the first step accepts only primary images,
- the second also accepts the secondary images. 

The second step will thus gather more risky files, which can be checked in priority if there is a doubt regarding possible incrusted text in the images.
