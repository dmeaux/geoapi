# ===-----------------------------------------------------------------------===
#    GeoAPI - Python interfaces (abstractions) for OGC/ISO standards
#    Copyright © 2013-2024 Open Geospatial Consortium, Inc.
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
# ===-----------------------------------------------------------------------===
"""This is the content module.

This module contains geographic metadata structures regarding data content
derived from the ISO 19115-1:2014 and ISO 19115-2:2018 international standards.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass
from enum import Enum

from opengis.metadata.citation import (
    Citation,
    Identifier,
)
from opengis.metadata.naming import (
    GenericName,
    MemberName,
    Record,
    RecordType,
)


class BandDefinition(Enum):
    """
    Designation of the criterion for defining wavelengths of a spectral band.
    """

    THREE_DB = "3dB"
    HALF_MAXIMUM = "halfMaximum"
    FIFTY_PERCENT = "fiftyPercent"
    ONE_OVER_E = "oneOverE"
    EQUIVALENT_WIDTH = "equivalentWidth"


class CoverageContentTypeCode(Enum):
    """
    Transformation function to be used when scaling a physical value of a
    given element.
    """

    IMAGE = "image"
    THEMATIC_CLASSIFICATION = "thematicClassification"
    PHYSICAL_MEASUREMENT = "physicalMeasurement"
    AUXILLARY_INFORMATION = "auxillaryInformation"
    QUALITY_INFORMATION = "qualityInformation"
    REFERENCE_INFORMATION = "referenceInformation"
    MODEL_RESULT = "modelResult"
    COORDINATE = "coordinate"


class ImagingConditionCode(Enum):
    """
    Code which indicates conditions which may affect the image.
    """

    BLURRED_IMAGE = "blurredImage"
    CLOUD = "cloud"
    DEGRADING_OBLIQUITY = "degradingObliquity"
    FOG = "fog"
    HEAVY_SMOKE_OR_DUST = "heavySmokeOrDust"
    NIGHT = "night"
    RAIN = "rain"
    SEMI_DARKNESS = "semiDarkness"
    SHADOW = "shadow"
    SNOW = "snow"
    TERRAIN_MASKING = "terrainMasking"


class PolarisationOrientationCode(Enum):
    """Polarization of the antenna in relation to the wave form."""

    HORIZONTAL = "horizontal"
    VERTICAL = "vertical"
    LEFT_CIRCULAR = "leftCircular"
    RIGHT_CIRCULAR = "rightCircular"
    THETA = "theta"
    PHI = "phi"


class TransferFunctionTypeCode(Enum):
    """
    Transform function to be used when scaling a physical value for a given
    element.
    """

    LINEAR = "linear"
    LOGARITHMIC = "logarithmic"
    EXPONENTIAL = "exponential"


@dataclass(frozen=True, slots=True)
class RangeElementDescription:
    """Description of specific range elements.

    Attributes:
        name (str): Designation associated with a set of range elements.
        definition (str): Description of a set of specific range elements.
        range_element (tuple[Record, ...]): Specific range elements, i.e.
            range elements associated with a name and definition defining
            their meaning.

    """

    name: str
    definition: str
    range_element: tuple[Record, ...]


@dataclass(frozen=True, slots=True)
class RangeDimension:
    """Information on the range of attribute values.

    Attributes:
        sequence_identifier (MemberName): Number that uniquely identifies
            instances of bands of wavelengths on which a sensor operates.
        description (str): Description of the range of a cell measurement
            value.
        name (tuple[Identifier, ...]): Identifiers for each attribute included
            in the resource. These identifiers can be used to provide names
            for the resource's attribute from a standard set of names.

    """

    sequence_identifier: MemberName
    description: str
    name: tuple[Identifier, ...]


@dataclass(frozen=True, slots=True)
class AttributeGroup:
    """ 

    Attributes:
        content_type (tuple[CoverageContentTypeCode, ...]): Type of
            information represented by the value.
        attribute (tuple[RangeDimension, ...]): 

    """

    content_type: tuple[CoverageContentTypeCode, ...]
    attribute: tuple[RangeDimension, ...]


@dataclass(frozen=True, slots=True)
class SampleDimension(RangeDimension):
    """The characteristics of each dimension (layer) included in the resource.

    Attributes:
        max_value (float): Maximum value of data values in each dimension
            included in the resource. Restricted to UomLength in the MD_Band
            class.
        min_value (float): Minimum value of data values in each dimension
            included in the resource. Restricted to UomLength in the MD_Band
            class.
        units (UnitOfMeasure): Units of data in each dimension included in the
            resource. Note that the type of this is UnitOfMeasure and that it
            is restricted to UomLength in the MD_Band class.
        scale_factor (float): Scale factor which has been applied to the cell
            value.
        offset (float): The physical value corresponding to a cell value of
            zero.
        mean_value (float): Mean value of data values in each dimension
            included in the resource.
        number_of_values (int): This gives the number of values used in a
            thematicClassification resource EX:. the number of classes in a
            Land Cover Type coverage or the number of cells with data in other
            types of coverages.
        standard_deviation (float): Standard deviation of data values in each
            dimension included in the resource.
        other_property_type (RecordType): Type of other attribute description
            (i.e. netcdf/variable in ncml.xsd).
        other_property (Record): Instance of otherAttributeType that defines
            attributes not explicitly included in MD_CoverageType.
        bits_per_value (int): Maximum number of significant bits in the
            uncompressed representation for the value in each band of each
            pixel.
        transfer_function_type (TransferFunctionTypeCode): Type of transfer
            function to be used when scaling a physical value for a given
            element.
        range_element_description (tuple[RangeElementDescription, ...]):
            Provides the description and values of the specific range elements
            of a sample dimension.
        nominal_spatial_resolution (float): Smallest distance between which
            separate points can be distinguished, as specified in instrument
            design.

    """

    max_value: float
    min_value: float
    units: UnitOfMeasure
    scale_factor: float
    offset: float
    mean_value: float
    number_of_values: int
    standard_deviation: float
    other_property_type: RecordType
    other_property: Record
    bits_per_value: int
    transfer_function_type: TransferFunctionTypeCode
    range_element_description: tuple[RangeElementDescription, ...]
    nominal_spatial_resolution: float


@dataclass(frozen=True, slots=True)
class Band(SampleDimension):
    """Range of wavelengths in the electromagnetic spectrum.

    Attributes:
        bound_max (float): Bounding maximum.
        bound_min (float): Bounding minimum.
        bound_units (UomLength): Bounding units.
        peak_response (float): Wavelength at which the response is the highest.
        tone_gradation (int): Number of discrete numerical values in the grid
            data.
        band_boundary_definition (BandDefinition): Designation of criterion
            for defining maximum and minimum wavelengths for a spectral band.
        transmitted_polarisation (PolarisationOrientationCode): Polarisation
            of the transmitter or detector.
        detected_polarisation (PolarisationOrientationCode): Polarisation of
            the transmitter or detector.

    """

    bound_max: float
    bound_min: float
    bound_units: UomLength
    peak_response: float
    tone_gradation: int
    band_boundary_definition: BandDefinition
    transmitted_polarisation: PolarisationOrientationCode
    detected_polarisation: PolarisationOrientationCode


@dataclass(frozen=True, slots=True)
class ContentInformation:
    """Description of the content of a resource."""


@dataclass(frozen=True, slots=True)
class CoverageDescription(ContentInformation):
    """Details about the content of a resource.

    Attributes:
        attribute_description (RecordType): Description of the attribute
            described by the measurement value.
        processing_level_code (Identifier): Code and codespace that identifies
            the level of processing that has been applied to the resource.
        attribute_group (tuple[AttributeGroup, ...]): 
        range_element_description (tuple[RangeElementDescription, ...]): 

    """
    attribute_description: RecordType
    processing_level_code: Identifier
    attribute_group: tuple[AttributeGroup, ...]
    range_element_description: tuple[RangeElementDescription, ...]


@dataclass(frozen=True, slots=True)
class ImageDescription(CoverageDescription):
    """Information about an image's suitability for use.

    Attributes:
        illumination_elevation_angle (float): Illumination elevation measured
            in degrees clockwise from the target plane at intersection of the
            optical line of sight with the Earth's surface. For images from a
            scanning device, refer to the centre pixel of the image.
        illumination_azimuth_angle (float): Illumination azimuth measured in
            degrees clockwise from true north at the time the image is taken.
            For images from a scanning device, refer to the centre pixel of
            the image.
        imaging_condition (ImagingConditionCode): Conditions affected the
            image.
        image_quality_code (Identifier): Code in producers code space that
            specifies the image quality.
        cloud_cover_percentage (float): Area of the dataset obscured by
            clouds, expressed as a percentage of the spatial extent.
        compression_generation_quantity (int): Count of the number of lossy
            compression cycles performed on the image.
        triangulation_indicator (bool): Indication of whether or not
            triangulation has been performed upon the image.
        radiometric_calibration_data_availability (bool): Indication of
            whether or not the radiometric calibration information for
            generating the radiometrically calibrated standard data product is
            available.
        camera_calibration_information_availability (bool): Indication of
            whether or not constants are available which allow for camera
            calibration corrections.
        film_distortion_information_availability (bool): Indication of whether
            or not Calibration Reseau information is available.
        lens_distortion_information_availability (bool): Indication of whether
            or not lens aberration correction information is available.

    """

    illumination_elevation_angle: float
    illumination_azimuth_angle: float
    imaging_condition: ImagingConditionCode
    image_quality_code: Identifier
    cloud_cover_percentage: float
    compression_generation_quantity: int
    triangulation_indicator: bool
    radiometric_calibration_data_availability: bool
    camera_calibration_information_availability: bool
    film_distortion_information_availability: bool
    lens_distortion_information_availability: bool


@dataclass(frozen=True, slots=True)
class FeatureTypeInfo:
    """ 

    Attributes:
        feature_type_name (GenericName): 
        feature_instance_count (int): 

    """

    feature_type_name: GenericName
    feature_instance_count: int


@dataclass(frozen=True, slots=True)
class FeatureCatalogueDescription(ContentInformation):
    """Information identifying the feature catalogue or the conceptual schema.

    Attributes:
        compliance_code (bool): Indication of whether or not the cited feature
            catalogue complies with ISO 19110.
        locale (str): Language(s) used within the catalogue.
        included_with_dataset (bool): Indication of whether or not the feature
            catalogue is included with the resource.
        feature_types (tuple[FeatureTypeInfo, ...]): Subset of feature types
            from cited feature catalogue occurring in dataset.
        feature_catalogue_citation (tuple[Citation, ...]): Complete
            bibliographic reference to one or more external feature catalogues.

    """

    compliance_code: bool
    locale: str
    included_with_dataset: bool
    feature_types: tuple[FeatureTypeInfo, ...]
    feature_catalogue_citation: tuple[Citation, ...]
