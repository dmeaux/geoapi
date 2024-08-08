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
"""This is the representation module.

This module contains geographic metadata structures regarding representation
derived from the ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass
from enum import Enum

from opengis.metadata.citation import Citation
from opengis.metadata.maintenance import Scope
from opengis.metadata.naming import Record


class CellGeometryCode(Enum):
    """Code indicating the geometry represented by the grid cell value."""

    POINT = "point"
    AREA = "area"
    VOXEL = "voxel"
    STRATUM = "stratum"


class DimensionNameTypeCode(Enum):
    """Name of the dimension."""

    ROW = "row"
    COLUMN = "column"
    VERTICAL = "vertical"
    TRACK = "track"
    CROSS_TRACK = "crossTrack"
    LINE = "line"
    SAMPLE = "sample"
    TIME = "time"


class GeometricObjectTypeCode(Enum):
    """
    Name of point or vector objects used to locate sero-, one-, two-, or
    three-dimensional spatial locations in the dataset.
    """

    COMPLEX = "complex"
    COMPOSITE = "composite"
    CURVE = "curve"
    POINT = "point"
    SOLID = "solid"
    SURFACE = "surface"


class PixelOrientationCode(Enum):
    """Point in a pixel corresponding to the Earth location of the pixel"""

    CENTER = "center"
    LOWER_LEFT = "lowerLeft"
    LOWER_RIGHT = "lowerRight"
    UPPER_RIGHT = "upperRight"
    UPPER_LEFT = "upperLeft"


class ReferenceSystemTypeCode(Enum):
    COMPOUND_ENGINEERING_PARAMETRIC = "compoundEngineeringParametric"
    COMPOUND_ENGINEERING_PARAMETRIC_TEMPORAL = \
        "compoundEngineeringParametricTemporal"
    COMPOUND_ENGINEERING_TEMPORAL = "compoundEngineeringTemporal"
    COMPOUND_ENGINEERING_VERTICAL = "compoundEngineeringVertical"
    COMPOUND_ENGINEERING_VERTICAL_TEMPORAL = \
        "compoundEngineeringVerticalTemporal"
    COMPOUND_GEOGRAPHIC2D_PARAMETRIC = "compoundGeographic2DParametric"
    COMPOUND_GEOGRAPHIC2D_PARAMETRIC_TEMPORAL = \
        "compoundGeographic2DParametricTemporal"
    COMPOUND_GEOGRAPHIC2D_TEMPORAL = "compoundGeographic2DTemporal"
    COMPOUND_GEOGRAPHIC2D_VERTICAL = "compoundGeographic2DVertical"
    COMPOUND_GEOGRAPHIC2D_VERTICAL_TEMPORAL = \
        "compoundGeographic2DVerticalTemporal"
    COMPOUND_GEOGRAPHIC3D_TEMPORAL = "compoundGeographic3DTemporal"
    COMPOUND_PROJECTED2D_PARAMETRIC = "compoundProjected2DParametric"
    COMPOUND_PROJECTED2D_PARAMETRIC_TEMPORAL = \
        "compoundProjected2DParametricTemporal"
    COMPOUND_PROJECTED_TEMPORAL = "compoundProjectedTemporal"
    COMPOUND_PROJECTED_VERTICAL = "compoundProjectedVertical"
    COMPOUND_PROJECTED_VERTICAL_TEMPORAL = "compoundProjectedVerticalTemporal"
    ENGINEERING = "engineering"
    ENGINEERING_DESIGN = "engineeringDesign"
    ENGINEERING_IMAGE = "engineeringImage"
    GEODETIC_GEOCENTRIC = "geodeticGeocentric"
    GEODETIC_GEOGRAPHIC_2D = "geodeticGeographic2D"
    GEODETIC_GEOGRAPHIC_3D = "geodeticGeographic3D"
    GEOGRAPHIC_IDENTIFIER = "geographicIdentifier"
    LINEAR = "linear"
    PARAMETRIC = "parametric"
    PROJECTED = "projected"
    TEMPORAL = "temporal"
    VERTICAL = "vertical"


class SpatialRepresentationTypeCode(Enum):
    """Method used to represent geographic information in the resource."""

    VECTOR = "vector"
    GRID = "grid"
    TEXT_TABLE = "textTable"
    TIN = "tin"
    STEREO_MODEL = "stereoModel"
    VIDEO = "video"


class TopologyLevelCode(Enum):
    """Degree of the complexity of the spatial relationships."""

    GEOMETRY_ONLY = "geometryOnly"
    TOPOLOGY_1D = "topology1D"
    PLANAR_GRAPH = "planarGraph"
    FULL_PLANAR_GRAPH = "fullPlanarGraph"
    SURFACE_GRAPH = "surfaceGraph"
    FULL_SURFACE_GRAPH = "fullSurfaceGraph"
    TOPOLOGY_3D = "topology3D"
    FULL_TOPOLOGY_3D = "fullTopology3D"
    ABSTRACT = "abstract"


@dataclass(frozen=True, slots=True)
class Dimension:
    """Axis properties.

    Attributes:
        dimension_name (DimensionNameTypeCode): Name of the axis.
        dimension_size (int): Number of elements along the axis.
        resolution (float): Degree of detail in the grid dataset.
        dimension_title (str): Enhancement/modifier of the dimension name,
            e.g., for other time dimension 'runtime' or
            dimensionName = 'column' dimensionTitle = 'Longitude'.
        dimension_description (str):

    """

    dimension_name: DimensionNameTypeCode
    dimension_size: int
    resolution: float
    dimension_title: str
    dimension_description: str


@dataclass(frozen=True, slots=True)
class GeolocationInformation:
    """Geolocation information with data quality.

    Attributes:
        quality_info (tuple[DataQuality, ...]): Data Quality for geolocation
            information.

    """

    quality_info: tuple["DataQuality", ...]


@dataclass(frozen=True, slots=True)
class GCP:
    """Ground Control Point.

    Attributes:
        geographic_coordinates (...): 
        accuracy_report (tuple[Element, ...]): 

    """

    geographic_coordinates: ...
    accuracy_report: tuple[Element, ...]


@dataclass(frozen=True, slots=True)
class GCPCollection(GeolocationInformation):
    """A collection of ground control points (GCPs).

    Attributes:
        gcp (tuple[GCP, ...]): Ground control point(s) used in the collection.
        collection_identification (int): Identifier of the GCP collection.
        collection_name (str): Name of the GCP collection.
        coordinate_reference_system (...): Coordinate system in which the
            ground control points are defined.

    """

    gcp: tuple[GCP, ...]
    collection_identification: int
    collection_name: str
    coordinate_reference_system: ...


@dataclass(frozen=True, slots=True)
class GeometricObjects:
    """Number of objects, listed by geometric object type, used in the dataset.

    Attributes:
        geometric_object_type (GeometricObjectTypeCode): Name of point or
            vector objects used to locate zero-, one-, two-, or
            three-dimensional spatial locations in the dataset.
        geometric_object_count (int):Total number of the point or vector
            object type occurring in the dataset.

    """

    geometric_object_type: GeometricObjectTypeCode
    geometric_object_count: int


@dataclass(frozen=True, slots=True)
class SpatialRepresentation:
    """Digital mechanism used to represent spatial information.

    Attributes:
        scope (Scope): Level and extent of the spatial representation.

    """

    scope: Scope


@dataclass(frozen=True, slots=True)
class GridSpatialRepresentation(SpatialRepresentation):
    """Information about grid spatial objects in the resource.

    Attributes:
        number_of_dimensions (int): Number of independent spatial-temporal
            axes.
        axis_dimension_properties (tuple[Dimension, ...]): Information about
            spatial-temporal axis properties.
        cell_geometry (CellGeometryCode): Identification of grid data as point
            or cell.
        transformation_parameter_availability (...): Indication of whether or
            not parameters for transformation between image coordinates and
            geographic or map coordinates exist (are available).

    """

    number_of_dimensions: int
    axis_dimension_properties: tuple[Dimension, ...]
    cell_geometry: CellGeometryCode
    transformation_parameter_availability: ...


@dataclass(frozen=True, slots=True)
class VectorSpatialRepresentation(SpatialRepresentation):
    """Information about the vector spatial objects in the resource.

    Attribute:
        topology_level (TopologyLevelCode): Code which identifies the degree
            of complexity of the spatial relationships.
        geometric_objects (tuple[GeometricObjects, ...]): Information about
            the geometric objects used in the resource.

    """

    topology_level: TopologyLevelCode
    geometric_objects: tuple[GeometricObjects, ...]


@dataclass(frozen=True, slots=True)
class Georectified(GridSpatialRepresentation):
    """Grid whose cells are regularly spaced in a geographic (i.e., lat / long)
    or map coordinate system defined in the Spatial Referencing System (SRS)
    so that any cell in the grid can be geolocated given its grid coordinate
    and the grid origin, cell spacing, and orientation.

    Attributes:
    check_point_availability (bool): Indication of whether or not geographic
        position points are available to test the accuracy of the
        georeferenced grid data.
    check_point_description (str): Description of geographic position points
        used to test the accuracy of the georeferenced grid data.
    corner_points (...): Earth location in the coordinate system defined by
        the Spatial Reference System and the grid coordinate of the cells at
        opposite ends of grid coverage along two diagonals in the grid spatial
        dimensions. There are four corner points in a georectified grid; at
        least two corner points along one diagonal are required. The first
        corner point corresponds to the origin of the grid.
    centre_point (...): Earth location in the coordinate system defined by the
        Spatial Reference System and the grid coordinate of the cell halfway
        between opposite ends of the grid in the spatial dimensions.
    point_in_pixel (PixelOrientationCode): Point in a pixel corresponding to
        the Earth location of the pixel.
    transformation_dimension_description (str): General description of the
        transformation.
    transformation_dimension_mapping (tuple[str, ...]): Information about
        which grid axes are the spatial (map) axes.
    check_point (tuple[GCP, ...]): 

    """

    check_point_availability: bool
    check_point_description: str
    corner_points: ...
    centre_point: ...
    point_in_pixel: PixelOrientationCode
    transformation_dimension_description: str
    transformation_dimension_mapping: tuple[str, ...]
    check_point: tuple[GCP, ...]


@dataclass(frozen=True, slots=True)
class Georeferenceable(GridSpatialRepresentation):
    """Grid with cells irregularly spaced in any given geographic/map
    projection coordinate system, whose individual cells can be geolocated
    using geolocation information supplied with the data but cannot be
    geolocated from the grid properties alone.

    Attributes:
        control_point_availability (...): Indication of whether or not control
            point(s) exists.
        orientation_parameter_availability (...): Indication of whether or not
            orientation parameters are available.
        orientation_parameter_description (str): Description of parameters
            used to describe sensor orientation.
        georeferenced_parameters (Record): Terms which support grid data
            georeferencing.
        parameter_citation (tuple[Citation, ...]): Reference providing
            description of the parameters.
        geolocation_information (tuple[GeolocationInformation, ...]): 

    """

    control_point_availability: ...
    orientation_parameter_availability: ...
    orientation_parameter_description: str
    georeferenced_parameters: Record
    parameter_citation: tuple[Citation, ...]
    geolocation_information: tuple[GeolocationInformation, ...]
