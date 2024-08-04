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
"""This is the referencing.crs module.

This module contains geographic metadata structures regarding coordinate
referencing systems derived from the ISO 19111 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass

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
    IdentifiedObject,
    TemporalDatum,
    VerticalDatum,
)
from opengis.metadata.extent import Extent


@dataclass(frozen=True, slots=True)
class ReferenceSystem(IdentifiedObject):
    """Description of a spatial and temporal reference system used by a
    dataset.

    Attributes:
        domain_of_validity (Extent): Area or region or timeframe in which this
            (coordinate) reference system is valid.
        scope (str): Description of domain of usage, or limitations of usage,
            for which this Reference System object is valid.

    """

    domain_of_validity: Extent
    scope: str


@dataclass(frozen=True, slots=True)
class CoordinateReferenceSystem(ReferenceSystem):
    """
    Abstract coordinate reference system, usually defined by a coordinate
    system and a datum.
    """


@dataclass(frozen=True, slots=True)
class SingleCRS(CoordinateReferenceSystem):
    """Abstract coordinate reference system, consisting of a single Coordinate
    System and a single Datum.

    Attributes:
        coordinate_system (CoordinateSystem): Returns the coordinate system.
        datum (Datum): Returns the datum.

    """

    coordinate_system: CoordinateSystem
    datum: Datum


@dataclass(frozen=True, slots=True)
class CompoundCRS(CoordinateReferenceSystem):
    """A coordinate reference system describing the position of points through
    two or more independent coordinate reference systems.

    Attributes:
        components (tuple[SingleCRS, ...]): The ordered list of coordinate
            reference systems.

    """

    components: tuple[SingleCRS, ...]


@dataclass(frozen=True, slots=True)
class VerticalCRS(CoordinateReferenceSystem):
    """A 1D coordinate reference system used for recording heights or depths.

    Attributes:
        coordinate_system (VerticalCS): Returns the coordinate system, which
            must be vertical.
        datum (VerticalDatum): Returns the datum, which must be vertical.

    """

    coordinate_system: VerticalCS
    datum: VerticalDatum


@dataclass(frozen=True, slots=True)
class TemporalCRS(CoordinateReferenceSystem):
    """A 1D coordinate reference system used for the recording of time.

    Attributes:
        coordinate_system (TimeCS): Returns the coordinate system, which must
            be temporal.
        datum (TemporalDatum): Returns the datum, which must be temporal.
    """

    coordinate_system: TimeCS
    datum: TemporalDatum


@dataclass(frozen=True, slots=True)
class EngineeringCRS(CoordinateReferenceSystem):
    """A contextually local coordinate reference system.

    Attributes:
        coordinate_system (CoordinateSystem): Returns the coordinate system.
        datum (EngineeringDatum): Returns the datum, which must be an
            engineering one.
    """

    coordinate_system: CoordinateSystem
    datum: EngineeringDatum


@dataclass(frozen=True, slots=True)
class DerivedCRS(SingleCRS):
    """A coordinate reference system that is defined by its coordinate
    conversion from another coordinate reference system (not by a datum).

    Attributes:
        base_crs (CoordinateReferenceSystem): Returns the base coordinate
            reference system.
        conversion_from_base (...): Returns the conversion from the base CRS
            to this CRS.

    """

    base_crs: CoordinateReferenceSystem
    conversion_from_base: ...


@dataclass(frozen=True, slots=True)
class GeodeticCRS(CoordinateReferenceSystem):
    """A coordinate reference system associated with a geodetic reference
    frame.

    Attributes:
        coordinate_system (CoordinateSystem): Returns the coordinate system.
        datum (GeodeticDatum): Returns the datum, which must be geodetic.
    """

    coordinate_system: CoordinateSystem
    datum: GeodeticDatum


@dataclass(frozen=True, slots=True)
class GeographicCRS(GeodeticCRS):
    """A coordinate reference system based on an ellipsoidal approximation of
    the geoid; this provides an accurate representation of the geometry of
    geographic features for a large portion of the earth's surface.

    Attributes:
        coordinate_system (EllipsoidalCS): Returns the coordinate system,
            which must be ellipsoidal.
    """

    coordinate_system: EllipsoidalCS


@dataclass(frozen=True, slots=True)
class ProjectedCRS(DerivedCRS):
    """A 2D coordinate reference system used to approximate the shape of the
        earth on a planar surface.

    Attributes:
        conversion_from_base (...): Returns the map projection from the base
            CRS to this CRS.
        base_crs (GeographicCRS): Returns the base coordinate reference system,
            which must be geographic.
        coordinate_system (CartesianCS): Returns the coordinate system, which
            must be cartesian.
        datum (GeodeticDatum): Returns the datum.

    """

    conversion_from_base: ...
    base_crs: GeographicCRS
    coordinate_system: CartesianCS
    datum: GeodeticDatum
