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
"""This is the extent module.

This module contains geographic metadata structures regarding data extent
derived from the ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from abc import ABC, abstractmethod
from collections.abc import Sequence

from opengis.metadata.citation import Identifier


class GeographicExtent(ABC):
    """Spatial area of the resource."""

    @property
    def extent_type_code(self):
        """
        Indication of whether the geographic element encompasses an area
        covered by the data or an area where data is not present.
        """
        return None


class GeographicBoundingBox(GeographicExtent):
    """
    Geographic position of the resource. NOTE: This is only an approximate
    reference so specifying the coordinate reference system is unnecessary and
    need only be provided with a precision of up to two decimal places.
    """

    @property
    @abstractmethod
    def west_bound_longitude(self) -> float:
        """
        Western-most coordinate of the limit of the resource extent, expressed
        in longitude in decimal degrees (positive east).
        """
        pass

    @property
    @abstractmethod
    def east_bound_longitude(self) -> float:
        """
        Eastern-most coordinate of the limit of the resource extent, expressed
        in longitude in decimal degrees (positive east).
        """
        pass

    @property
    @abstractmethod
    def south_bound_latitude(self) -> float:
        """
        Southern-most coordinate of the limit of the resource extent,
        expressed in latitude in decimal degrees (positive north).
        """
        pass

    @property
    @abstractmethod
    def north_bound_latitude(self) -> float:
        """
        Northern-most, coordinate of the limit of the resource extent
        expressed in latitude in decimal degrees (positive north).
        """
        pass


class GeographicDescription(GeographicExtent):
    """Description of the geographic area using identifiers."""

    @property
    @abstractmethod
    def geographic_identifier(self) -> Identifier:
        """
        Identifier used to represent a geographic area, e.g., a geographic
        identifier as described in ISO 19112.
        """
        pass


class BoundingPolygon(GeographicExtent):
    """
    Enclosing geometric object which locates the resource, expressed as a set
    of (x,y) coordinate (s). NOTE: If a polygon is used it should be closed
    (last point replicates first point).
    """

    @property
    @abstractmethod
    def polygon(self):
        """
        Sets of points defining the bounding polygon or any other GM_Object
        geometry (point, line or polygon).
        """
        pass


class VerticalExtent(ABC):
    """Vertical domain of resource."""

    @property
    @abstractmethod
    def minimum_value(self) -> float:
        """Lowest vertical extent contained in the resource."""
        pass

    @property
    @abstractmethod
    def maximum_value(self) -> float:
        """Highest vertical extent contained in the resource."""
        pass

    @property
    def vertical_CRS(self):
        """
        Identifies the vertical coordinate reference system used for the
        minimum and maximum values.
        """
        return None


class TemporalExtent(ABC):
    """Time period covered by the content of the resource."""

    @property
    @abstractmethod
    def extent(self):
        """Period for the content of the resource."""
        pass


class SpatialTemporalExtent(TemporalExtent):
    """Extent with respect to date/time and spatial boundaries."""

    @property
    def vertical_extent(self) -> VerticalExtent:
        """Vertical extent component."""
        return None

    @property
    @abstractmethod
    def spatial_extent(self) -> Sequence[GeographicExtent]:
        pass


class Extent(ABC):
    """Extent of the resource."""

    @property
    def description(self) -> str:
        """
        Sets of points defining the bounding polygon or any other GM_Object
        geometry (point, line or polygon).
        """
        return None

    @property
    def geographic_element(self) -> Sequence[GeographicExtent]:
        """"""
        return None

    @property
    def temporal_element(self) -> Sequence[TemporalExtent]:
        """"""
        return None

    @property
    def vertical_element(self) -> Sequence[VerticalExtent]:
        """"""
        return None
