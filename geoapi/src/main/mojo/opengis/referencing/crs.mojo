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

# author: OGC Topic 2 (for abstract model and documentation), David Meaux

"""This is the `crs` module.

This module contains geographic metadata structures regarding coordinate
referencing systems derived from the ISO 19111 international standard and
ISO 19115-1:2014, including adendums A1(2018) and A2(2020).
"""

from collections import Optional

from opengis.metadata.citation import Identifier
from opengis.referencing.common import IdentifiedObject
from opengis.referencing.coordinate import DataEpoch
from opengis.referencing.cs import (
    CartesianCS,
    CoordinateSystem,
    EllipsoidalCS,
    TimeCS,
    VerticalCS,
)
from opengis.referencing.datum import (
    Datum,
    EngineeringDatum,
    GeodeticDatum,
    TemporalDatum,
    VerticalDatum,
)
from opengis.referencing.operation import Conversion


struct ReferenceSystemTypeCode:
    """Defines type of reference system used.

    This struct is derived from ISO 19115-1:2014, including adendums A1(2018)
    and A2(2020).
    """

    alias COMPOUND_ENGINEERING_PARAMETRIC = "compoundEngineeringParametric"
    """Compound spatio-parametric coordinate reference system containing an
    engineering coordinate reference system and a parametric reference system.

    alias Example:
        [local] x, y, pressure
    """

    alias COMPOUND_ENGINEERING_PARAMETRIC_TEMPORAL = "compoundEngineeringParametricTemporal"
    """Compound spatio-parametric-temporal coordinate reference system containing,
    an engineering coordinate reference system, a parametric reference system,
    and a temporal coordinate reference system.

    alias Example:
        [local] x, y, pressure, time
    """

    alias COMPOUND_ENGINEERING_TEMPORAL = "compoundEngineeringTemporal"
    """Compound spatio-temporal coordinate reference system containing,
    an engineering coordinate reference system and a temporal coordinate
    reference system.

    alias Example:
        [local] x, y, time
    """

    alias COMPOUND_ENGINEERING_VERTICAL = "compoundEngineeringVertical"
    """Compound spatial coordinate reference system containing a horizontal
    engineering coordinate reference system and a vertical coordinate
    reference system.

    alias Example:
        [local] x, y, height
    """

    alias COMPOUND_ENGINEERING_VERTICAL_TEMPORAL = "compoundEngineeringVerticalTemporal"
    """Compound spatio-temporal coordinate reference system containing an
    engineering, a vertical, and a temporal coordinate reference system.

    alias Example:
        [local] x, y, height, time
    """

    alias COMPOUND_GEOGRAPHIC2D_PARAMETRIC = "compoundGeographic2DParametric"
    """Compound spatio-parametric coordinate reference system containing a 2
    dimensional geographic horizontal coordinate reference system and a
    parametric reference system.

    alias Example:
        latitude, longitude, pressure
    """

    alias COMPOUND_GEOGRAPHIC2D_PARAMETRIC_TEMPORAL = "compoundGeographic2DParametricTemporal"
    """Compound spatio-parametric-temporal coordinate reference system containing
    a 2 dimensional geographic horizontal, a parametric, and a temporal
    reference system.

    alias Example:
        latitude, longitude, pressure, time
    """

    alias COMPOUND_GEOGRAPHIC2D_TEMPORAL = "compoundGeographic2DTemporal"
    """Compound spatio-temporal coordinate reference system containing
    a 2 dimensional geographic horizontal coordinate reference system and a
    temporal reference system.

    alias Example:
        latitude, longitude, time
    """

    alias COMPOUND_GEOGRAPHIC2D_VERTICAL = "compoundGeographic2DVertical"
    """Compound coordinate reference system in which one constituent coordinate
    reference system ais a horizontal geodetic coordinate reference system and
    one is a vertical reference system.

    alias Example:
        latitude, longitude, [gravity-related] height or depth
    """

    alias COMPOUND_GEOGRAPHIC2D_VERTICAL_TEMPORAL = "compoundGeographic2DVerticalTemporal"
    """Compound spatio-temporal coordinate reference system containing a
    2 dimensional geographic horizontal, a vertical, and a temporal coordinate
    reference system.

    alias Example:
        latitude, longitude, height, time
    """

    alias COMPOUND_GEOGRAPHIC3D_TEMPORAL = "compoundGeographic3DTemporal"
    """Compound spatio-temporal coordinate reference system containing a
    3 dimensional geographic and a temporal coordinate reference system.

    alias Example:
        latitude, longitude, ellipsoidal height, time
    """

    alias COMPOUND_PROJECTED2D_PARAMETRIC = "compoundProjected2DParametric"
    """Compound spatio-parametric coordinate reference system containing a
    projected horizontal coordinate reference system and a parametric
    reference system.

    alias Example:
        easting, northing, density
    """

    alias COMPOUND_PROJECTED2D_PARAMETRIC_TEMPORAL = "compoundProjected2DParametricTemporal"
    """Compound spatio-parametric-temporal coordinate reference system containing
    a projected horizontal, a parametric, and a temporal coordinate reference
    system.

    alias Example:
        easting, northing, density, time
    """

    alias COMPOUND_PROJECTED_TEMPORAL = "compoundProjectedTemporal"
    """Compound spatial reference system containing a horizontal projected
    coordinate reference system and a vertical coordinate reference system.

    alias Example:
        easting, northing, [gravity-related] height or depth
    """

    alias COMPOUND_PROJECTED_VERTICAL = "compoundProjectedVertical"
    """Compound spatial reference system containing a horizontal projected
    coordinate reference system and a vertical coordinate reference system.

    alias Example:
        easting, northing, [gravity-related] height or depth
    """

    alias COMPOUND_PROJECTED_VERTICAL_TEMPORAL = "compoundProjectedVerticalTemporal"
    """Compound spatio-temporal coordinate reference system containing a
    projected horizontal, a vertical, and a temporal coordinate reference
    system.

    alias Example:
        easting, northing, height, time
    """

    alias ENGINEERING = "engineering"
    """Coordinate reference system based on an engineering datum (datum
    describing the relationship of a coordinate system to a local reference).

    alias Example:
        [local] x, y
    """

    alias ENGINEERING_DESIGN = "engineeringDesign"
    """Engineering coordinate reference system in which the base representation
    of a moving object is specified.

    alias Example:
        [local] x, y
    """

    alias ENGINEERING_IMAGE = "engineeringImage"
    """Coordinate reference system based on an image datum (engineering datum
    which defines the relationship of a coordinate system to an image).

    alias Example:
        row, column
    """

    alias GEODETIC_GEOCENTRIC = "geodeticGeocentric"
    """Geodetic coordinate reference system having a Cartesian 3D coordinate
    system.

    alias Example:
        [geocentric] X, Y, Z
    """

    alias GEODETIC_GEOGRAPHIC_2D = "geodeticGeographic2D"
    """Geodetic coordinate reference system having an ellipsoidal 2D coordinate
    system.

    alias Example:
        latitude, longitude
    """

    alias GEODETIC_GEOGRAPHIC_3D = "geodeticGeographic3D"
    """Geodetic coordinate reference system having an ellipsoidal 3D coordinate
    system.

    alias Example:
        latitude, longitude, ellipsoidal height
    """

    alias GEOGRAPHIC_IDENTIFIER = "geographicIdentifier"
    """Spatial reference in the form of a label or code that identifies a
    location.

    alias Example:
        post coade
    """

    alias LINEAR = "linear"
    """Reference system that identifies a location by reference to a segment of a
    linear geographic feature and distance along that segment from a given
    point.

    alias Example:
        x km along road
    """

    alias PARAMETRIC = "parametric"
    """Coordinate reference system based on a parametric datum (datum describing
    the relationship of a parametric coordinate system to an object).

    alias Example:
        pressure
    """

    alias PROJECTED = "projected"
    """Coordinate reference system derived from a two-dimensional geodetic
    coordinate reference system by applying a map projection.

    alias Example:
        easting, northing
    """

    alias TEMPORAL = "temporal"
    """Reference system against which time is measured.

    alias Example:
        time
    """

    alias VERTICAL = "vertical"
    """One-dimensional coordinate reference system based on a vertical datum
    (datum describing the relation of gravity-related heights or depths
    to the Earth).

    alias Example:
        [gravity-related] height or depth
    """


