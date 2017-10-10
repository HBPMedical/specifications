# MIP anonymisation strategy

This goal of the document is to clarify how anonymisation is performed in MIP, using Gnubila FedEHR software.
It also lists possible approaches for the anonymisation of DICOM files.


The anonymiser can treat CSV files and DICOM files. Its functionalities are described below, with [future functionalities] identified with brackets.

## Anonymisation principles [to be confirmed]

Following the general principles defined in the <a href="https://drive.google.com/drive/folders/0B5CgbpurVVlHZlRpeG40ZlVoTjA"> Medical Informatics Platform (SP8): Privacy Impact Assessment</a>  and further internal consultations, the MIP anonymisation principles can be summarised as:

- Patients should be identified with a unique identifier specific to the partner providing the data. This identifier will be pseudonymised, i.e. replaced with a generated pseudo-identifier (hash). The link between the original identifier and the pseudo-identifier is stored by the anonymiser in a dedicated database.
- All other identifiers present in the original data (visit id, etc.) will also be pseudonymised.
- The birth dates will be reduced to the year.
- All other dates will be reduced to the year by default, or to the month if explicitly requested. [To be confirmed]
- Patient names, addresses and similar information should not appear in documents provided for the platform. If they do, they are removed at the anonymisation level.
- Specific rules can be defined for other fields based on the requirements.
- By default, information that is not needed for research purposes should be removed.



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

- File and folder names.
- Removal or anonymisation of information stored in DICOM tags.
- Blanking of pixels in the image (to erase potential embedded private information).

The anonymiser must be configured for the last two parts. Once defined, the same anonymisation profiles are used for all DICOM files.

### File and folder names

The names of the DICOM files and folders will be removed; random names will be generated, which maintain the order of DICOM files in the same sequence.

### Tag anonymisation

The list of tags used by the Data Factory (~ 40, mandatory or optional) can be found on the <a href=https://hbpmedical.github.io/specifications/data-factory/images/>MIP specifications website</a>. We will call these the "MIP selected tags".


- For the MIP selected tags (mandatory and optional tags):

The rules to anonymise the MIP selected tags must be defined in all cases. This can be done using the file `Template_DICOM_anonymisation_profile.xlsx` available <a href=>here</a>.

If necessary, the MIP / DGDS can impose standard rules for all hospitals (so that the Data Factory input is similar at all hospitals).



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

Original DICOM files that are generated by the acquiring machine are the most likely to follow the DICOM standard than user-modified files. In particular, modified files can contain overlays The original images should contain the key-word "primary" in the tag 0008,0008.

Further, to prevent the use of images annotated by physicians, only "primary" images will be accepted. As modified images are tagged "secondary", this prevents unchecked overlay images to pass the anonymisation step.

This restriction can be removed. In this case, it is imperative to verify if overlays comprising personal informations might have been added to the image as part of the pixel information, and to devise a mean to remove such overlay information.



### Pixel anonymisation

Gnubila has provided a default pixel-anonymiser script, which deletes the image zones where personal informations might have been written directly on the image by the producing machine. The machine that generated the image is recognised based on the tags, among a broad list of machines used by Gnubila's partners and clients. 

The profile is used by default in MIP. In case the producing machine is not recognised, the pixel anonymiser will fail and the image will be put in quarantine.
