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
"""This is the `measure` module.

This module contains measure types defined in the ISO 19103:2015
specification for which no equivalence is already present in the Python
standard library.
"""

from opengis.geometry.primitive import Vector


struct StandardUnits:
    """Standard units are the base and named derived units that form part of the
    International System of Units (SI), plus units which are based on SI units
    and are required for the other measures, for example metres per second.
    """

    alias METRE = "metre"
    alias SECOND = "second"
    alias RADIAN = "radian"
    alias SQUARE_METRE = "squareMetre"
    alias CUBIC_METRE = "cubicMetre"
    alias METER_PR_SECOND = "metrePrSecond"
    alias METRE_PR_METRE = "metrePrMetre"
    alias METRE_PR_SECOND_PR_SECOND = "metrePrSecondPrSecond"
    alias RADIAN_PR_SECOND = "radianPrSecond"
    alias RADIAN_PR_SECOND_PR_SECOND = "radianPrSecondPrSecond"
    alias KILOGRAM = "kilomgram"


struct UnitsList:
    """This code list contains other units which are not part of SI, but are
    in common use in some parts of the world.
    """

    alias METRE = "metre"
    alias SECOND = "second"
    alias RADIAN = "radian"
    alias SQUARE_METRE = "squareMetre"
    alias CUBIC_METRE = "cubicMetre"
    alias METER_PR_SECOND = "metrePrSecond"
    alias METRE_PR_METRE = "metrePrMetre"
    alias METRE_PR_SECOND_PR_SECOND = "metrePrSecondPrSecond"
    alias RADIAN_PR_SECOND = "radianPrSecond"
    alias RADIAN_PR_SECOND_PR_SECOND = "radianPrSecondPrSecond"
    alias KILOGRAM = "kilomgram"
    alias FOOT = "foot"
    alias SQUARE_FOOT = "squareFoot"
    alias CUBIC_YARD = "cubicYard"


trait SubUnitsPerUnit:
    """Sub units per unit."""

    fn factor(self) -> Float64:
        """The number of sub units per unit."""
        ...


trait UnitOfMeasure:
    """A `UnitOfMeasure` is a quantity adopted as a standard of measurement
    for other quantities of the same kind.
    """

    fn uom_identifier(self) -> String:
        """A string used to identify the unit of measure.

        Examples:
            foot, metre, radian, degree, inch, minute,
            kilometres per hour
        """
        ...

    fn subunit(self) -> Optional[SubUnitsPerUnit]:
        """The sub units per unit"""
        ...


trait UomArea(UnitOfMeasure):
    """`UomArea` is any of the reference quantities used to express the value of
    area. Common units include square length units, such as square metres and
    square feet. Other common unit include acres (in the US) and hectares.
    """


trait UomLength(UnitOfMeasure):
    """`UomLength` is any of the reference quantities used to express the value of
    the length, distance between two entities. Examples are the English System
    of feet and inches or the metric system of millimetres, centimetres and
    metres, also the System International (SI) System of Units.
    """


trait UomAngle(UnitOfMeasure):
    """`UomAngle` is any of the reference quantities used to express the value of
    angles. In the US, the sexagesimal system of degrees, minutes and seconds
    is frequently used. The radian measurement system is also used. In other
    parts of the world the grad angle, gon, measuring system is used.
    """


trait UomAcceleration(UnitOfMeasure):
    """`UomAcceleration` provides both the unit of measure of the velocity and of
    the time, for example metres per second, per second.
    """


trait UomAngularAcceleration(UnitOfMeasure):
    """`UomAngularAcceleration` provides both the unit of measure of the angular
    velocity and of the time, for example degrees per second, per second.
    """


trait UomAngularSpeed(UnitOfMeasure):
    """`UomAngularSpeed` provides both the unit of measure of the angle and of the
    time, for example degrees per second.
    """


trait UomSpeed(UnitOfMeasure):
    """`UomSpeed` provides both the unit of measure of the distance and of the
    time, for example kilometres per hour, or metres per second.
    """


trait UomCurrency(UnitOfMeasure):
    """`UomCurrency` indicates the specific currency, such as one listed
    in ISO 4217.
    """


trait UomVolume(UnitOfMeasure):
    """`UomVolume` is any of the reference quantities used to express the value
    of volume.
    """


trait UomTime(UnitOfMeasure):
    """`UomTime` is any of the reference quantities used to express the value of or
    reckoning the passage of time and/or date, (e.g. seconds, minutes,
    days, months).
    """


trait UomScale(UnitOfMeasure):
    """`UomScale` is any of the reference quantities used to express the value of
    scale, or the ratio between quantities with the same unit. Scale factors
    are often unitless.
    """


