---
date: 2017-07-11T16:00:35.000Z
title: Imaging data
creatordisplayname: Mirco NASUTI
creatoremail: mirco.nasuti@chuv.ch
lastmodifierdisplayname: Mirco NASUTI
lastmodifieremail: mirco.nasuti@chuv.ch
toc: true
weight: 31
---

## Requirements

In order to be pre-processed by the Data Factory, the imaging data have to meet some requirements, both regarding the images format and the images meta-data.

### Images format

- The images must be provided either in DICOM or NIFTI format.
- The images must be high-resolution (< 1.5 mm) T1-weighted sagittal images.
- If the dataset contains other types of images (e.g. any fMRI data, T2 images, etc) in addition to the compatible ones, a list of protocol names used and their compatibility status regarding the above criterion has to be provided.

### Images Meta-data

Imaging meta-data typically are the information contained in the DICOM tags. If the images are provided in NIFTI format or some of the mandatory DICOM tags are missing from the images, those meta-data must be provided in one or several extra file(s) (e.g. json or csv files).

Here is a list of DICOM tags we are interested in :

TAG                        | TYPE | MANDATORY | DESCRIPTION
-------------------------- | ---- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------
PatientID                  | LO   | T         | Patient identifier.
StudyID                    | SH   | T         | Study identifier. Used to identify a visit. (Unique per dataset or per patient)
SeriesDescription          | LO   | T         | Series description. Used to describe the scanning sequence/protocol.
SeriesNumber               | IS   | T         | Series number. Used to identify a scan run.
InstanceNumber             | IS   | T         | Image (slice) identifier.
ImagePosition              | DS   | T         | Image (slice) position.
ImageOrientation           | DS   | T         | Image (slice) orientation.
SliceLocation              | DS   | T         | Slice location.
SamplesPerPixel            | US   | T         | Number of samples (planes) per pixel. Usually, 1 for monochrome (gray scale) and palette color images, or 3 for RGB images.
Rows                       | US   | T         | Number of rows in the image.
Columns                    | US   | T         | Number of columns in the image.
PixelSpacing               | DS   | T         | Distance between the center of each pixel.
BitsAllocated              | US   | T         | Number of bits allocated for each pixel sample.
BitsStored                 | US   | T         | Number of bits stored for each pixel sample.
HighBit                    | US   | T         | Most significant bit for pixel sample data.
AcquisitionDate            | DA   | 1         | Acquisition date. We try to use it as the scan date.
SeriesDate                 | DA   | 1         | Series (scan run) date. If AcquisitionDate is missing, we use it as a scan date.
PatientAge                 | AS   | 2         | Patient age at scan date.
PatientBirthDate           | DA   | 2         | Patient's birth date.
MagneticFieldStrength      | DS   | F         | Magnetic field strength.
PatientSex                 | LO   | F         | Patient gender.
Manufacturer               | LO   | F         | Scanner manufacturer.
ManufacturerModelName      | LO   | F         | Scanner model name.
InstitutionName            | LO   | F         | Institution name.
StudyDescription           | LO   | F         | Study (visit) description.
SliceThickness             | DS   | F         | Slice thickness in mm.
RepetitionTime             | DS   | F         | The period of time in msec between the beginning of a pulse sequence and the beginning of the succeeding (essentially identical) pulse sequence.
EchoTime                   | DS   | F         | Time in ms between the middle of the excitation pulse and the peak of the echo produced (kx=0).
SpacingBetweenSlices       | DS   | F         | Spacing between slices in mm (from center to center).
NumberOfPhaseEncodingSteps | IS   | F         | Total number of lines in k-space in the 'y' direction collected during acquisition.
EchoTrainLength            | IS   | F         | Number of lines in k-space acquired per excitation per image.
PercentPhaseFieldOfView    | DS   | F         | Ratio of field of view dimension in phase direction to field of view dimension in frequency direction, expressed as a percent.
PixelBandwidth             | DS   | F         | Reciprocal of the total sampling period, in hertz per pixel.
FlipAngle                  | DS   | F         | Steady state angle in degrees to which the magnetic vector is flipped from the magnetic vector of the primary field.
PercentSampling            | DS   | F         | Fraction of acquisition matrix lines acquired, expressed as a percent.
EchoNumber                 | IS   | F         | The echo number used in generating this image. In the case of segmented k-space, it is the effective Echo Number.

For more information about the attributes type, have a look at : <http://northstar-www.dartmouth.edu/doc/idl/html_6.2/Value_Representations.html>.

Note that the 'MANDATORY' column contains a 'T' if the tag is needed and a 'F' if it is recommended but optional. If the column contains a number, only one of the tags showing the same number in the 'MANDATORY' column is needed (e.g. only one of the PatientAge and PatientBirthDate tags is needed).
