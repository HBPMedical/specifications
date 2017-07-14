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
- The images must be high-resolution (max. 1.5 mm) T1-weighted sagittal images.
- If the dataset contains other types of images (that is not meeting the above description, e.g. fMRI data, T2 images, etc), a list of protocol names used and their compatibility status regarding the above criterion has to be provided.

### Images Meta-data

Imaging meta-data typically are the information contained in the DICOM tags. If the images are provided in NIFTI format or some of the mandatory DICOM tags are missing from the images, those meta-data must be provided in one or several extra file(s) (e.g. json or csv files).

Here is a list of DICOM tags we are interested in :

TAG                        | TYPE | MANDATORY | DESCRIPTION
-------------------------- | ---- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------
PatientID                  | LO   | Yes       | Patient identifier.
StudyID                    | SH   | Yes       | Study identifier. Used to identify a visit. (Unique per dataset or per patient)
SeriesDescription          | LO   | Yes       | Series description. Used to describe the scanning sequence/protocol.
SeriesNumber               | IS   | Yes       | Series number. Used to identify a scan run.
InstanceNumber             | IS   | Yes       | Image (slice) identifier.
ImagePosition              | DS   | Yes       | Image (slice) position.
ImageOrientation           | DS   | Yes       | Image (slice) orientation.
SliceLocation              | DS   | Yes       | Slice location.
SamplesPerPixel            | US   | Yes       | Number of samples (planes) per pixel. Usually, 1 for monochrome (gray scale) and palette color images, or 3 for RGB images.
Rows                       | US   | Yes       | Number of rows in the image.
Columns                    | US   | Yes       | Number of columns in the image.
PixelSpacing               | DS   | Yes       | Distance between the center of each pixel.
BitsAllocated              | US   | Yes       | Number of bits allocated for each pixel sample.
BitsStored                 | US   | Yes       | Number of bits stored for each pixel sample.
HighBit                    | US   | Yes       | Most significant bit for pixel sample data.
AcquisitionDate            | DA   | 1         | Acquisition date. We try to use it as the scan date.
SeriesDate                 | DA   | 1         | Series (scan run) date. If AcquisitionDate is missing, we use it as a scan date.
PatientAge                 | AS   | 2         | Patient age at scan date.
PatientBirthDate           | DA   | 2         | Patient's birth date.
MagneticFieldStrength      | DS   | No        | Magnetic field strength.
PatientSex                 | LO   | No        | Patient gender.
Manufacturer               | LO   | No        | Scanner manufacturer.
ManufacturerModelName      | LO   | No        | Scanner model name.
InstitutionName            | LO   | No        | Institution name.
StudyDescription           | LO   | No        | Study (visit) description.
SliceThickness             | DS   | No        | Slice thickness in mm.
RepetitionTime             | DS   | No        | The period of time in msec between the beginning of a pulse sequence and the beginning of the succeeding (essentially identical) pulse sequence.
EchoTime                   | DS   | No        | Time in ms between the middle of the excitation pulse and the peak of the echo produced (kx=0).
SpacingBetweenSlices       | DS   | No        | Spacing between slices in mm (from center to center).
NumberOfPhaseEncodingSteps | IS   | No        | Total number of lines in k-space in the 'y' direction collected during acquisition.
EchoTrainLength            | IS   | No        | Number of lines in k-space acquired per excitation per image.
PercentPhaseFieldOfView    | DS   | No        | Ratio of field of view dimension in phase direction to field of view dimension in frequency direction, expressed as a percent.
PixelBandwidth             | DS   | No        | Reciprocal of the total sampling period, in hertz per pixel.
FlipAngle                  | DS   | No        | Steady state angle in degrees to which the magnetic vector is flipped from the magnetic vector of the primary field.
PercentSampling            | DS   | No        | Fraction of acquisition matrix lines acquired, expressed as a percent.
EchoNumber                 | IS   | No        | The echo number used in generating this image. In the case of segmented k-space, it is the effective Echo Number.

For more information about the attributes type, have a look at : <http://northstar-www.dartmouth.edu/doc/idl/html_6.2/Value_Representations.html>.

NOTE: If the 'MANDATORY' column contains a number, only one of the tags marked with the same number is needed (e.g. only one of the 'PatientAge' and 'PatientBirthDate' tags is needed).
