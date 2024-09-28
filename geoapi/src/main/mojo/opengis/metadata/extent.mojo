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

# author: OGC Topic 11 (for abstract model and documentation), David Meaux

"""This is the `extent` module.

This module contains geographic metadata structures regarding data extent
derived from the ISO 19115-1:2014 international standard.
"""

from collections import Optional

from opengis.metadata.citation import Identifier


trait VerticalExtent:
    """Vertical domain of resource."""

    fn minimum_value(self) -> Float64:
        """Lowest vertical extent contained in the resource."""
        ...

    fn maximum_value(self) -> Float64:
        """Highest vertical extent contained in the resource."""
        ...

    fn vertical_crs(self) -> Optional["VerticalCRS"]:
        """Provides information about the vertical coordinate reference system
        to which the maximum and minimum elevation values are measured.

        Identifies the vertical coordinate reference system used for the
        minimum and maximum values.

        NOTE: The CRS information includes unit of measure.

        MANDATORY:
            If vertical_crs_id is `None`.
        """

    fn vertical_crs_id(self) -> Optional["ReferenceSystem"]:
        """Identifies the vertical coordinate reference system used for the
        minimum and maximum values.

        MANDATORY:
            If vertical_crs is `None`.
        """
        ...


trait GeographicExtent:
    """Spatial area of the resource."""

    fn extent_type_code(self) -> Bool:
        """Indication of whether the geographic element encompasses an area
        covered by the data or an area where data is not present.

        Default: `True`

        Domain:
            `False` = 0 = exclusion
            `True`  = 1 = inclusion
        """
        ...


trait BoundingPolygon(GeographicExtent):
    """Encosing geometric onject which locates the resource, expressed as a set
    of (x,y) coordinate(s).

    NOTE 1: If a polygon is used it should be closed (i.e. the last point
    replicates the first point).

    NOTE 2: This type can be used to represent geometries other than polygons,
    e.g., points, lines."""

    fn polygon(self) -> Tuple[Geometry]:
        """Sets of points defining the bounding polygon or any other `Geometry`
        object (point, line, or polygon).
        """
        ...


trait GeographicBoundingBox(GeographicExtent):
    """Geographic position of the resource.

    NOTE: This is only an approximate reference so specifying the coordinate
    reference system is unnecessary and need only be provided with a precision
    of up to two decimal places."""

    fn west_bound_longitude(self) -> Float64:
        """Western-most coordinate of the limit of the resource extent, expressed
        in longitude in decimal degrees (positive east).

        Domain:
            -180.0 <= West Bounding Logitude Value <= 180.0
        """
        ...

    fn east_bound_longitude(self) -> Float64:
        """Eastern-most coordinate of the limit of the resource extent, expressed
        in longitude in decimal degrees (positive east).

        Domain:
            -180.0 <= East Bounding Logitude Value <= 180.0
        """
        ...

    fn south_bound_latitude(self) -> Float64:
        """Southern-most coordinate of the limit of the resource extent,
        expressed in latitude in decimal degrees (positive north).

        Domain:
            -90.0 <= South Bounding Latitude Value <= 90.0;
            South Bouding Latitude Value <= North Bounding Latitude Value
        """
        ...

    fn north_bound_latitude(self) -> Float64:
        """Northern-most, coordinate of the limit of the resource extent
        expressed in latitude in decimal degrees (positive north).

        Domain:
            -90.0 <= North Bounding Latitude Value <= 90.0;
            North Bouding Latitude Value >= South Bounding Latitude Value
        """
        ...


trait GeographicDescription(GeographicExtent):
    """Description of the geographic area using identifiers."""

    fn geographic_identifier(self) -> "Identifier":
        """Identifier used to represent a geographic area.

        NOTE:
            A geographic identifier as described in ISO 19112.
        """
        ...


trait TemporalExtent:
    """Time period covered by the content of the resource."""

    fn extent(self) -> tuple[datetime, datetime]:
        """Period for the content of the resource.

        Returns a tuple with the first component being the beginning `datetime`
        of the temporal period and the second component being the end
        `datetime`.
        """
        ...


trait SpatialTemporalExtent(TemporalExtent):
    """Extent with respect to date/time and spatial boundaries."""

    fn vertical_extent(self) -> VerticalExtent:
        """Vertical extent component."""
        ...

    fn spatial_extent(self) -> Tuple[GeographicExtent]:
        """Spatial extent component of a composite spatial and temporal extent.
        """
        ...


trait Extent:
    """Extent of the resource."""

    fn description(self) -> Optional[String]:
        """Extent of the referring object.

        Sets of points defining the bounding polygon or any other
        geometry (point, line or polygon).

        MANDATORY:
            If `geographic_element`, `temproal_element`,
            and `vertical_element` are `None`.
        """
        ...

    fn geographic_element(self) -> Optional[Tuple[GeographicExtent]]:
        """Provides spatial component of the extent of the referring object.

        MANDATORY:
            If `description`, `temproal_element`,
            and `vertical_element` are `None`.
        """
        ...

    fn temporal_element(self) -> Optional[Tuple[TemporalExtent]]:
        """Provides temporal component of the extent of the referring object.

        MANDATORY:
            If `description`, `geographic_element`,
            and `vertical_element` are `None`.
        """
        ...

    fn vertical_element(self) -> Optional[Tuple[VerticalExtent]]:
        """Provides vertical component of the extent of the referring object.

        MANDATORY:
            If `description`, `geographic_element`,
            and `temporal_element` are `None`.
        """
        ...
