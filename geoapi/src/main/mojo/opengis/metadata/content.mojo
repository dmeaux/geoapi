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

# author: David Meaux

"""This is the content module.

This module contains geographic metadata structures regarding data content
derived from the ISO 19115-1:2014 and ISO 19115-2:2019 international standards.
"""

from opengis.metadata.citation import Citation, Identifier
from opengis.metadata.naming import GenericName, MemberName, Record, RecordType


struct BandDefinition:
    """Designation of the criterion for defining wavelengths of a spectral band.
    """

    alias THREE_DB = "3dB"
    """
    Width of a distribution equal to the distance between the outer two points\
    on the distribution having power level half of that at the peak.
    """
    alias HALF_MAXIMUM = "halfMaximum"
    """
    Width of a distribution equal to the distance between the outer two points
    on the distribution having power level half of that at the peak.
    """
    alias FIFTY_PERCENT = "fiftyPercent"
    """
    Full spectral width of a spectral power density measured at 50 % of its
    peak height.
    """
    alias ONE_OVER_E = "oneOverE"
    """
    Width of a distribution equal to the distance between the outer two points
    on the distribution having power level 1/e that of the peak.
    """
    alias EQUIVALENT_WIDTH = "equivalentWidth"
    """
    Width of a band with full sensitivity or absorption at every wavelength
    that detects or absorbs the same amount of energy as the band described.
    """


struct CoverageContentTypeCode:
    """Transformation function to be used when scaling a physical value of a
    given element.
    """

    alias IMAGE = "image"
    alias THEMATIC_CLASSIFICATION = "thematicClassification"
    alias PHYSICAL_MEASUREMENT = "physicalMeasurement"
    alias AUXILLARY_INFORMATION = "auxillaryInformation"
    alias QUALITY_INFORMATION = "qualityInformation"
    alias REFERENCE_INFORMATION = "referenceInformation"
    alias MODEL_RESULT = "modelResult"
    alias COORDINATE = "coordinate"


struct ImagingConditionCode:
    """Code which indicates conditions which may affect the image."""

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


struct PolarisationOrientationCode:
    """Polarization of the antenna in relation to the wave form."""

    alias HORIZONTAL = "horizontal"
    """
    Polarization of the sensor oriented in the horizontal plane in relation to
    swathe direction.
    """
    alias VERTICAL = "vertical"
    """
    Polarization of the sensor oriented in the vertical plane in relation to
    swathe direction.
    """
    alias LEFT_CIRCULAR = "leftCircular"
    """
    Polarization of the sensor oriented in the left circular plane in relation
    to swathe direction.
    """
    alias RIGHT_CIRCULAR = "rightCircular"
    """
    Polarization of the sensor oriented in the right circular plane in relation
    to swathe direction.
    """
    alias THETA = "theta"
    """
    Polarization of the sensor oriented in the angle between +90° and 0°
    parallel to swathe direction.
    """
    alias PHI = "phi"
    """
    Polarization of the sensor oriented in the +90° and 0° perpendicular to
    swathe direction.
    """


struct TransferFunctionTypeCode:
    """Transform function to be used when scaling a physical value for a given
    element.
    """

    alias LINEAR = "linear"
    """Function used when transformation is first order polynomial."""
    alias LOGARITHMIC = "logarithmic"
    """Function used when transformation is logartihmic."""
    alias EXPONENTIAL = "exponential"
    """Function used when transformation is exponential."""


trait RangeElementDescription:
    """Description of specific range elements."""

    fn name(self) -> String:
        """Designation associated with a set of range elements."""
        ...

    fn definition(self) -> String:
        """Description of a set of specific range elements."""
        ...

    fn range_element(self) -> Sequence[Record]:
        """Specific range elements, i.e. range elements associated with a name
        and their definition.
        """
        ...


trait RangeDimension:
    """Information on the range of attribute values."""

    fn sequence_identifier(self) -> Optional[MemberName]:
        """Number that uniquely identifies instances of bands of wavelengths on
        which a sensor operates.
        """
        ...

    fn description(self) -> Optional[String]:
        """Description of the range of a cell measurement value."""
        ...

    fn name(self) -> Optional[Sequence[Identifier]]:
        """Identifiers for each attribute included in the resource.

        NOTE: These identifiers can be used to provide names for the
        resource's attribute from a standard set of names.
        """
        ...