struct ReferenceSystemTypeCode:
    """ """

    alias COMPOUND_ENGINEERING_PARAMETRIC = "compoundEngineeringParametric"
    alias COMPOUND_ENGINEERING_PARAMETRIC_TEMPORAL = "compoundEngineeringParametricTemporal"
    alias COMPOUND_ENGINEERING_TEMPORAL = "compoundEngineeringTemporal"
    alias COMPOUND_ENGINEERING_VERTICAL = "compoundEngineeringVertical"
    alias COMPOUND_ENGINEERING_VERTICAL_TEMPORAL = "compoundEngineeringVerticalTemporal"
    alias COMPOUND_GEOGRAPHIC2D_PARAMETRIC = "compoundGeographic2DParametric"
    alias COMPOUND_GEOGRAPHIC2D_PARAMETRIC_TEMPORAL = "compoundGeographic2DParametricTemporal"
    alias COMPOUND_GEOGRAPHIC2D_TEMPORAL = "compoundGeographic2DTemporal"
    alias COMPOUND_GEOGRAPHIC2D_VERTICAL = "compoundGeographic2DVertical"
    alias COMPOUND_GEOGRAPHIC2D_VERTICAL_TEMPORAL = "compoundGeographic2DVerticalTemporal"
    alias COMPOUND_GEOGRAPHIC3D_TEMPORAL = "compoundGeographic3DTemporal"
    alias COMPOUND_PROJECTED2D_PARAMETRIC = "compoundProjected2DParametric"
    alias COMPOUND_PROJECTED2D_PARAMETRIC_TEMPORAL = "compoundProjected2DParametricTemporal"
    alias COMPOUND_PROJECTED_TEMPORAL = "compoundProjectedTemporal"
    alias COMPOUND_PROJECTED_VERTICAL = "compoundProjectedVertical"
    alias COMPOUND_PROJECTED_VERTICAL_TEMPORAL = "compoundProjectedVerticalTemporal"
    alias ENGINEERING = "engineering"
    alias ENGINEERING_DESIGN = "engineeringDesign"
    alias ENGINEERING_IMAGE = "engineeringImage"
    alias GEODETIC_GEOCENTRIC = "geodeticGeocentric"
    alias GEODETIC_GEOGRAPHIC_2D = "geodeticGeographic2D"
    alias GEODETIC_GEOGRAPHIC_3D = "geodeticGeographic3D"
    alias GEOGRAPHIC_IDENTIFIER = "geographicIdentifier"
    alias LINEAR = "linear"
    alias PARAMETRIC = "parametric"
    alias PROJECTED = "projected"
    alias TEMPORAL = "temporal"
    alias VERTICAL = "vertical"


