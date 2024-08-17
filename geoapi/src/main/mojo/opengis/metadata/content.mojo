# ===----------------------------------------------------------------------=== #
#    GeoAPI - Mojo interfaces (traits, structs) for OGC/ISO standards
#    Copyright © 2024 Open Geospatial Consortium, Inc.
#    http: //www.geoapi.org
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http: //www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
# ===----------------------------------------------------------------------=== #
"""This is the content module.

This module contains geographic metadata structures regarding data content
derived from the ISO 19115-1:2014 and ISO 19115-2:2018 international standards.
"""

from opengis.metadata.citation import Identifier, Citation
from opengis.metadata.naming import Record, MemberName, RecordType, GenericName


struct BandDefinition():
    alias THREE_DB = "3dB"
    alias HALF_MAXIMUM = "halfMaximum"
    alias FIFTY_PERCENT = "fiftyPercent"
    alias ONE_OVER_E = "oneOverE"
    alias EQUIVALENT_WIDTH = "equivalentWidth"


struct CoverageContentTypeCode():
    alias IMAGE = "image"
    alias THEMATIC_CLASSIFICATION = "thematicClassification"
    alias PHYSICAL_MEASUREMENT = "physicalMeasurement"
    alias AUXILLARY_INFORMATION = "auxillaryInformation"
    alias QUALITY_INFORMATION = "qualityInformation"
    alias REFERENCE_INFORMATION = "referenceInformation"
    alias MODEL_RESULT = "modelResult"
    alias COORDINATE = "coordinate"


struct ImagingConditionCode():
    alias BLURRED_IMAGE = "blurredImage"
    alias CLOUD = "cloud"
    alias DEGRADING_OBLIQUITY = "degradingObliquity"
    alias FOG = "fog"
    alias HEAVY_SMOKE_OR_DUST = "heavySmokeOrDust"
    alias NIGHT = "night"
    alias RAIN = "rain"
    alias SEMI_DARKNESS = "semiDarkness"
    alias SHADOW = "shadow"
    alias SNOW = "snow"
    alias TERRAIN_MASKING = "terrainMasking"


struct PolarisationOrientationCode():
    alias HORIZONTAL = "horizontal"
    alias VERTICAL = "vertical"
    alias LEFT_CIRCULAR = "leftCircular"
    alias RIGHT_CIRCULAR = "rightCircular"
    alias THETA = "theta"
    alias PHI = "phi"


struct TransferFunctionTypeCode():
    alias LINEAR = "linear"
    alias LOGARITHMIC = "logarithmic"
    alias EXPONENTIAL = "exponential"


trait RangeElementDescription():
    """Description of specific range elements."""

    fn name(self) -> String:
        """Designation associated with a set of range elements."""
        ...

    fn definition(self) -> String:
        """Description of a set of specific range elements."""
        ...

    fn range_element(self) -> Sequence[Record]:
        """Specific range elements, i.e. range elements associated with a name and definition defining their meaning."""
        ...


trait RangeDimension():
    """Information on the range of attribute values."""

    fn sequence_identifier(self) -> MemberName:
        """Number that uniquely identifies instances of bands of wavelengths on which a sensor operates."""
        ...

    fn description(self) -> String:
        """Description of the range of a cell measurement value."""
        ...

    fn name(self) -> Sequence[Identifier]:
        """Identifiers for each attribute included in the resource. These identifiers can be used to provide names for the resource's attribute from a standard set of names."""
        ...


trait AttributeGroup():

    fn content_type(self) -> Sequence[CoverageContentTypeCode]:
        """Type of information represented by the value."""
        ...

    fn attribute(self) -> Sequence[RangeDimension]:
        ...


trait SampleDimension(RangeDimension):
    """The characteristics of each dimension (layer) included in the resource."""

    fn max_value(self) -> Float64:
        """Maximum value of data values in each dimension included in the resource. Restricted to UomLength in the MD_Band class."""
        ...

    fn min_value(self) -> Float64:
        """Minimum value of data values in each dimension included in the resource. Restricted to UomLength in the MD_Band class."""
        ...

    fn units(self):
        """Units of data in each dimension included in the resource. Note that the type of this is UnitOfMeasure and that it is restricted to UomLength in the MD_Band class."""
        ...

    fn scale_factor(self) -> Float64:
        """Scale factor which has been applied to the cell value."""
        ...

    fn offset(self) -> Float64:
        """The physical value corresponding to a cell value of zero."""
        ...

    fn mean_value(self) -> Float64:
        """Mean value of data values in each dimension included in the resource."""
        ...

    fn number_of_values(self) -> Int:
        """This gives the number of values used in a thematicClassification resource EX:. the number of classes in a Land Cover Type coverage or the number of cells with data in other types of coverages."""
        ...

    fn standard_deviation(self) -> Float64:
        """Standard deviation of data values in each dimension included in the resource."""
        ...

    fn other_property_type(self) -> RecordType:
        """Type of other attribute description (i.e. netcdf/variable in ncml.xsd)."""
        ...

    fn other_property(self) -> Record:
        """Instance of otherAttributeType that defines attributes not explicitly included in MD_CoverageType."""
        ...

    fn bits_per_value(self) -> Int:
        """Maximum number of significant bits in the uncompressed representation for the value in each band of each pixel."""
        ...

    fn transfer_function_type(self) -> TransferFunctionTypeCode:
        """Type of transfer function to be used when scaling a physical value for a given element."""
        ...

    fn range_element_description(self) -> Sequence[RangeElementDescription]:
        """Provides the description and values of the specific range elements of a sample dimension."""
        ...

    fn nominal_spatial_resolution(self) -> Float64:
        """Smallest distance between which separate points can be distinguished, as specified in instrument design."""
        ...


