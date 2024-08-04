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

from dataclasses import dataclass

from opengis.metadata.citation import Identifier


@dataclass(frozen=True, slots=True)
class GeographicExtent:
    """Spatial area of the resource.

    Attributes:
        extent_type_code (bool): Indication of whether the geographic element
            encompasses an area covered by the data or an area where data is
            not present.

    """

    extent_type_code: bool


@dataclass(frozen=True, slots=True)
class GeographicBoundingBox(GeographicExtent):
    """Geographic position of the resource. NOTE: This is only an approximate
    reference so specifying the coordinate reference system is unnecessary and
    need only be provided with a precision of up to two decimal places.

    Attributes:
        west_bound_longitude (float): Western-most coordinate of the limit of
            the resource extent, expressed in longitude in decimal degrees
            (positive east).
        east_bound_longitude (float): Eastern-most coordinate of the limit of
            the resource extent, expressed in longitude in decimal degrees
            (positive east).
        south_bound_latitude (float): Southern-most coordinate of the limit of
            the resource extent, expressed in latitude in decimal degrees
            (positive north).
        north_bound_latitude (float): Northern-most, coordinate of the limit of
            the resource extent expressed in latitude in decimal degrees
            (positive north).

    """

    west_bound_longitude: float
    east_bound_longitude: float
    south_bound_latitude: float
    north_bound_latitude: float


@dataclass(frozen=True, slots=True)
class GeographicDescription(GeographicExtent):
    """Description of the geographic area using identifiers.

    Attributes:
        extent_type_code (bool): Indication of whether the geographic element
            encompasses an area covered by the data
        geographic_identifier: Identifier: Identifier used to represent a
            geographic area. NOTE: A geographic identifier as described in
            ISO 19112.

    """

    geographic_identifier: Identifier


@dataclass(frozen=True, slots=True)
class BoundingPolygon(GeographicExtent):
    """Enclosing geometric object which locates the resource, expressed as a
    set of (x,y) coordinate (s). NOTE: If a polygon is used it should be
    closed (last point replicates first point).

    Attributes:
        polygon (GM_Object): Sets of points defining the bounding polygon or
            any other GM_Object geometry (point, line or polygon).

    """

    polygon: GM_Object


@dataclass(frozen=True, slots=True)
class VerticalExtent:
    """Vertical domain of resource.

    Attributes:
        minimum_value (float): Lowest vertical extent contained in the
            resource.
        maximum_value (float): Highest vertical extent contained in the
            resource.
        vertical_crs (MD_ReferenceSystem): Identifies the vertical coordinate
            reference system used for the minimum and maximum values.

    """

    minimum_value: float
    maximum_value: float
    vertical_crs: MD_ReferenceSystem


@dataclass(frozen=True, slots=True)
class TemporalExtent:
    """Time period covered by the content of the resource.

    Attributes:
        extent (TM_Primitive): Period for the content of the resource.

    """

    extent: TM_Primitive


@dataclass(frozen=True, slots=True)
class SpatialTemporalExtent(TemporalExtent):
    """Extent with respect to date/time and spatial boundaries.

    Attributes:
        extent (TM_Primitive): Period for the content of the resource.
        vertical_extent (VerticalExtent): Vertical extent component.
        spatial_extent (tuple[GeographicExtent, ...]): 

    """

    vertical_extent: VerticalExtent
    spatial_extent: tuple[GeographicExtent, ...]



@dataclass(frozen=True, slots=True)
class Extent:
    """Extent of the resource.

    Attributes:
        description (str): A description of the extent of the referring object.
        geographic_element (tuple[GeographicExtent, ...]): 
        temporal_element (tuple[TemporalExtent, ...]): 
        vertical_element (tuple[VerticalExtent, ...]): 

    """

    description: str
    geographic_element: tuple[GeographicExtent, ...]
    temporal_element: tuple[TemporalExtent, ...]
    vertical_element: tuple[VerticalExtent, ...]