trait ReferenceSystem:
    """Description of a spatial and temporal reference system used by a dataset.

    This trait is derived from MD_ReferenceSystem described in the
    ISO 19115-1:2014, including addendums A1(2018) and A2(2020),
    and ISO 19115-2:2019, including addendum A1(2022), international standards.
    """

    fn reference_system_identifier(self) -> Optional[Identifier]:
        """Identifier and codespace for reference system.

        NOTE: Refer to to SC_CRS in ISO 19111 and ISO 19111-2 when coordinate
        reference system information is not given through reference system
        identifier.

        Example:
            EPSG::4326

        MANDATORY:
            If `coordinate_reference_system` is `None`.
        """
        ...

    fn coordinate_reference_system(
        self,
    ) -> Optional["CoordinateReferenceSystem"]:
        """Full description of the coordinate reference system from which a set
        of coordinates is referenced.

        MANDATORY:
            If `reference_system_identifier` is `None`.
        """
        ...

    fn coordinate_epoch(self) -> Optional[DataEpoch]:
        """The epoch from which coordinates in a dynamic coordinate reference
        system are referenced.

        MANDATORY:
            If the coordinate reference system is dynamic.
        """
        ...

    fn reference_system_type(self) -> ReferenceSystemTypeCode:
        """Type of reference system used.

        Example:
            `COMPOUND_GEOGRAPHIC2D_PARAMETRIC`
            (compoundGeographic2DParametric)
        """
        ...


trait CoordinateReferenceSystem(ReferenceSystem):
    """Abstract coordinate reference system, usually defined by a coordinate
    system and a datum.
    """