trait AttributeGroup:
    """Information about the `content_type` for groups of attributes for a
    specific `RangeDimension`.
    """

    fn content_type(self) -> Sequence[CoverageContentTypeCode]:
        """Type of information represented by the value."""
        ...

    fn attribute(self) -> Optional[Sequence[RangeDimension]]:
        """Information on an attribute of the resource."""
        ...


trait SampleDimension(RangeDimension):
    """The characteristics of each dimension (layer) included in the resource.
    """

    fn max_value(self) -> Optional[Float64]:
        """Maximum value of data values in each dimension included in the
        resource.

        NOTE: Restricted to UomLength in the `Band` class.
        """
        ...

    fn min_value(self) -> Optional[Float64]:
        """Minimum value of data values in each dimension included in the
        resource.

        Restricted to `UomLength` in the `Band` class.
        """
        ...

    fn units(self) -> Optional[UnitOfMeasure]:
        """Units of data in each dimension included in the resource.

        NOTE: that the type of this is `UnitOfMeasure` and that it is
        restricted to `UomLength` in the `Band` class.

        MANDATORY if `max_value` or `min_value` is specified.
        """
        ...

    fn scale_factor(self) -> Optional[Float64]:
        """Scale factor which has been applied to the cell value."""
        ...

    fn offset(self) -> Optional[Float64]:
        """The physical value corresponding to a cell value of zero."""
        ...

    fn mean_value(self) -> Optional[Float64]:
        """Mean value of data values in each dimension included in the resource.
        """
        ...

    fn number_of_values(self) -> OptionalInt:
        """This gives the number of values used in a thematicClassification
        resource, e.g., the number of classes in a Land Cover Type coverage or
        the number of cells with data in other types of coverages.
        """
        ...

    fn standard_deviation(self) -> Optional[Float64]:
        """Standard deviation of data values in each dimension included in the
        resource.
        """
        ...

    fn other_property_type(self) -> Optional[RecordType]:
        """Type of other attribute description (i.e. netcdf/variable in ncml.xsd).
        """
        ...

    fn other_property(self) -> Optional[Record]:
        """Instance of otherAttributeType that defines attributes not explicitly
        included in `CoverageType`.
        """
        ...

    fn bits_per_value(self) -> OptionalInt:
        """Maximum number of significant bits in the uncompressed representation
        for the value in each band of each pixel.
        """
        ...

    fn transfer_function_type(self) -> Optional[TransferFunctionTypeCode]:
        """Type of transfer function to be used when scaling a physical value for
        a given element.
        """
        ...

    fn range_element_description(self) -> Sequence[RangeElementDescription]:
        """Provides the description and values of the specific range elements of
        a sample dimension.
        """
        ...

    fn nominal_spatial_resolution(self) -> Optional[Float64]:
        """Smallest distance between which separate points can be distinguished,
        as specified in instrument design.
        """
        ...


trait Band(SampleDimension):
    """Range of wavelengths in the electromagnetic spectrum."""

    fn bound_max(self) -> Optional[Float64]:
        """Bounding maximum. The longest wavelength that the sensor is capable of
        collecting within a designated band.
        """
        ...

    fn bound_min(self) -> Optional[Float64]:
        """Bounding minimum. The shortest wavelength that the sensor is capable of
        collecting within a designated band.
        """
        ...

    fn bound_unit(self) -> Optional[UomLength]:
        """Bounding units. The units in which the sensor wavelengths are
        expressed.

        MANDATORY if `bound_max` or `bound_min` is specified.
        """
        ...

    fn peak_response(self) -> Optional[Float64]:
        """Wavelength at which the response is the highest."""
        ...

    fn tone_gradation(self) -> OptionalInt:
        """Number of discrete numerical values in the data."""
        ...

    fn band_boundary_definition(self) -> Optional[BandDefinition]:
        """Designation of criterion for defining maximum and minimum wavelengths
        for a spectral band.
        """
        ...

    fn transmitted_polarisation(self) -> Optional[PolarisationOrientationCode]:
        """Polarisation of the transmitter or detector."""
        ...

    fn detected_polarisation(self) -> Optional[PolarisationOrientationCode]:
        """Polarisation of the transmitter or detector."""
        ...


trait ContentInformation:
    """Description of the content of a resource."""

    ...


