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

from abc import ABC, abstractmethod
from collections.abc import Sequence
from enum import Enum

from opengis.metadata.citation import Citation, Identifier
from opengis.metadata.naming import GenericName, MemberName, Record, RecordType


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


class RangeElementDescription(ABC):
    """Description of specific range elements."""

    @property
    @abstractmethod
    def name(self) -> str:
        """Designation associated with a set of range elements."""

    @property
    @abstractmethod
    def definition(self) -> str:
        """Description of a set of specific range elements."""

    @property
    @abstractmethod
    def range_element(self) -> Sequence[Record]:
        """
        Specific range elements, i.e. range elements associated with a name
        and definition defining their meaning.
        """


class RangeDimension(ABC):
    """Information on the range of attribute values."""

    @property
    @abstractmethod
    def sequence_identifier(self) -> MemberName:
        """
        Number that uniquely identifies instances of bands of wavelengths on
        which a sensor operates.
        """

    @property
    @abstractmethod
    def description(self) -> str:
        """Description of the range of a cell measurement value."""

    @property
    @abstractmethod
    def name(self) -> Sequence[Identifier]:
        """
        Identifiers for each attribute included in the resource. These
        identifiers can be used to provide names for the resource's attribute
        from a standard set of names.
        """


class AttributeGroup(ABC):
    """ 
    """

    @property
    @abstractmethod
    def content_type(self) -> Sequence[CoverageContentTypeCode]:
        """Type of information represented by the value."""

    @property
    @abstractmethod
    def attribute(self) -> Sequence[RangeDimension]:
        """"""


class SampleDimension(RangeDimension):
    """
    The characteristics of each dimension (layer) included in the resource.
    """

    @property
    @abstractmethod
    def max_value(self) -> float:
        """
        Maximum value of data values in each dimension included in the
        resource. Restricted to UomLength in the MD_Band class.
        """

    @property
    @abstractmethod
    def min_value(self) -> float:
        """
        Minimum value of data values in each dimension included in the
        resource. Restricted to UomLength in the MD_Band class.
        """

    @property
    @abstractmethod
    def units(self) -> UnitOfMeasure:
        """
        Units of data in each dimension included in the resource. Note that
        the type of this is `UnitOfMeasure` and that it is restricted to
        UomLength in the MD_Band class.
        """

    @property
    @abstractmethod
    def scale_factor(self) -> float:
        """Scale factor which has been applied to the cell value."""

    @property
    @abstractmethod
    def offset(self) -> float:
        """The physical value corresponding to a cell value of zero."""

    @property
    @abstractmethod
    def mean_value(self) -> float:
        """
        Mean value of data values in each dimension included in the resource.
        """

    @property
    @abstractmethod
    def number_of_values(self) -> int:
        """
        This gives the number of values used in a thematicClassification
        resource, e.g., the number of classes in a Land Cover Type coverage or
        the number of cells with data in other types of coverages.
        """

    @property
    @abstractmethod
    def standard_deviation(self) -> float:
        """
        Standard deviation of data values in each dimension included in the
        resource.
        """

    @property
    @abstractmethod
    def other_property_type(self) -> RecordType:
        """
        Type of other attribute description (i.e. netcdf/variable in ncml.xsd).
        """

    @property
    @abstractmethod
    def other_property(self) -> Record:
        """
        Instance of otherAttributeType that defines attributes not explicitly
        included in MD_CoverageType.
        """

    @property
    @abstractmethod
    def bits_per_value(self) -> int:
        """
        Maximum number of significant bits in the uncompressed representation
        for the value in each band of each pixel.
        """

    @property
    @abstractmethod
    def transfer_function_type(self) -> TransferFunctionTypeCode:
        """
        Type of transfer function to be used when scaling a physical value for
        a given element.
        """

    @property
    @abstractmethod
    def range_element_description(self) -> Sequence[RangeElementDescription]:
        """
        Provides the description and values of the specific range elements of
        a sample dimension.
        """

    @property
    @abstractmethod
    def nominal_spatial_resolution(self) -> float:
        """
        Smallest distance between which separate points can be distinguished,
        as specified in instrument design.
        """