trait UomWeight(UnitOfMeasure):
    """`UomWeight` is any of the reference quantities used to express force,
    such as newton.
    """


trait UomVelocity(UnitOfMeasure):
    """`UomVelocity` is any of the reference quantities used to express the value
    of velocity.
    """


trait UomAngularVelocity(UnitOfMeasure):
    """`UomAngularVelocity` is any of the reference quantities used to express
    the value of angular velocity. It must include an indication of which
    direction is considered positive.
    """


trait Measure:
    """A `Measure` is the result from performing the act or process of
    ascertaining the value of a characteristic of some entity.
    """

    fn value(self) -> Float64:
        """The value of the measure."""
        ...

    fn unit_of_measure(self) -> UnitOfMeasure:
        """The units of the measure."""
        ...


trait Length(Measure):
    """`Length` is the measure of distance as an integral, for example the length
    of curve, the perimeter of a polygon as the length of the boundary.
    """

    fn unit_of_measure(self) -> UomLength:
        """The units of the length."""
        ...


trait Distance(Length):
    """`Distance` is used as a type for returning the separation between two points.
    """


trait Speed(Measure):
    """`Speed` is the rate at which someone or something moves, generally expressed
    as distance over time. It is distinct from velocity in that speed can be
    measured along a curve.
    """

    fn time(self) -> UomTime:
        "The units of measure for the time."
        ...

    fn distance(self) -> UomLength:
        "The units of measure for the distance."
        ...

    fn unit_of_measure(self) -> UomSpeed:
        """The units of the speed."""
        ...


trait Angle(Measure):
    """`Angle` is the amount of rotation needed to bring one line or plane into
    coincidence with another, generally measured in radians or degrees.
    """

    fn unit_of_measure(self) -> UomAngle:
        """The units of the angle."""
        ...


trait Scale(Measure):
    """`Scale` is the ratio of one quantity to another, often unitless."""

    fn unit_of_measure(self) -> UomScale:
        """The units of the length."""
        ...

    fn source_units(self) -> UomLength:
        """The units of the source measure."""
        ...

    fn target_units(self) -> UomLength:
        """The units of the target measure."""
        ...


trait TimeMeasure(Measure):
    """`TimeMeasure` is the designation of an instant on a selected time scale,
    astronomical or atomic. It is used in the sense of time of day.
    """

    fn unit_of_measure(self) -> UomTime:
        """The units of the time."""
        ...


trait Area(Measure):
    """`Area` is the measure of the physical extent of any 2-D geometric object.
    """

    fn unit_of_measure(self) -> UomArea:
        """The units of the area."""
        ...


trait Volume(Measure):
    """`Volume` is the measure of the physical space of any 3-D geometric object.
    """

    fn unit_of_measure(self) -> UomVolume:
        """The units of the volume."""
        ...


trait Currency(Measure):
    """`Currency` is a system of money in general use in a particular country
    or countries.
    """

    fn unit_of_measure(self) -> UomCurrency:
        """The units of the currency."""
        ...


trait Weight(Measure):
    """`Weight` is the force exerted on the mass of a body by a gravitational field.
    """

    fn unit_of_measure(self) -> UomWeight:
        """The units of the weight."""
        ...


trait AngularSpeed(Measure):
    """`AngularSpeed` (often known as angular velocity) is the magnitude of the
    rate of change of angular position of a rotating body. Angular speed
    is always positive.
    """

    fn unit_of_measure(self) -> UomAngularSpeed:
        """The units of the angular speed."""
        ...


trait DirectedMeasure:
    """A `DirectedMeasure` is the result of ascertaining the value of
    a characteristic of some entity where direction is an essential aspect
    of the characteristic.
    """

    fn value(self) -> Vector:
        """The magnitude and direction of the directed measure."""
        ...

    fn unit_of_measure(self) -> UnitOfMeasure:
        """The units of the directed measure."""
        ...


trait Velocity(DirectedMeasure):
    """`Velocity` is the instantaneous rate of change of position with time.
    It is usually calculated using the simple formula, the change in position
    during a given time interval.
    """


trait AngularVelocity(DirectedMeasure):
    """`AngularVelocity` is the instantaneous rate of change of angular
    displacement with time.
    """

    fn unit_of_measure(self) -> UomSpeed:
        """The units of the speed."""
        ...

    fn time(self) -> UomTime:
        """The units of the time."""
        ...

    fn angle(self) -> UomAngle:
        """The units of the angle."""
        ...


trait Acceleration(DirectedMeasure):
    """`Acceleration` is the rate of change of velocity per unit of time.
    """


trait AngularAcceleration(DirectedMeasure):
    """`AngularAcceleration` is the rate of change of angular velocity per unit
    of time.
    """
