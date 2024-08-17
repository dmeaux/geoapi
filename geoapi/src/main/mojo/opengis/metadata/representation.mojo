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

"""This is the representation module.

This module contains geographic metadata structures regarding representation
derived from the ISO 19115-1:2014 international standard.
"""

from opengis.metadata.citation import Citation
from opengis.metadata.maintenance import Scope
from opengis.metadata.naming import Record
from opengis.metadata.quality import DataQuality, Element
from opengis.referencing.crs import ReferenceSystem


trait CellGeometryCode():
    """Code indicating the geometry represented by the grid cell value."""

    alias POINT = "point"
    alias AREA = "area"
    alias VOXEL = "voxel"
    alias STRATUM = "stratum"


trait DimensionNameTypeCode():
    """Name of the dimension."""

    alias ROW = "row"
    alias COLUMN = "column"
    alias VERTICAL = "vertical"
    alias TRACK = "track"
    alias CROSS_TRACK = "crossTrack"
    alias LINE = "line"
    alias SAMPLE = "sample"
    alias TIME = "time"


trait GeometricObjectTypeCode():
    """
    Name of point or vector objects used to locate sero-, one-, two-, or
    three-dimensional spatial locations in the dataset.
    """

    alias COMPLEX = "complex"
    alias COMPOSITE = "composite"
    alias CURVE = "curve"
    alias POINT = "point"
    alias SOLID = "solid"
    alias SURFACE = "surface"


trait PixelOrientationCode():
    """Point in a pixel corresponding to the Earth location of the pixel"""

    alias CENTRE = "centre"
    alias LOWER_LEFT = "lowerLeft"
    alias LOWER_RIGHT = "lowerRight"
    alias UPPER_RIGHT = "upperRight"
    alias UPPER_LEFT = "upperLeft"


trait SpatialRepresentationTypeCode():
    """Method used to represent geographic information in the resource."""

    alias VECTOR = "vector"
    alias GRID = "grid"
    alias TEXT_TABLE = "textTable"
    alias TIN = "tin"
    alias STEREO_MODEL = "stereoModel"
    alias VIDEO = "video"


trait TopologyLevelCode():
    """Degree of the complexity of the spatial relationships."""

    alias GEOMETRY_ONLY = "geometryOnly"
    alias TOPOLOGY_1D = "topology1D"
    alias PLANAR_GRAPH = "planarGraph"
    alias FULL_PLANAR_GRAPH = "fullPlanarGraph"
    alias SURFACE_GRAPH = "surfaceGraph"
    alias FULL_SURFACE_GRAPH = "fullSurfaceGraph"
    alias TOPOLOGY_3D = "topology3D"
    alias FULL_TOPOLOGY_3D = "fullTopology3D"
    alias ABSTRACT = "abstract"


trait Dimension():
    """Axis properties."""

    fn dimension_name(self) -> DimensionNameTypeCode:
        """Name of the axis."""
        ...

    fn dimension_size(self) -> Int:
        """Number of elements along the axis."""
        ...

    fn resolution(self) -> Float64:
        """Degree of detail in the grid dataset."""
        ...

    fn dimension_title(self) -> Optional[String]:
        """
        Enhancement/modifier of the dimension name, e.g.,
        for a different time dimension: dimensiont_title = 'runtime'
        or more a more general case : dimension_name = 'column'
        dimension_title = 'Longitude'.
        """
        ...

    fn dimension_description(self) -> Optional[String]:
        """Description of the axis."""
        ...


trait GeolocationInformation():
    """Geolocation information with data quality."""

    fn quality_info(self) -> Optional[Sequence[DataQuality]]:
        """
        Provides an overall assessment of quality of geolocation information.
        """
        ...


trait GCP():
    """Information on a ground control point (GSP)."""

    fn geographic_coordinates(self) -> DirectPosition:
        """
        Geographic or map position of the control point, in either two
        or three dimensions.
        """
        ...

    fn accuracy_report(self) -> Optional[Sequence[Element]]:
        """Accuracy of a ground control point."""
        ...


trait GCPCollection(GeolocationInformation):
    """A collection of ground control points (GCPs)."""

    fn collection_identification(self) -> Int:
        """Identifier of the GCP collection."""
        ...

    fn collection_name(self) -> String:
        """Name of the GCP collection."""
        ...

    fn coordinate_reference_system(self) -> ReferenceSystem:
        """Coordinate system in which the ground control points are defined."""
        ...

    fn gcp(self) -> Sequence[GCP]:
        """Ground control point(s) used in the collection."""