class Band(SampleDimension):
    """Range of wavelengths in the electromagnetic spectrum."""

    @property
    @abstractmethod
    def bound_max(self) -> float:
        """Bounding maximum."""

    @property
    @abstractmethod
    def bound_min(self) -> float:
        """Bounding minimum."""

    @property
    @abstractmethod
    def bound_units(self) -> UomLength:
        """Bounding units."""

    @property
    @abstractmethod
    def peak_response(self) -> float:
        """Wavelength at which the response is the highest."""

    @property
    @abstractmethod
    def tone_gradation(self) -> int:
        """Number of discrete numerical values in the grid data."""

    @property
    @abstractmethod
    def band_boundary_definition(self) -> BandDefinition:
        """
        Designation of criterion for defining maximum and minimum wavelengths
        for a spectral band.
        """

    @property
    @abstractmethod
    def transmitted_polarisation(self) -> PolarisationOrientationCode:
        """Polarisation of the transmitter or detector."""

    @property
    @abstractmethod
    def detected_polarisation(self) -> PolarisationOrientationCode:
        """Polarisation of the transmitter or detector."""


class ContentInformation(ABC):
    """Description of the content of a resource."""


class CoverageDescription(ContentInformation):
    """Details about the content of a resource."""

    @property
    @abstractmethod
    def attribute_description(self) -> RecordType:
        """Description of the attribute described by the measurement value."""

    @property
    @abstractmethod
    def processing_level_code(self) -> Identifier:
        """
        Code and codespace that identifies the level of processing that has
        been applied to the resource.
        """

    @property
    @abstractmethod
    def attribute_group(self) -> Sequence[AttributeGroup]:
        """"""

    @property
    @abstractmethod
    def range_element_description(self) -> Sequence[RangeElementDescription]:
        """"""


class ImageDescription(CoverageDescription):
    """Information about an image's suitability for use."""

    @property
    @abstractmethod
    def illumination_elevation_angle(self) -> float:
        """
        Illumination elevation measured in degrees clockwise from the target
        plane at intersection of the optical line of sight with the Earth's
        surface. For images from a scanning device, refer to the centre pixel
        of the image.
        """

    @property
    @abstractmethod
    def illumination_azimuth_angle(self) -> float:
        """
        Illumination azimuth measured in degrees clockwise from true north at
        the time the image is taken. For images from a scanning device, refer
        to the centre pixel of the image.
        """

    @property
    @abstractmethod
    def imaging_condition(self) -> ImagingConditionCode:
        """Conditions affected the image."""

    @property
    @abstractmethod
    def image_quality_code(self) -> Identifier:
        """Code in producers code space that specifies the image quality."""

    @property
    @abstractmethod
    def cloud_cover_percentage(self) -> float:
        """
        Area of the dataset obscured by clouds, expressed as a percentage of
        the spatial extent.
        """

    @property
    @abstractmethod
    def compression_generation_quantity(self) -> int:
        """
        Count of the number of lossy compression cycles performed on the image.
        """

    @property
    @abstractmethod
    def triangulation_indicator(self):
        """
        Indication of whether or not triangulation has been performed upon the
        image.
        """

    @property
    @abstractmethod
    def radiometric_calibration_data_availability(self):
        """
        Indication of whether or not the radiometric calibration information
        for generating the radiometrically calibrated standard data product is
        available.
        """

    @property
    @abstractmethod
    def camera_calibration_information_availability(self):
        """
        Indication of whether or not constants are available which allow for
        camera calibration corrections.
        """

    @property
    @abstractmethod
    def film_distortion_information_availability(self):
        """
        Indication of whether or not Calibration Reseau information is
        available.
        """

    @property
    @abstractmethod
    def lens_distortion_information_availability(self):
        """
        Indication of whether or not lens aberration correction information is
        available.
        """


class FeatureTypeInfo(ABC):
    """"""

    @property
    @abstractmethod
    def feature_type_name(self) -> GenericName:
        """"""

    @property
    @abstractmethod
    def feature_instance_count(self) -> int:
        """"""


class FeatureCatalogueDescription(ContentInformation):
    """
    Information identifying the feature catalogue or the conceptual schema.
    """

    @property
    @abstractmethod
    def compliance_code(self):
        """
        Indication of whether or not the cited feature catalogue complies with
        ISO 19110.
        """

    @property
    @abstractmethod
    def locale(self):
        """Language(s) used within the catalogue."""

    @property
    @abstractmethod
    def included_with_dataset(self):
        """
        Indication of whether or not the feature catalogue is included with
        the resource.
        """

    @property
    @abstractmethod
    def feature_types(self) -> Sequence[FeatureTypeInfo]:
        """
        Subset of feature types from cited feature catalogue occurring in
        dataset.
        """

    @property
    @abstractmethod
    def feature_catalogue_citation(self) -> Sequence[Citation]:
        """
        Complete bibliographic reference to one or more external feature
        catalogues.
        """
