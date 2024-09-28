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

# author: OGC Topic 2 (for abstract model and documentation), David Meaux

"""This is the `cs` module.

This module contains geographic metadata structures regarding coordinate
systems derived from the ISO 19111 international standard.
"""

from opengis.referencing.datum import IdentifiedObject


struct AxisDirection:
    """The direction of positive increase in the coordinate value for a
    coordinate system axis. This direction is exact in some cases, and is
    approximate in other cases.
    """

    alias NORTH = "north"
    """Axis positive direction is north. In a geodetic or projected CRS, north is
    defined through the geodetic reference frame. In an engineering CRS, north
    may be defined with respect to an engineering object rather than a
    geographical direction.
    """

    alias NORTH_NORTH_EAST = "northNorthEast"
    """Axis positive direction is approximately north-north-east."""

    alias NORTH_EAST = "northEast"
    """Axis positive direction is approximately north-east."""

    alias EAST_NORTH_EAST = "eastNorthEast"
    """Axis positive direction is approximately east-north-east."""

    alias EAST = "east"
    """Axis positive direction is ϖ/2 radians clockwise from north."""

    alias EAST_SOUTH_EAST = "eastSouthEast"
    """Axis positive direction is approximately east-south-east."""

    alias SOUTH_EAST = "southEast"
    """Axis positive direction is approximately south-east."""

    alias SOUTH_SOUTH_EAST = "southSouthWest"
    """Axis positive direction is approximately south-south-east."""

    alias SOUTH = "south"
    """Axis positive direction is ϖ radians clockwise from north."""

    alias SOUTH_SOUTH_WEST = "southSouthWest"
    """Axis positive direction is approximately south-south-west."""

    alias SOUTH_WEST = "southWest"
    """Axis positive direction is approximately south-west."""

    alias WEST_SOUTH_WEST = "westSouthWest"
    """Axis positive direction is approximately west-south-west."""

    alias WEST = "west"
    """Axis positive direction is 3ϖ/2 radians clockwise from north."""

    alias WEST_NORTH_WEST = "westNorthWest"
    """Axis positive direction is approximately west-north-west."""

    alias NORTH_WEST = "northWest"
    """Axis positive direction is approximately north-west."""

    alias NORTH_NORTH_WEST = "northNorthWest"
    """Axis positive direction is approximately north-north-west."""

    alias UP = "up"
    """Axis positive direction is up relative to gravity."""

    alias DOWN = "down"
    """Axis positive direction is down relative to gravity."""

    alias GEOCENTRIC_X = "geocentricX"
    """Axis positive direction is in the equatorial plane from the centre of the
    modelled Earth towards the intersection of the equator with the prime
    meridian.
    """

    alias GEOCENTRIC_Y = "geocentricY"
    """Axis positive direction is in the equatorial plane from the centre of the
    modelled Earth towards the intersection of the equator and the meridian
    ϖ/2 radians eastwards from the prime meridian.
    """

    alias GEOCENTRIC_Z = "geocentricZ"
    """Axis positive direction is from the centre of the modelled Earth parallel
    to its rotation axis and towards its north pole.
    """

    alias COLUMN_POSITIVE = "columnPositive"
    """Axis positive direction is towards higher pixel column."""

    alias COLUMN_NEGATIVE = "columnNegative"
    """Axis positive direction is towards lower pixel column."""

    alias ROW_POSITIVE = "rowPositive"
    """Axis positive direction is towards higher pixel row."""

    alias ROW_NEGATIVE = "rowNegative"
    """Axis positive direction is towards lower pixel row."""

    alias DISPLAY_RIGHT = "displayRight"
    """Axis positive direction is right in display."""

    alias DISPLAY_LEFT = "displayLeft"
    """Axis positive direction is left in display."""

    alias DISPLAY_UP = "displayUp"
    """Axis positive direction is towards top of approximately vertical display
    surface.
    """

    alias DISPLAY_DOWN = "displayDown"
    """Axis positive direction is towards bottom of approximately vertical
    display surface.
    """

    alias FORWARD = "forward"
    """Axis positive direction is forward; for an observer at the centre of the
    object this is will be towards its front, bow or nose.
    """

    alias AFT = "aft"
    """Axis positive direction is aft; for an observer at the centre of the
    object this will be towards its back, stern or tail.
    """

    alias PORT = "port"
    """Axis positive direction is port; for an observer at the centre of the
    object this will be towards its left.
    """

    alias STARBOARD = "starboard"
    """Axis positive direction is starboard; for an observer at the centre of the
    object this will be towards its right.
    """

    alias CLOCKWISE = "clockwise"
    """Axis positive direction is clockwise from a specified direction."""

    alias COUNTER_CLOCKWISE = "counterclockwise"
    """Axis positive direction is counter clockwise from a specified direction.
    """

    alias TOWARDS = "towards"
    """Axis positive direction is towards the object."""

    alias AWAY_FROM = "awayfrom"
    """Axis positive direction is away from the object."""

    alias FUTURE = "future"
    """Temporal axis positive direction is towards the future."""

    alias PAST = "past"
    """Temporal axis positive direction is towards the past."""

    alias UNSPECIFIED = "unspecified"
    """Axis positive direction is unspecified."""