trait Band(SampleDimension):
    """Range of wavelengths in the electromagnetic spectrum."""

    fn bound_max(self) -> Float64:
        ...

    fn bound_min(self) -> Float64:
        ...

    fn bound_units(self):
        ...

    fn peak_response(self) -> Float64:
        """Wavelength at which the response is the highest."""
        ...

    fn tone_gradation(self) -> Int:
        """Number of discrete numerical values in the grid data."""
        ...

    fn band_boundary_definition(self) -> BandDefinition:
        """Designation of criterion for defining maximum and minimum wavelengths for a spectral band."""
        ...

    fn transmitted_polarisation(self) -> PolarisationOrientationCode:
        """Polarisation of the transmitter or detector."""
        ...

    fn detected_polarisation(self) -> PolarisationOrientationCode:
        """Polarisation of the transmitter or detector."""
        ...


trait ContentInformation():
    """Description of the content of a resource."""
...


trait CoverageDescription(ContentInformation):
    """Details about the content of a resource."""

    fn attribute_description(self) -> RecordType:
        """Description of the attribute described by the measurement value."""
        ...

    fn processing_level_code(self) -> Identifier:
        """Code and codespace that identifies the level of processing that has been applied to the resource."""
        ...

    fn attribute_group(self) -> Sequence[AttributeGroup]:
        ...

    fn range_element_description(self) -> Sequence[RangeElementDescription]:
        ...


trait ImageDescription(CoverageDescription):
    """Information about an image's suitability for use."""

    fn illumination_elevation_angle(self) -> Float64:
        """Illumination elevation measured in degrees clockwise from the target plane at intersection of the optical line of sight with the Earth's surface. For images from a scanning device, refer to the centre pixel of the image."""
        ...

    fn illumination_azimuth_angle(self) -> Float64:
        """Illumination azimuth measured in degrees clockwise from true north at the time the image is taken. For images from a scanning device, refer to the centre pixel of the image."""
        ...

    fn imaging_condition(self) -> ImagingConditionCode:
        """Conditions affected the image."""
        ...

    fn image_quality_code(self) -> Identifier:
        """Code in producers code space that specifies the image quality."""
        ...

    fn cloud_cover_percentage(self) -> Float64:
        """Area of the dataset obscured by clouds, expressed as a percentage of the spatial extent."""
        ...

    fn compression_generation_quantity(self) -> Int:
        """Count of the number of lossy compression cycles performed on the image."""
        ...

    fn triangulation_indicator(self):
        """Indication of whether or not triangulation has been performed upon the image."""
        ...

    fn radiometric_calibration_data_availability(self):
        """Indication of whether or not the radiometric calibration information for generating the radiometrically calibrated standard data product is available."""
        ...

    fn camera_calibration_information_availability(self):
        """Indication of whether or not constants are available which allow for camera calibration corrections."""
        ...

    fn film_distortion_information_availability(self):
        """Indication of whether or not Calibration Reseau information is available."""
        ...

    fn lens_distortion_information_availability(self):
        """Indication of whether or not lens aberration correction information is available."""
        ...


trait FeatureTypeInfo():

    fn feature_type_name(self) -> GenericName:
        ...

    fn feature_instance_count(self) -> Int:
        ...


trait FeatureCatalogueDescription(ContentInformation):
    """Information identifying the feature catalogue or the conceptual schema."""

    fn compliance_code(self):
        """Indication of whether or not the cited feature catalogue complies with ISO 19110."""
        ...

    fn locale(self):
        """Language(s) used within the catalogue."""
        ...

    fn included_with_dataset(self):
        """Indication of whether or not the feature catalogue is included with the resource."""
        ...

    fn feature_types(self) -> Sequence[FeatureTypeInfo]:
        """Subset of feature types from cited feature catalogue occurring in dataset."""
        ...

    fn feature_catalogue_citation(self) -> Sequence[Citation]:
        """Complete bibliographic reference to one or more external feature catalogues."""
        ...
