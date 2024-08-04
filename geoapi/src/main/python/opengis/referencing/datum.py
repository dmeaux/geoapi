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
"""This is the datum module.

This module contains geographic metadata structures regarding datums derived
from the ISO 19111 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass
from datetime import datetime
from enum import Enum

from opengis.metadata.citation import Identifier
from opengis.metadata.extent import Extent


class RealizationMethod(Enum):
    """
    Specification of the method by which the vertical reference frame is
    realized.
    """

    LEVELLING = "levelling"
    GEOID = "geoid"
    TIDAL = "tidal"


@dataclass(frozen=True, slots=True)
class IdentifiedObject:
    """Identification and remarks information for a reference system or CRS-
    related object.

    Attributes:
        name (Identifier): The primary name by which this object is identified.
        remarks (str): Comments on or information about this object, including
            data source information.
        to_wkt (str): Returns a Well-Known Text (WKT) for this object.

    """

    name: Identifier
    remarks: str
    to_wkt: str


@dataclass(frozen=True, slots=True)
class Datum(IdentifiedObject):
    """Specifies the relationship of a coordinate system to the earth, thus
    creating a coordinate reference system.

    Attributes:
        anchor_definition (str): Description, possibly including coordinates,
            of the point or points used to anchor the datum to the Earth.
        domain_of_validity (Extent): Information about spatial, vertical, and
            temporal extent. This interface has four optional attributes
            (geographic elements, temporal elements, and vertical elements)
            and an element called description. At least one of the four shall
            be used.
        realization_epoch (datetime): The time after which this datum
            definition is valid.
        scope (str): Description of domain of usage, or limitations of usage,
            for which this datum object is valid.

    """

    anchor_definition: str | None = None
    domain_of_validity: Extent
    realization_epoch: datetime
    scope: str


@dataclass(frozen=True, slots=True)
class TemporalDatum(Datum):
    """A temporal datum defines the origin of a temporal coordinate reference
    system.

    Attributes:
        domain_of_validity (Extent): Information about spatial, vertical, and
            temporal extent. This interface has four optional attributes
            (geographic elements, temporal elements, and vertical elements)
            and an element called description. At least one of the four shall
            be used.
        scope (str): Description of domain of usage, or limitations of usage,
            for which this datum object is valid.
        origin (datetime): The date and time origin of the temporal datum.

    """

    domain_of_validity: Extent
    scope: str
    origin: datetime


@dataclass(frozen=True, slots=True)
class VerticalDatum:
    """The method through which this vertical reference frame is realized.

    Attributes:
        anchor_point (str): Description, possibly including coordinates, of
            the point or points used to anchor the datum to the Earth.
        domain_of_validity (Extent): Information about spatial, vertical, and
            temporal extent. This interface has four optional attributes
            (geographic elements, temporal elements, and vertical elements)
            and an element called description. At least one of the four shall
            be used.
        realization_epoch (datetime): The time after which this datum
            definition is valid.
        scope (str): Description of domain of usage, or limitations of usage,
            for which this datum object is valid.
        realization_method (RealizationMethod): The type of this vertical
            datum.

    """

    anchor_point: str
    domain_of_validity: Extent
    realization_epoch: datetime
    scope: str
    realization_method: RealizationMethod


@dataclass(frozen=True, slots=True)
class Ellipsoid:
    """Geometric figure that can be used to describe the approximate shape of
    the earth.

    Attributes:
        name (Identifier): The primary name by which this object is identified.
        remarks (str): Comments on or information about this object, including
            data source information.
        to_wkt (str): Returns a Well-Known Text (WKT) for this object.
        axis_unit (...): Linear unit of the semi-major and semi-minor axis
            values.
        semi_major_axis (float): Length of the semi-major axis of the
            ellipsoid. This is the equatorial radius in axis linear unit.
        semi_minor_axis (float): Length of the semi-minor axis of the
            ellipsoid. This is the polar radius in axis linear unit.
        inverse_flattering (float): Value of the inverse of the flattening
            constant.
        is_inf_definitive (bool): Indicates if the inverse flattening is
            definitive for this ellipsoid. Some ellipsoids use the IVF as the
            defining value, and calculate the polar radius whenever asked.
            Other ellipsoids use the polar radius to calculate the IVF
            whenever asked. This distinction can be important to avoid
            floating-point rounding errors.
        is_sphere (bool): True if the ellipsoid is degenerate and is actually
            a sphere. The sphere is completely defined by the semi-major axis,
            which is the radius of the sphere.

    """

    name: Identifier
    remarks: str
    to_wkt: str
    axis_unit: ...
    semi_major_axis: float
    semi_minor_axis: float
    inverse_flattering: float
    is_inf_definitive: bool
    is_sphere: bool


@dataclass(frozen=True, slots=True)
class PrimeMeridian:
    """A prime meridian defines the origin from which longitude values are
    determined.

    Attributes:
        name (Identifier): The primary name by which this object is identified.
        remarks (str): Comments on or information about this object, including
            data source information.
        to_wkt (str): Returns a Well-Known Text (WKT) for this object.
        angular_unit (...): Returns the angular unit of the Greenwich
            longitude.

    """

    name: Identifier
    remarks: str
    to_wkt: str
    angular_unit: ...


@dataclass(frozen=True, slots=True)
class GeodeticDatum:
    """Defines the location and precise orientation in 3-dimensional space of
    a defined ellipsoid (or sphere) that approximates the shape of the earth.

    Attributes:
        name (Identifier): The primary name by which this object is identified.
        remarks (str): Comments on or information about this object, including
            data source information.
        to_wkt (str): Returns a Well-Known Text (WKT) for this object.
        anchor_point (str): Description, possibly including coordinates, of
            the point or points used to anchor the datum to the Earth.
        domain_of_validity (Extent): Information about spatial, vertical, and
            temporal extent. This interface has four optional attributes
            (geographic elements, temporal elements, and vertical elements)
            and an element called description. At least one of the four shall
            be used.
        realization_epoch (datetime): The time after which this datum
            definition is valid.
        scope (str): Description of domain of usage, or limitations of usage,
            for which this datum object is valid.
        ellipsoid (Ellipsoid): Returns the ellipsoid.
        prime_meridian (PrimeMeridian): Returns the prime meridian.

    """

    name: Identifier
    remarks: str
    to_wkt: str
    anchor_point: str
    domain_of_validity: Extent
    realization_epoch: datetime
    scope: str
    ellipsoid: Ellipsoid
    prime_meridian: PrimeMeridian


@dataclass(frozen=True, slots=True)
class EngineeringDatum:
    """Defines the origin of an engineering coordinate reference system.

    Attributes:
        name (Identifier): The primary name by which this object is identified.
        remarks (str): Comments on or information about this object, including
            data source information.
        to_wkt (str): Returns a Well-Known Text (WKT) for this object.
        anchor_point (str): Description, possibly including coordinates, of
            the point or points used to anchor the datum to the Earth.
        domain_of_validity (Extent): Information about spatial, vertical, and
            temporal extent. This interface has four optional attributes
            (geographic elements, temporal elements, and vertical elements)
            and an element called description. At least one of the four shall
            be used.
        realization_epoch (datetime): The time after which this datum
            definition is valid.
        scope (str): Description of domain of usage, or limitations of usage,
            for which this datum object is valid.

    """

    name: Identifier
    remarks: str
    to_wkt: str
    anchor_point: str
    domain_of_validity: Extent
    realization_epoch: datetime
    scope: str