trait CoverageDescription(ContentInformation):
    """Details about the content of a resource."""

    fn attribute_description(self) -> RecordType:
        """Description of the attribute described by the measurement value."""
        ...

    fn processing_level_code(self) -> Optional[Identifier]:
        """Code and codespace that identifies the level of processing that has
        been applied to the resource.
        """
        ...

    fn attribute_group(self) -> Optional[Sequence[AttributeGroup]]:
        """Information on the group(s) of related attributes of the resource
        with the same type.
        """
        ...

    fn range_element_description(
        self,
    ) -> Optional[Sequence[RangeElementDescription]]:
        """Provides the description of the specific range elements of a coverage.
        """
        ...


trait ImageDescription(CoverageDescription):
    """Information about an image's suitability for use."""

    fn illumination_elevation_angle(self) -> Optional[Float64]:
        """Illumination elevation measured in degrees clockwise from the target
        plane at intersection of the optical line of sight with the Earth's
        surface.

        NOTE: For images from a scanning device, refer to the centre pixel
        of the image.

        Domain: -90 - 90
        """
        ...

    fn illumination_azimuth_angle(self) -> Optional[Float64]:
        """Illumination azimuth measured in degrees clockwise from true north at
        the time the image is taken.

        NOTE: For images from a scanning device, refer to the centre pixel of
        the image.

        Domain: 0.00 - 360
        """
        ...

    fn imaging_condition(self) -> Optional[ImagingConditionCode]:
        """Conditions that affected the image."""
        ...

    fn image_quality_code(self) -> Optional[Identifier]:
        """Code in producer's code space that specifies the image quality."""
        ...

    fn cloud_cover_percentage(self) -> Optional[Float64]:
        """Area of the dataset obscured by clouds, expressed as a percentage of
        the spatial extent.

        Domain: 0.0 - 100.0
        """
        ...

    fn compression_generation_quantity(self) -> OptionalInt:
        """Count of the number of lossy compression cycles performed on the image.
        """
        ...

    fn triangulation_indicator(self) -> Optional[Bool]:
        """Indication of whether or not triangulation has been performed upon the
        image.
        """
        ...

    fn radiometric_calibration_data_availability(self) -> Optional[Bool]:
        """Indication of whether or not the radiometric calibration information
        for generating the radiometrically calibrated standard data product is
        available.
        """
        ...

    fn camera_calibration_information_availability(self) -> Optional[Bool]:
        """Indication of whether or not constants are available which allow for
        camera calibration corrections.
        """
        ...

    fn film_distortion_information_availability(self) -> Optional[Bool]:
        """Indication of whether or not Calibration Reseau information is
        available.
        """
        ...

    fn lens_distortion_information_availability(self) -> Optional[Bool]:
        """Indication of whether or not lens aberration correction information is
        available.
        """
        ...


trait FeatureTypeInfo:
    """Information about the occurring feature type."""

    fn feature_type_name(self) -> GenericName:
        """Name of the feature type."""
        ...

    fn feature_instance_count(self) -> OptionalInt:
        """Number of occurences of feature instances for this type.

        Domain: > 0
        """
        ...


trait FeatureCatalogueDescription(ContentInformation):
    """Information identifying the feature catalogue or the conceptual schema.
    """

    fn compliance_code(self) -> Optional[Bool]:
        """Indication of whether or not the cited feature catalogue complies with
        ISO 19110.
        """
        ...

    fn locale(self) -> Optional[Sequence[PT_Locale]]:
        """Language(s) and character set(s) used within the catalogue."""
        ...

    fn included_with_dataset(self) -> Optional[Bool]:
        """Indication of whether or not the feature catalogue is included with
        the resource.
        """
        ...

    fn feature_types(self) -> Optional[Sequence[FeatureTypeInfo]]:
        """Subset of feature types from cited feature catalogue occurring in
        dataset.
        """
        ...

    fn feature_catalogue_citation(self) -> Optional[Sequence[Citation]]:
        """Complete bibliographic reference to one or more external feature
        catalogues.

        MANADTORY: if a Feature Catalogue is not provided with the resource
            and `FeatureCatalogue` is `None`.
        """
        ...


trait FeatureCatalogue(ContentInformation):
    """A catalogue of feature types."""

    fn feature_catalogue(self) -> Optional[Sequence[FC_FeatureCatalogue]]:
        """The catalogue of feature types, attribution, operations, and
        relationships used by the resource.

        FC_FeatureCatalogue from ISO 19110
        """
        ...
