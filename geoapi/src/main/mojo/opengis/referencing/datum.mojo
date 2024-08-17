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
"""This is the datum module.

This module contains geographic metadata structures regarding datums derived
from the ISO 19111 international standard.
"""

from opengis.metadata.citation import Identifier
from opengis.metadata.extent import Extent

struct RealizationMethod():
    """
    Specification of the method by which the vertical reference frame is realized.
    """

    alias LEVELLING = "levelling"
    alias GEOID = "geoid"
    alias TIDAL = "tidal"


trait IdentifiedObject():
    """
    Identification and remarks information for a reference system or CRS-related
    object.
    """

    fn name(self) -> Identifier:
        """
        The primary name by which this object is identified.
        """
        ...

    fn remarks(self) -> String:
        """
        Comments on or information about this object, including data source information.
        """
        ...

    fn to_wkt(self) -> String:
        """
        Returns a Well-Known Text (WKT) for this object.
        """
        ...


trait Datum(IdentifiedObject):
    """
    Specifies the relationship of a coordinate system to the earth, thus creating a coordinate reference system.
    """

    fn anchor_point(self) -> String:
        """
        Description, possibly including coordinates, of the point or points used to anchor the datum to the Earth.
        """
        ...

    fn domain_of_validity(self) -> Extent:
        """
        Information about spatial, vertical, and temporal extent. This interface has four optional attributes
        (geographic elements, temporal elements, and vertical elements) and an element called description. At least one
        of the four shall be used.
        """
        ...

    fn realization_epoch(self) -> datetime:
        """
        The time after which this datum definition is valid.
        """
        ...

    fn scope(self) -> String:
        """
        Description of domain of usage, or limitations of usage, for which this datum object is valid.
        """
        ...


trait TemporalDatum(Datum):
    """
    A temporal datum defines the origin of a temporal coordinate reference system.
    """

    fn anchor_point(self) -> None:
        """
        This attribute is defined in the Datum parent interface, but is not used by a temporal datum.
        """
        ...

    fn realization_epoch(self) -> None:
        """
        This attribute is defined in the Datum parent interface, but is not used by a temporal datum.
        """
        ...

    fn origin(self) -> datetime:
        """
        The date and time origin of this temporal datum.
        """
        ...


trait VerticalDatum(Datum):
    """
    The method through which this vertical reference frame is realized.
    """

    fn realization_method(self) -> RealizationMethod:
        """
        The type of this vertical datum.
        """
        ...


trait Ellipsoid(IdentifiedObject):
    """
    Geometric figure that can be used to describe the approximate shape of the earth.
    """

    fn axis_unit(self):
        """
        Linear unit of the semi-major and semi-minor axis values.
        """
        ...

    fn semi_major_axis(self) -> Float64:
        """
        Length of the semi-major axis of the ellipsoid. This is the equatorial radius in axis linear unit.
        """
        ...

    fn semi_minor_axis(self) -> Float64:
        """
        Length of the semi-minor axis of the ellipsoid. This is the polar radius in axis linear unit.
        """
        ...

    fn inverse_flattering(self) -> Float64:
        """
        Value of the inverse of the flattening constant.
        """
        ...

    fn is_inf_definitive(self) -> Bool:
        """
        Indicates if the inverse flattening is definitive for this ellipsoid. Some ellipsoids use the IVF as the
        defining value, and calculate the polar radius whenever asked. Other ellipsoids use the polar radius to
        calculate the IVF whenever asked. This distinction can be important to avoid floating-point rounding errors.
        """
        ...

    fn is_sphere(self) -> Bool:
        """
        true if the ellipsoid is degenerate and is actually a sphere.
        The sphere is completely defined by the semi-major axis, which is the radius of the sphere.
        """
        ...


trait PrimeMeridian(IdentifiedObject):
    """
    A prime meridian defines the origin from which longitude values are determined.
    """

    fn greenwich_longitude(self) -> Float64:
        """
        Longitude of the prime meridian measured from the Greenwich meridian, positive eastward.
        """
        ...

    fn angular_unit(self):
        """
        Returns the angular unit of the Greenwich longitude.
        """
        ...


trait GeodeticDatum(Datum):
    """
    Defines the location and precise orientation in 3-dimensional space of a defined ellipsoid (or sphere) that
    approximates the shape of the earth.
    """

    fn ellipsoid(self) -> Ellipsoid:
        """
        Returns the ellipsoid.
        """
        ...

    fn prime_meridian(self) -> PrimeMeridian:
        """
        Returns the prime meridian.
        """
        ...


trait EngineeringDatum(Datum):
    """
    Defines the origin of an engineering coordinate reference system.
    """
    ...
