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

"""This is the cs module.

This module contains geographic metadata structures regarding coordinate
systems derived from the ISO 19111 international standard.
"""

from opengis.referencing.datum import IdentifiedObject


struct AxisDirection:
    """
    The direction of positive increase in the coordinate value for a coordinate system axis.
    This direction is exact in some cases, and is approximate in other cases.
    """

    alias COLUMN_NEGATIVE = "columnNegative"
    alias COLUMN_POSITIVE = "columnPositive"
    alias DISPLAY_DOWN = "displayDown"
    alias DISPLAY_LEFT = "displayLeft"
    alias DISPLAY_RIGHT = "displayRight"
    alias DISPLAY_UP = "displayUp"
    alias DOWN = "down"
    alias EAST = "east"
    alias EAST_NORTH_EAST = "eastNorthEast"
    alias EAST_SOUTH_EAST = "eastSouthEast"
    alias FUTURE = "future"
    alias GEOCENTRIC_X = "geocentricX"
    alias GEOCENTRIC_Y = "geocentricY"
    alias GEOCENTRIC_Z = "geocentricZ"
    alias NORTH = "north"
    alias NORTH_EAST = "northEast"
    alias NORTH_NORTH_EAST = "northNorthEast"
    alias NORTH_NORTH_WEST = "northNorthWest"
    alias NORTH_WEST = "northWest"
    alias PAST = "past"
    alias ROW_NEGATIVE = "rowNegative"
    alias ROW_POSITIVE = "rowPositive"
    alias SOUTH = "south"
    alias SOUTH_EAST = "southEast"
    alias SOUTH_SOUTH_EAST = "southSouthWest"
    alias SOUTH_SOUTH_WEST = "southSouthWest"
    alias SOUTH_WEST = "southWest"
    alias UP = "up"
    alias WEST = "west"
    alias WEST_NORTH_WEST = "westNorthWest"
    alias WEST_SOUTH_WEST = "westSouthWest"


struct RangeMeaning:
    """
    Meaning of the axis value range specified through minimum value and maximum value.
    """

    alias EXACT = "exact"
    alias WRAPAROUND = "wraparound"


trait CoordinateSystemAxis(IdentifiedObject):
    """
    Definition of a coordinate system axis.
    """

    fn abbreviation(self) -> String:
        """
        The abbreviation used for this coordinate system axes.
        This abbreviation is also used to identify the coordinate in a coordinate tuple.

        :return: The coordinate system axis abbreviation.
        :rtype: Int
        """
        ...

    fn direction(self) -> AxisDirection:
        """
        Direction of this coordinate system axis.

        :return: The coordinate system axis direction.
        :rtype: AxisDirection
        """
        ...

    fn unit(self):
        """
        Returns the unit of measure used for this coordinate system axis.
        The value of a coordinate in a coordinate tuple shall be recorded using this unit of measure, whenever those
        coordinates use a coordinate reference system that uses a coordinate system that uses this axis.

        :return: The coordinate system axis unit.
        """
        ...

    fn minimum_value(self) -> Float64:
        """
        Returns the minimum value normally allowed for this axis, in the unit of measure for the axis.
        If there is no minimum value, then this method returns negative infinity.

        :return: The minimum value, or the negative infinity if none.
        :rtype: Float64
        """
        return Float64("-inf")

    fn maximum_value(self) -> Float64:
        """
        Returns the maximum value normally allowed for this axis, in the unit of measure for the axis.
        If there is no maximum value, then this method returns positive infinity.

        :return: The maximum value, or the positive infinity if none.
        :rtype: Float64
        """
        return Float64("inf")

    fn range_meaning(self) -> RangeMeaning:
        """
        Returns the meaning of axis value range specified by the minimum and maximum values. This element shall be
        omitted when both minimum and maximum values are omitted. It may be included when minimum and/or maximum values
        are included. If this element is omitted when minimum or maximum values are included, the meaning is unspecified

        :return: The range meaning, or null in none.
        :rtype: RangeMeaning
        """
        ...


trait CoordinateSystem(IdentifiedObject):
    """
    The set of coordinate system axes that spans a given coordinate space. A coordinate system (CS) is derived from a
    set of (mathematical) rules for specifying how coordinates in a given space are to be assigned to points.
    The coordinate values in a coordinate tuple shall be recorded in the order in which the coordinate system axes
    associations are recorded, whenever those coordinates use a coordinate reference system that uses this coordinate system.
    """

    fn dimension(self) -> Int:
        """
        Returns the dimension of the coordinate system.

        :return: The dimension of the coordinate system.
        :rtype: Int
        """
        ...

    fn axis(self, dimension: Int) -> CoordinateSystemAxis:
        """
        Returns the axis for this coordinate system at the specified dimension.

        :param dimension: The zero based index of axis.
        :type dimension: Int
        :return: The axis at the specified dimension.
        :rtype: CoordinateSystemAxis
        """
        ...


trait AffineCS(CoordinateSystem):
    """
    A 2- or 3-dimensional coordinate system with straight axes that are not necessarily orthogonal.
    """

    ...


trait CartesianCS(CoordinateSystem):
    """
    A 2- or 3-dimensional coordinate system with orthogonal straight axes. All axes shall have the same length unit of
    measure.
    """

    ...


trait CylindricalCS(CoordinateSystem):
    """
    A 3-dimensional coordinate system consisting of a PolarCS extended by a straight axis perpendicular to the plane
    spanned by the polar CS.
    """

    ...


trait EllipsoidalCS(CoordinateSystem):
    """
    A 2- or 3-dimensional coordinate system in which position is specified by geodetic latitude, geodetic longitude,
    and (in the 3D case) ellipsoidal height.
    """

    ...


trait LinearCS(CoordinateSystem):
    """
    A 1-dimensional coordinate system that consists of the points that lie on the single axis described.
    The associated coordinate is the distance – with or without offset – from the origin point,
    specified through the datum definition, to the point along the axis.
    """

    ...


trait ParametricCS(CoordinateSystem):
    """
    A 1-dimensional coordinate system containing a single axis. This coordinate system uses parameter values or
    functions to describe the position of a point.
    """

    ...


trait PolarCS(CoordinateSystem):
    """
    A 2-dimensional coordinate system in which position is specified by the distance from the origin and the angle
    between the line from the origin to a point and a reference direction.
    """

    ...


trait SphericalCS(CoordinateSystem):
    """
    A 3-dimensional coordinate system with one distance measured from the origin and two angular coordinates.
    Not to be confused with an EllipsoidalCS based on an ellipsoid "degenerated" into a sphere.
    """

    ...


trait TimeCS(CoordinateSystem):
    """
    A 1-dimensional coordinate system containing a single time axis. This coordinate system is used to describe the
    temporal position of a point in the specified time units from a specified time origin.
    """

    ...


trait VerticalCS(CoordinateSystem):
    """
    A 1-dimensional coordinate system used to record the heights or depths of points. Such a coordinate system is
    usually dependent on the Earth's gravity field, perhaps loosely as when atmospheric pressure is the basis for the
    vertical coordinate system axis. An exact definition is deliberately not provided as the complexities of the subject
    fall outside the scope of the ISO 19111 specification.
    """

    ...
