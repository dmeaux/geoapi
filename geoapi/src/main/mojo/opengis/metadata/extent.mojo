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

"""This is the extent module.

This module contains geographic metadata structures regarding data extent
derived from the ISO 19115-1:2014 international standard.
"""

from opengis.metadata.citation import Identifier


trait GeographicExtent:
    """Spatial area of the resource."""

    fn extent_type_code(self):
        """Indication of whether the geographic element encom...es an area covered by the data or an area where data is not present.
        """
        ...


trait GeographicBoundingBox(GeographicExtent):
    """Geographic position of the resource. NOTE: This is only an approximate reference so specifying the coordinate reference system is unnecessary and need only be provided with a precision of up to two decimal places.
    """

    fn west_bound_longitude(self) -> Float64:
        """Western-most coordinate of the limit of the resource extent, expressed in longitude in decimal degrees (positive east).
        """
        ...

    fn east_bound_longitude(self) -> Float64:
        """Eastern-most coordinate of the limit of the resource extent, expressed in longitude in decimal degrees (positive east).
        """
        ...

    fn south_bound_latitude(self) -> Float64:
        """Southern-most coordinate of the limit of the resource extent, expressed in latitude in decimal degrees (positive north).
        """
        ...

    fn north_bound_latitude(self) -> Float64:
        """Northern-most, coordinate of the limit of the resource extent expressed in latitude in decimal degrees (positive north).
        """
        ...


trait GeographicDescription(GeographicExtent):
    """Description of the geographic area using identifiers."""

    fn geographic_identifier(self) -> Identifier:
        """Identifier used to represent a geographic area e.g. a geographic identifier as described in ISO 19112.
        """
        ...


trait BoundingPolygon(GeographicExtent):
    """Enclosing geometric object which locates the resource, expressed as a set of (x,y) coordinate (s). NOTE: If a polygon is used it should be closed (last point replicates first point).
    """

    fn polygon(self):
        """Sets of points defining the bounding polygon or any other GM_Object geometry (point, line or polygon).
        """
        ...


trait VerticalExtent:
    """Vertical domain of resource."""

    fn minimum_value(self) -> Float64:
        """Lowest vertical extent contained in the resource."""
        ...

    fn maximum_value(self) -> Float64:
        """Highest vertical extent contained in the resource."""
        ...

    fn vertical_CRS(self):
        ...


trait TemporalExtent:
    """Time period covered by the content of the resource."""

    fn extent(self):
        """Period for the content of the resource."""
        ...


trait SpatialTemporalExtent(TemporalExtent):
    """Extent with respect to date/time and spatial boundaries."""

    fn vertical_extent(self) -> VerticalExtent:
        """Vertical extent component."""
        ...

    fn spatial_extent(self) -> Sequence[GeographicExtent]:
        ...


trait Extent:
    """Extent of the resource."""

    fn description(self) -> String:
        """Sets of points defining the bounding polygon or any other GM_Object geometry (point, line or polygon).
        """
        ...

    fn geographic_element(self) -> Sequence[GeographicExtent]:
        ...

    fn temporal_element(self) -> Sequence[TemporalExtent]:
        ...

    fn vertical_element(self) -> Sequence[VerticalExtent]:
        ...