trait CoordinateSystemAxis(IdentifiedObject):
    """Definition of a coordinate system axis."""

    fn abbreviation(self) -> String:
        """The abbreviation used for this coordinate system axes.
        This abbreviation is also used to identify the coordinate in a
        coordinate tuple.

        :return: The coordinate system axis abbreviation.
        :rtype: int
        """
        ...

    fn direction(self) -> AxisDirection:
        """Direction of this coordinate system axis.

        :return: The coordinate system axis direction.
        :rtype: AxisDirection
        """
        ...

    fn unit(self):
        """Returns the unit of measure used for this coordinate system axis.
        The value of a coordinate in a coordinate tuple shall be recorded
        using this unit of measure, whenever those coordinates use a
        coordinate reference system that uses a coordinate system that uses
        this axis.

        :return: The coordinate system axis unit.
        """
        ...

    fn minimum_value(self) -> Float64:
        """Returns the minimum value normally allowed for this axis, in the unit
        of measure for the axis. If there is no minimum value, then this
        method returns negative infinity.

        :return: The minimum value, or the negative infinity if none.
        :rtype: float
        """
        return float("-inf")

    fn maximum_value(self) -> Float64:
        """Returns the maximum value normally allowed for this axis, in the unit
        of measure for the axis. If there is no maximum value, then this
        method returns positive infinity.

        :return: The maximum value, or the positive infinity if none.
        :rtype: float
        """
        return float("inf")

    fn range_meaning(self) -> RangeMeaning:
        """Returns the meaning of axis value range specified by the minimum and
        maximum values. This element shall be omitted when both minimum and
        maximum values are omitted. It may be included when minimum and/or
        maximum values are included. If this element is omitted when minimum
        or maximum values are included, the meaning is unspecified.

        :return: The range meaning, or null in none.
        :rtype: RangeMeaning
        """
        ...


trait CoordinateSystem(IdentifiedObject):
    """The set of coordinate system axes that spans a given coordinate space.
    A coordinate system (CS) is derived from a set of (mathematical) rules for
    specifying how coordinates in a given space are to be assigned to points.
    The coordinate values in a coordinate tuple shall be recorded in the order
    in which the coordinate system axes associations are recorded, whenever
    those coordinates use a coordinate reference system that uses this
    coordinate system.
    """

    fn dimension(self) -> Int:
        """Returns the dimension of the coordinate system.

        :return: The dimension of the coordinate system.
        :rtype: int
        """
        ...

    fn axis(self, dimension: int) -> CoordinateSystemAxis:
        """Returns the axis for this coordinate system at the specified dimension.

        :param dimension: The zero based index of axis.
        :type dimension: int
        :return: The axis at the specified dimension.
        :rtype: CoordinateSystemAxis
        """
        ...


trait AffineCS(CoordinateSystem):
    """A 2- or 3-dimensional coordinate system with straight axes that are not
    necessarily orthogonal.
    """


trait CartesianCS(CoordinateSystem):
    """A 2- or 3-dimensional coordinate system with orthogonal straight axes. All
    axes shall have the same length unit of
    measure.
    """


trait CylindricalCS(CoordinateSystem):
    """A 3-dimensional coordinate system consisting of a PolarCS extended by a
    straight axis perpendicular to the plane
    spanned by the polar CS.
    """


trait EllipsoidalCS(CoordinateSystem):
    """A 2- or 3-dimensional coordinate system in which position is specified by
    geodetic latitude, geodetic longitude,
    and (in the 3D case) ellipsoidal height.
    """


trait LinearCS(CoordinateSystem):
    """A 1-dimensional coordinate system that consists of the points that lie on
    the single axis described. The associated coordinate is the distance -
    with or without offset - from the origin point, specified through the
    datum definition, to the point along the axis.
    """


trait ParametricCS(CoordinateSystem):
    """A 1-dimensional coordinate system containing a single axis. This
    coordinate system uses parameter values or functions to describe the
    position of a point.
    """


trait PolarCS(CoordinateSystem):
    """A 2-dimensional coordinate system in which position is specified by the
    distance from the origin and the angle between the line from the origin to
    a point and a reference direction.
    """


trait SphericalCS(CoordinateSystem):
    """A 3-dimensional coordinate system with one distance measured from the
    origin and two angular coordinates. Not to be confused with an
    EllipsoidalCS based on an ellipsoid "degenerated" into a sphere.
    """


trait TimeCS(CoordinateSystem):
    """A 1-dimensional coordinate system containing a single time axis. This
    coordinate system is used to describe the temporal position of a point in
    the specified time units from a specified time origin.
    """


trait VerticalCS(CoordinateSystem):
    """A 1-dimensional coordinate system used to record the heights or depths of
    points. Such a coordinate system is usually dependent on the Earth's
    gravity field, perhaps loosely as when atmospheric pressure is the basis
    for the vertical coordinate system axis. An exact definition is
    deliberately not provided as the complexities of the subject fall outside
    the scope of the ISO 19111 specification.
    """