trait SingleCRS(CoordinateReferenceSystem):
    """Abstract coordinate reference system, consisting of a single Coordinate
    System and a single Datum."""

    fn coordinate_system(self) -> CoordinateSystem:
        """Returns the coordinate system.

        :return: The coordinate system.
        :rtype: CoordinateSystem
        """
        ...

    fn datum(self) -> Datum:
        """Returns the datum.

        :return: The datum
        :rtype: Datum
        """
        ...


trait CompoundCRS(CoordinateReferenceSystem):
    """A coordinate reference system describing the position of points through
    two or more independent coordinate reference systems."""

    fn components(self) -> Tuple[SingleCRS]:
        """The ordered list of coordinate reference systems.

        :return: The ordered list of coordinate reference systems.
        :rtype: Tuple[SingleCRS]
        """
        ...


trait VerticalCRS(SingleCRS):
    """A 1D coordinate reference system used for recording heights or depths."""

    fn coordinate_system(self) -> VerticalCS:
        """Returns the coordinate system, which must be vertical.

        :return: The coordinate system.
        :rtype: VerticalCS
        """
        ...

    fn datum(self) -> VerticalDatum:
        """Returns the datum, which must be vertical.

        :return: The datum
        :rtype: VerticalDatum
        """
        ...


trait TemporalCRS(SingleCRS):
    """A 1D coordinate reference system used for the recording of time."""

    fn coordinate_system(self) -> TimeCS:
        """Returns the coordinate system, which must be temporal.

        :return: The coordinate system.
        :rtype: TimeCS
        """
        ...

    fn datum(self) -> TemporalDatum:
        """Returns the datum, which must be temporal.

        :return: The datum
        :rtype: TemporalDatum
        """
        ...


trait EngineeringCRS(SingleCRS):
    """A contextually local coordinate reference system."""

    fn datum(self) -> EngineeringDatum:
        """Returns the datum, which must be an engineering one.

        :return: The datum
        :rtype: EngineeringDatum
        """
        ...


trait DerivedCRS(SingleCRS):
    """A coordinate reference system that is defined by its coordinate conversion
    from another coordinate reference system (not by a datum)."""

    fn base_crs(self) -> CoordinateReferenceSystem:
        """Returns the base coordinate reference system.

        :return: The base coordinate reference system.
        :rtype: CoordinateReferenceSystem
        """
        ...

    fn conversion_from_base(self) -> Conversion:
        """Returns the conversion from the base CRS to this CRS.

        :return: The conversion from the base CRS.
        :rtype: Conversion
        """
        ...


trait GeodeticCRS(SingleCRS):
    """A coordinate reference system associated with a geodetic reference frame.
    """

    fn datum(self) -> GeodeticDatum:
        """Returns the datum, which must be geodetic.

        :return: The datum.
        :rtype: GeodeticDatum
        """
        ...


trait GeographicCRS(GeodeticCRS):
    """A coordinate reference system based on an ellipsoidal approximation of the
    geoid; this provides an accurate representation of the geometry of
    geographic features for a large portion of the earth's surface."""

    fn coordinate_system(self) -> EllipsoidalCS:
        """Returns the coordinate system, which must be ellipsoidal.

        :return: The coordinate system.
        :rtype: EllipsoidalCS
        """
        ...


trait ProjectedCRS(DerivedCRS):
    """A 2D coordinate reference system used to approximate the shape of the
    Earth on a planar surface."""

    fn conversion_from_base(self) -> Conversion:
        """Returns the map projection from the base CRS to this CRS.

        :return: The conversion from the base CRS.
        :rtype: Conversion
        """
        ...

    fn base_crs(self) -> GeographicCRS:
        """Returns the base coordinate reference system, which must be geographic.

        :return: The base coordinate reference system.
        :rtype: GeographicCRS
        """
        ...

    fn coordinate_system(self) -> CartesianCS:
        """Returns the coordinate system, which must be cartesian.

        :return: The coordinate system.
        :rtype: CartesianCS
        """
        ...

    fn datum(self) -> GeodeticDatum:
        """Returns the datum.

        :return: The datum.
        :rtype: GeodeticDatum
        """
        ...
