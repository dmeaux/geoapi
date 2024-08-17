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

"""This is the crs module.

This module contains geographic metadata structures regarding coordinate
referencing systems derived from the ISO 19111 international standard.
"""

from opengis.referencing.cs \
    import CoordinateSystem, VerticalCS, TimeCS, AffineCS, CartesianCS, EllipsoidalCS
from opengis.referencing.datum \
    import IdentifiedObject, Datum, VerticalDatum, TemporalDatum, EngineeringDatum, GeodeticDatum
from opengis.metadata.extent import Extent


trait ReferenceSystem(IdentifiedObject):
    """
    Description of a spatial and temporal reference system used by a dataset.
    """

    fn domain_of_validity(self) -> Extent:
        """
        Area or region or timeframe in which this (coordinate) reference system is valid.
        """
        ...

    fn scope(self) -> String:
        """
        Description of domain of usage, or limitations of usage, for which this Reference System object is valid.
        """
        ...


trait CoordinateReferenceSystem(ReferenceSystem):
    """
    Abstract coordinate reference system, usually defined by a coordinate system and a datum.
    """
    ...


trait SingleCRS(CoordinateReferenceSystem):
    """
    Abstract coordinate reference system, consisting of a single Coordinate System and a single Datum.
    """

    fn coordinate_system(self) -> CoordinateSystem:
        """
        Returns the coordinate system.
        """
        ...

    fn datum(self) -> Datum:
        """
        Returns the datum.
        """
        ...


trait CompoundCRS(CoordinateReferenceSystem):
    """
    A coordinate reference system describing the position of points through two or more independent coordinate
    reference systems.
    """

    fn components(self) -> Sequence[SingleCRS]:
        """
        The ordered list of coordinate reference systems.
        """
        ...


trait VerticalCRS(SingleCRS):
    """
    A 1D coordinate reference system used for recording heights or depths.
    """

    fn coordinate_system(self) -> VerticalCS:
        """
        Returns the coordinate system, which must be vertical.
        """
        ...

    fn datum(self) -> VerticalDatum:
        """
        Returns the datum, which must be vertical.
        """
        ...


trait TemporalCRS(SingleCRS):
    """
    A 1D coordinate reference system used for the recording of time.
    """

    fn coordinate_system(self) -> TimeCS:
        """
        Returns the coordinate system, which must be temporal.
        """
        ...

    fn datum(self) -> TemporalDatum:
        """
        Returns the datum, which must be temporal.
        """
        ...


trait EngineeringCRS(SingleCRS):
    """
    A contextually local coordinate reference system.
    """

    fn datum(self) -> EngineeringDatum:
        """
        Returns the datum, which must be an engineering one.
        """
        ...


trait DerivedCRS(SingleCRS):
    """
    A coordinate reference system that is defined by its coordinate conversion from another coordinate reference system
    (not by a datum).
    """

    fn base_crs(self) -> CoordinateReferenceSystem:
        """
        Returns the base coordinate reference system.
        """
        ...

    fn conversion_from_base(self):
        """
        Returns the conversion from the base CRS to this CRS.
        """
        ...


trait GeodeticCRS(SingleCRS):
    """
    A coordinate reference system associated with a geodetic reference frame.
    """

    fn datum(self) -> GeodeticDatum:
        """
        Returns the datum, which must be geodetic.
        """
        ...


trait GeographicCRS(GeodeticCRS):
    """
    A coordinate reference system based on an ellipsoidal approximation of the geoid; this provides an accurate
    representation of the geometry of geographic features for a large portion of the earth's surface.
    """

    fn coordinate_system(self) -> EllipsoidalCS:
        """
        Returns the coordinate system, which must be ellipsoidal.
        """
        ...


trait ProjectedCRS(DerivedCRS):
    """
    A 2D coordinate reference system used to approximate the shape of the earth on a planar surface.
    """

    fn conversion_from_base(self):
        """
        Returns the map projection from the base CRS to this CRS.
        """
        ...

    fn base_crs(self) -> GeographicCRS:
        """
        Returns the base coordinate reference system, which must be geographic.
        """
        ...

    fn coordinate_system(self) -> CartesianCS:
        """
        Returns the coordinate system, which must be cartesian.
        """
        ...

    fn datum(self) -> GeodeticDatum:
        """
        Returns the datum.
        """
        ...