trait GeometricObjects():
    """Number of objects, listed by geometric object type, used in the
    resource/dataset.
    """

    fn geometric_object_type(self) -> GeometricObjectTypeCode:
        """
        Name of point or vector objects used to locate zero-, one-, two-,
        or three-dimensional spatial locations in the resource/dataset.
        """
        ...

    fn geometric_object_count(self) -> Optional[Int]:
        """Total number of the point or vector object type occurring in the
        resource/dataset.

        Domain: > 0
        """
        ...


trait SpatialRepresentation():
    """Digital mechanism used to represent spatial information."""

    fn scope(self) -> Scope:
        """Level and extent of the spatial representation."""
        ...


trait GridSpatialRepresentation(SpatialRepresentation):
    """Information about grid spatial objects in the resource."""

    fn number_of_dimensions(self) -> Int:
        """Number of independent spatial-temporal axes."""
        ...

    fn axis_dimension_properties(self) -> Sequence[Dimension]:
        """Information about spatial-temporal axis properties."""
        ...

    fn cell_geometry(self) -> CellGeometryCode:
        """Identification of grid data as point or cell."""
        ...

    fn transformation_parameter_availability(self):
        """
        Indication of whether or not parameters for transformation between
        image coordinates and geographic or map coordinates exist
        (are available).
        """
        ...


trait VectorSpatialRepresentation(SpatialRepresentation):
    """Information about the vector spatial objects in the resource."""

    fn topology_level(self) -> Optional[TopologyLevelCode]:
        """
        Code which identifies the degree of complexity of the spatial
        relationships.
        """
        ...

    fn geometric_objects(self) -> Optional[Sequence[GeometricObjects]]:
        """Information about the geometric objects used in the resource."""
        ...


trait Georectified(GridSpatialRepresentation):
    """
    Grid whose cells are regularly spaced in a geographic (i.e. lat / long) or
    map coordinate system defined in the Spatial Referencing System (SRS) so
    that any cell in the grid can be geolocated given its grid coordinate and
    the grid origin, cell spacing, and orientation.
    """

    fn check_point_availability(self) -> bool:
        """
        Indication of whether or not geographic position points are available
        to test the accuracy of the georeferenced grid data.
        """
        ...

    fn check_point_description(self) -> Optional[String]:
        """
        Description of geographic position points used to test the accuracy of
        the georeferenced grid data.

        MANDATORY: if `check_point_availability` == `True`.
        """
        ...

    fn corner_points(self) -> Optional[Sequence[GM_Point]]:
        """
        Earth location in the coordinate system defined by the Spatial
        Reference System and the grid coordinate of the cells at opposite ends
        of grid coverage along two diagonals in the grid spatial dimensions.
        There are four corner points in a georectified grid; at least two
        corner points along one diagonal are required. The first corner point
        corresponds to the origin of the grid.

        NOTE: The length of the `Sequence` of `GM_Points` should be 2 - 4
        (i.e. 2, 3, or 4).
        """
        ...

    fn centre_point(self) -> Optional[GM_Point]:
        """
        Earth location in the coordinate system defined by the Spatial
        Reference System and the grid coordinate of the cell halfway between
        opposite ends of the grid in the spatial dimensions.
        """
        ...

    fn point_in_pixel(self) -> PixelOrientationCode:
        """
        Point in a pixel corresponding to the Earth location of the pixel.
        """
        ...

    fn transformation_dimension_description(self) -> Optional[String]:
        """General description of the transformation."""
        ...

    fn transformation_dimension_mapping(self) -> Optional[Sequence[String]]:
        """Information about which grid axes are the spatial (map) axes."""
        ...

    fn check_point(self) -> Optional[Sequence[GCP]]:
        """
        Geographic references used to validate georectification of the data.
        """
        ...


trait Georeferenceable(GridSpatialRepresentation):
    """
    ISO 19115-1: Grid with cells irregularly spaced in any given
    geographic/map projection coordinate system, whose individual cells can be
    geolocated using geolocation information supplied with the data but cannot
    be geolocated from the grid properties alone.

    ISO 19115-2: Description of information provided in metadata that allows
    the geographic or map location of the raster points to be located.
    """

    fn control_point_availability(self) -> bool:
        """Indication of whether or not control point(s) exists."""
        ...

    fn orientation_parameter_availability(self) -> bool:
        """
        Indication of whether or not orientation parameters are available.
        """
        ...

    fn orientation_parameter_description(self) -> Optional[String]:
        """Description of parameters used to describe sensor orientation."""
        ...

    fn georeferenced_parameters(self) -> Record:
        """Terms which support grid data georeferencing."""
        ...

    fn parameter_citation(self) -> Optional[Sequence[Citation]]:
        """Reference providing description of the parameters."""
        ...

    fn geolocation_information(self) -> Sequence[GeolocationInformation]:
        """
        Information that can be used to geo-locate the data.
        """
        ...
