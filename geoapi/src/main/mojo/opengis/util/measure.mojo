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

from collections import Optional, KeyElement

from opengis.geometry.primitive import Vector


@value
struct StandardUnits(
    CollectionElement,
    KeyElement,
    Representable,
    Stringable,
    Writable,
    ):
    """Are the base and named derived units that form part of the International
    System of Units (SI), plus units which are based on SI units and are required
    for the other measures, for example metres per second.
    """

    alias type = String
    var value: Self.type
    """The underlying storage value for the StandardUnits value."""

    alias METRE = StandardUnits("metre")
    alias SECOND = StandardUnits("second")
    alias RADIAN = StandardUnits("radian")
    alias SQUARE_METRE = StandardUnits("squareMetre")
    alias CUBIC_METRE = StandardUnits("cubicMetre")
    alias METER_PR_SECOND = StandardUnits("metrePrSecond")
    alias METRE_PR_METRE = StandardUnits("metrePrMetre")
    alias METRE_PR_SECOND_PR_SECOND = StandardUnits("metrePrSecondPrSecond")
    alias RADIAN_PR_SECOND = StandardUnits("radianPrSecond")
    alias RADIAN_PR_SECOND_PR_SECOND = StandardUnits("radianPrSecondPrSecond")
    alias KILOGRAM = StandardUnits("kilomgram")

    @always_inline
    fn __init__(out self, *, other: Self):
        """Copy this StandardUnits.

        Args:
            other: The StandardUnits to copy.
        """
        self = other

    @staticmethod
    fn _from_str(str: String) -> StandardUnits:
        """Construct a StandardUnits from a string.

        Args:
            str: The name of the StandardUnits.
        """
        if str.startswith(String("StandardUnits.")):
            return Self._from_str(str.removeprefix("StandardUnits."))
        elif str == String("metre"):
            return StandardUnits.METRE
        elif str == String("second"):
            return StandardUnits.SECOND
        elif str == String("radian"):
            return StandardUnits.RADIAN
        elif str == String("squareMetre"):
            return StandardUnits.SQUARE_METRE
        elif str == String("cubicMetre"):
            return StandardUnits.CUBIC_METRE
        elif str == String("metrePrSecond"):
            return StandardUnits.METER_PR_SECOND
        elif str == String("metrePrMetre"):
            return StandardUnits.METRE_PR_METRE
        elif str == String("metrePrSecondPrSecond"):
            return StandardUnits.METRE_PR_SECOND_PR_SECOND
        elif str == String("radianPrSecond"):
            return StandardUnits.RADIAN_PR_SECOND
        elif str == String("radianPrSecondPrSecond"):
            return StandardUnits.RADIAN_PR_SECOND_PR_SECOND
        elif str == String("kilomgram"):
            return StandardUnits.KILOGRAM

    @no_inline
    fn __str__(self) -> String:
        """Gets the name of the StandardUnits.

        Returns:
            The name of the StandardUnits.
        """

        return String.write(self)

    @no_inline
    fn write_to[W: Writer](self, mut writer: W):
        """
        Formats this StandardUnits to the provided Writer.

        Parameters:
            W: A type conforming to the Writable trait.

        Args:
            writer: The object to write to.
        """

        return writer.write(self.value)

    @always_inline("nodebug")
    fn __repr__(self) -> String:
        """Gets the representation of the StandardUnits e.g. `"StandardUnits.TANGENT"`.

        Returns:
            The representation of the StandardUnits.
        """
        return String.write("StandardUnits.", self)

    @always_inline("nodebug")
    fn __is__(self, rhs: StandardUnits) -> Bool:
        """Compares one StandardUnits to another for equality.

        Args:
            rhs: The StandardUnits to compare against.

        Returns:
            True if the StandardUnitss are the same and False otherwise.
        """
        return self == rhs

    @always_inline("nodebug")
    fn __isnot__(self, rhs: StandardUnits) -> Bool:
        """Compares one StandardUnits to another for inequality.

        Args:
            rhs: The StandardUnits to compare against.

        Returns:
            True if the StandardUnitss are the same and False otherwise.
        """
        return self != rhs

    @always_inline("nodebug")
    fn __eq__(self, rhs: StandardUnits) -> Bool:
        """Compares one StandardUnits to another for equality.

        Args:
            rhs: The StandardUnits to compare against.

        Returns:
            True if the StandardUnitss are the same and False otherwise.
        """
        return self.value == rhs.value

    @always_inline("nodebug")
    fn __ne__(self, rhs: StandardUnits) -> Bool:
        """Compares one StandardUnits to another for inequality.

        Args:
            rhs: The StandardUnits to compare against.

        Returns:
            False if the StandardUnitss are the same and True otherwise.
        """
        return self.value != rhs.value

    fn __hash__(self) -> UInt:
        """Return a 64-bit hash for this `StandardUnits` value.

        Returns:
            A 64-bit integer hash of this `StandardUnits` value.
        """
        return hash(self.value)    


@value
struct UnitsList(
    CollectionElement,
    KeyElement,
    Representable,
    Stringable,
    Writable,
):
    """This code list contains other units which are not part of SI, but are
    in common use in some parts of the world.
    """

    alias type = String
    var value: Self.type
    """The underlying storage value for the UnitsList value."""
    
    alias METRE = UnitsList("metre")
    alias SECOND = UnitsList("second")
    alias RADIAN = UnitsList("radian")
    alias SQUARE_METRE = UnitsList("squareMetre")
    alias CUBIC_METRE = UnitsList("cubicMetre")
    alias METER_PR_SECOND = UnitsList("metrePrSecond")
    alias METRE_PR_METRE = UnitsList("metrePrMetre")
    alias METRE_PR_SECOND_PR_SECOND = UnitsList("metrePrSecondPrSecond")
    alias RADIAN_PR_SECOND = UnitsList("radianPrSecond")
    alias RADIAN_PR_SECOND_PR_SECOND = UnitsList("radianPrSecondPrSecond")
    alias KILOGRAM = UnitsList("kilomgram")
    alias FOOT = UnitsList("foot")
    alias SQUARE_FOOT = UnitsList("squareFoot")
    alias CUBIC_YARD = UnitsList("cubicYard")

    @always_inline
    fn __init__(out self, *, other: Self):
        """Copy this UnitsList.

        Args:
            other: The UnitsList to copy.
        """
        self = other

    @staticmethod
    fn _from_str(str: String) -> UnitsList:
        """Construct a UnitsList from a string.

        Args:
            str: The name of the UnitsList.
        """
        if str.startswith(String("UnitsList.")):
            return Self._from_str(str.removeprefix("UnitsList."))
        elif str == String("metre"):
            return UnitsList.METRE
        elif str == String("second"):
            return UnitsList.SECOND
        elif str == String("radian"):
            return UnitsList.RADIAN
        elif str == String("squareMetre"):
            return UnitsList.SQUARE_METRE
        elif str == String("cubicMetre"):
            return UnitsList.CUBIC_METRE
        elif str == String("metrePrSecond"):
            return UnitsList.METER_PR_SECOND
        elif str == String("metrePrMetre"):
            return UnitsList.METRE_PR_METRE
        elif str == String("metrePrSecondPrSecond"):
            return UnitsList.METRE_PR_SECOND_PR_SECOND
        elif str == String("radianPrSecond"):
            return UnitsList.RADIAN_PR_SECOND
        elif str == String("radianPrSecondPrSecond"):
            return UnitsList.RADIAN_PR_SECOND_PR_SECOND
        elif str == String("kilomgram"):
            return UnitsList.KILOGRAM
        elif str == String("foot"):
            return UnitsList.FOOT
        elif str == String("squareFoot"):
            return UnitsList.SQUARE_FOOT
        elif str == String("cubicYard"):
            return UnitsList.CUBIC_YARD

    @no_inline
    fn __str__(self) -> String:
        """Gets the name of the UnitsList.

        Returns:
            The name of the UnitsList.
        """

        return String.write(self)

    @no_inline
    fn write_to[W: Writer](self, mut writer: W):
        """
        Formats this UnitsList to the provided Writer.

        Parameters:
            W: A type conforming to the Writable trait.

        Args:
            writer: The object to write to.
        """

        return writer.write(self.value)

    @always_inline("nodebug")
    fn __repr__(self) -> String:
        """Gets the representation of the UnitsList e.g. `"UnitsList.TANGENT"`.

        Returns:
            The representation of the UnitsList.
        """
        return String.write("UnitsList.", self)

    @always_inline("nodebug")
    fn __is__(self, rhs: UnitsList) -> Bool:
        """Compares one UnitsList to another for equality.

        Args:
            rhs: The UnitsList to compare against.

        Returns:
            True if the UnitsLists are the same and False otherwise.
        """
        return self == rhs

    @always_inline("nodebug")
    fn __isnot__(self, rhs: UnitsList) -> Bool:
        """Compares one UnitsList to another for inequality.

        Args:
            rhs: The UnitsList to compare against.

        Returns:
            True if the UnitsLists are the same and False otherwise.
        """
        return self != rhs

    @always_inline("nodebug")
    fn __eq__(self, rhs: UnitsList) -> Bool:
        """Compares one UnitsList to another for equality.

        Args:
            rhs: The UnitsList to compare against.

        Returns:
            True if the UnitsLists are the same and False otherwise.
        """
        return self.value == rhs.value

    @always_inline("nodebug")
    fn __ne__(self, rhs: UnitsList) -> Bool:
        """Compares one UnitsList to another for inequality.

        Args:
            rhs: The UnitsList to compare against.

        Returns:
            False if the UnitsLists are the same and True otherwise.
        """
        return self.value != rhs.value

    fn __hash__(self) -> UInt:
        """Return a 64-bit hash for this `UnitsList` value.

        Returns:
            A 64-bit integer hash of this `UnitsList` value.
        """
        return hash(self.value)    


trait SubUnitsPerUnitCollectionElement(CollectionElement, SubUnitsPerUnit):
     """Abstract collection element conforming to the SubUnitsPerUnit trait."""
     ...


trait SubUnitsPerUnit:
    """Sub units per unit."""

    fn factor(self) -> Float64:
        """The number of sub units per unit."""
        ...


trait UnitOfMeasureCollectionElement(CollectionElement, UnitOfMeasure):
     """Abstract collection element conforming to the UnitOfMeasure trait."""
     ...


trait UnitOfMeasure:
    """A quantity adopted as a standard of measurement for other quantities of the same kind."""

    fn uom_identifier(self) -> String:
        """A string used to identify the unit of measure.

        Examples:
            foot, metre, radian, degree, inch, minute,
            kilometres per hour
        """
        ...

    fn subunit[type: SubUnitsPerUnitCollectionElement](self) -> Optional[type]:
        """The sub units per unit.

        Parameters:
            type: A `SubUnitsPerUnit` that can be a member of a collection.

        Returns:
            An optional subunit for the unit of measure.
        """
        ...


trait UomAreaCollectionElement(CollectionElement, UomArea):
     """Abstract collection element conforming to the UomArea trait."""
     ...


trait UomArea(UnitOfMeasure):
    """Any of the reference quantities used to express the value of area.
    
    Common units include square length units, such as square metres and square feet.
    Other common unit include acres (in the US) and hectares.
    """
    ...


trait UomLengthCollectionElement(CollectionElement, UomLength):
     """Abstract collection element conforming to the UomLength trait."""
     ...


trait UomLength(UnitOfMeasure):
    """Any of the reference quantities used to express the value of the length, distance between two entities.
    
    Examples are the English System of feet and inches or the metric system of millimetres, centimetres and
    metres, also the System International (SI) System of Units."""
    ...


trait UomAngleCollectionElement(CollectionElement, UomAngle):
     """Abstract collection element conforming to the UomAngle trait."""
     ...


trait UomAngle(UnitOfMeasure):
    """Any of the reference quantities used to express the value of angles.
    
    In the US, the sexagesimal system of degrees, minutes and seconds is frequently used.
    The radian measurement system is also used. In other parts of the world the grad
    angle, gon, measuring system is used.
    """
    ...


trait UomAccelerationCollectionElement(CollectionElement, UomAcceleration):
     """Abstract collection element conforming to the UomAcceleration trait."""
     ...


trait UomAcceleration(UnitOfMeasure):
    """Both the unit of measure of the velocity and of the time, for example metres per second, per second."""
    ...


trait UomAngularAccelerationCollectionElement(CollectionElement, UomAngularAcceleration):
     """Abstract collection element conforming to the UomAngularAcceleration trait."""
     ...


trait UomAngularAcceleration(UnitOfMeasure):
    """Both the unit of measure of the angular velocity and of the time, for example degrees
    per second, per second.
    """
    ...


trait UomAngularSpeedCollectionElement(CollectionElement, UomAngularSpeed):
     """Abstract collection element conforming to the UomAngularSpeed trait."""
     ...


trait UomAngularSpeed(UnitOfMeasure):
    """Both the unit of measure of the angle and of the time, for example degrees per second."""
    ...


trait UomSpeedCollectionElement(CollectionElement, UomSpeed):
     """Abstract collection element conforming to the UomSpeed trait."""
     ...


trait UomSpeed(UnitOfMeasure):
    """The unit of measure of the distance and of the time, for example,
    kilometres per hour, or metres per second.
    """
    ...


trait UomCurrencyCollectionElement(CollectionElement, UomCurrency):
     """Abstract collection element conforming to the UomCurrency trait."""
     ...


trait UomCurrency(UnitOfMeasure):
    """The specific currency, such as one listed in ISO 4217."""
    ...


trait UomVolumeCollectionElement(CollectionElement, UomVolume):
     """Abstract collection element conforming to the UomVolume trait."""
     ...


trait UomVolume(UnitOfMeasure):
    """Any of the reference quantities used to express the value of volume."""
    ...


trait UomTimeCollectionElement(CollectionElement, UomTime):
     """Abstract collection element conforming to the UomTime trait."""
     ...


trait UomTime(UnitOfMeasure):
    """Any of the reference quantities used to express the value of or
    reckoning the passage of time and/or date, (e.g. seconds, minutes,
    days, months)."""
    ...


trait UomScaleCollectionElement(CollectionElement, UomScale):
     """Abstract collection element conforming to the UomScale trait."""
     ...


trait UomScale(UnitOfMeasure):
    """Any of the reference quantities used to express the value of scale, or the
    ratio between quantities with the same unit. Scale factors are often unitless.
    """
    ...


trait UomWeightCollectionElement(CollectionElement, UomWeight):
     """Abstract collection element conforming to the UomWeight trait."""
     ...


trait UomWeight(UnitOfMeasure):
    """Any of the reference quantities used to express force, such as newton."""
    ...


trait UomVelocityCollectionElement(CollectionElement, UomVelocity):
     """Abstract collection element conforming to the UomVelocity trait."""
     ...


trait UomVelocity(UnitOfMeasure):
    """Any of the reference quantities used to express the value of velocity."""
    ...


trait UomAngularVelocityCollectionElement(CollectionElement, UomAngularVelocity):
     """Abstract collection element conforming to the UomAngularVelocity trait."""
     ...


trait UomAngularVelocity(UnitOfMeasure):
    """Any of the reference quantities used to express the value of angular
    velocity. It must include an indication of which direction is
    considered positive.
    """
    ...


trait MeasureCollectionElement(CollectionElement, Measure):
     """Abstract collection element conforming to the Measure trait."""
     ...


trait Measure:
    """The result from performing the act or process of ascertaining the value
    of a characteristic of some entity.
    """

    fn value(self) -> Float64:
        """Gets the value of the measure.

        Returns:
            The value of the measure.
        """
        ...

    fn unit_of_measure(self) -> UnitOfMeasure:
        """Gets the units of the measure.

        Returns:
            The unit of the measure.
        """
        ...


trait LengthCollectionElement(CollectionElement, Length):
     """Abstract collection element conforming to the Length trait."""
     ...


trait Length(Measure):
    """The measure of distance as an integral, for example the length
    of curve, the perimeter of a polygon as the length of the boundary.
    """

    fn unit_of_measure(self) -> UomLength:
        """Gets the units of the length.

        Returns:
            The units of the length.
        """
        ...


trait DistanceCollectionElement(CollectionElement, Distance):
     """Abstract collection element conforming to the Distance trait."""
     ...


trait Distance(Length):
    """A type used for returning the separation between two points."""
    ...


trait SpeedCollectionElement(CollectionElement, Speed):
     """Abstract collection element conforming to the Speed trait."""
     ...


trait Speed(Measure):
    """The rate at which someone or something moves, generally expressed
    as distance over time.

    It is distinct from velocity in that speed can be measured along a curve.
    """

    fn time(self) -> UomTime:
        """Gets the units of measure for the time.

        Returns:
            The units of measure for the time.
        """
        ...

    fn distance(self) -> UomLength:
        """Gets the units of measure for the distance.
        
        Returns:
            The units of measure for the distance.
        """
        ...

    fn unit_of_measure(self) -> UomSpeed:
        """Gets the units of the speed.

        Returns:
            The units of the speed.
        """
        ...


trait AngleCollectionElement(CollectionElement, Angle):
     """Abstract collection element conforming to the Angle trait."""
     ...


trait Angle(Measure):
    """The amount of rotation needed to bring one line or plane into
    coincidence with another, generally measured in radians or degrees.
    """

    fn unit_of_measure(self) -> UomAngle:
        """Gets the units of the angle.
        
        Returns:
            The units of the angle.
        """
        ...


trait ScaleCollectionElement(CollectionElement, Scale):
     """Abstract collection element conforming to the Scale trait."""
     ...


trait Scale(Measure):
    """`Scale` is the ratio of one quantity to another, often unitless."""

    fn unit_of_measure(self) -> UomScale:
        """Gets the units of the length.
        
        Returns:
            The units of the length.
        """
        ...

    fn source_units(self) -> UomLength:
        """Gets the units of the source measure.
        
        Returns:
            The units of the source measure.
        """
        ...

    fn target_units(self) -> UomLength:
        """Gets the units of the target measure.

        Returns:
            The units of the target measure.
        """
        ...


trait TimeMeasureCollectionElement(CollectionElement, TimeMeasure):
     """Abstract collection element conforming to the TimeMeasure trait."""
     ...


trait TimeMeasure(Measure):
    """The designation of an instant on a selected time scale, astronomical or atomic.

    It is used in the sense of time of day.
    """

    fn unit_of_measure(self) -> UomTime:
        """Gets the units of the time.

        Returns:
            The units of the time.
        """
        ...


trait AreaCollectionElement(CollectionElement, Area):
     """Abstract collection element conforming to the Area trait."""
     ...


trait Area(Measure):
    """`Area` is the measure of the physical extent of any 2-D geometric object.
    """

    fn unit_of_measure(self) -> UomArea:
        """Gets the units of the area.

        Returns:
            The units of the area.
        """
        ...


trait VolumeCollectionElement(CollectionElement, Volume):
     """Abstract collection element conforming to the Volume trait."""
     ...


trait Volume(Measure):
    """`Volume` is the measure of the physical space of any 3-D geometric object.
    """

    fn unit_of_measure(self) -> UomVolume:
        """Gets the units of the volume.

        Returns:
            The units of the volume.
        """
        ...


trait CurrencyCollectionElement(CollectionElement, Currency):
     """Abstract collection element conforming to the Currency trait."""
     ...


trait Currency(Measure):
    """A system of money in general use in a particular country or countries."""

    fn unit_of_measure(self) -> UomCurrency:
        """Gets the units of the currency.

        Returns:
            The units of the currency.
        """
        ...


trait WeightCollectionElement(CollectionElement, Weight):
     """Abstract collection element conforming to the Weight trait."""
     ...


trait Weight(Measure):
    """The force exerted on the mass of a body by a gravitational field."""

    fn unit_of_measure(self) -> UomWeight:
        """Gets the units of the weight.

        Returns:
            The units of the weight.
        """
        ...


trait AngularSpeedCollectionElement(CollectionElement, AngularSpeed):
     """Abstract collection element conforming to the AngularSpeed trait."""
     ...


trait AngularSpeed(Measure):
    """`AngularSpeed` (often known as angular velocity) is the magnitude of the
    rate of change of angular position of a rotating body.
    
    Angular speed is always positive.
    """

    fn unit_of_measure(self) -> UomAngularSpeed:
        """Gets the units of the angular speed.

        Returns:
            The units of the angular speed.
        """
        ...


trait DirectedMeasureCollectionElement(CollectionElement, DirectedMeasure):
     """Abstract collection element conforming to the DirectedMeasure trait."""
     ...


trait DirectedMeasure:
    """The result of ascertaining the value of a characteristic of some entity 
    where direction is an essential aspectof the characteristic."""

    fn value(self) -> Vector:
        """Gets the magnitude and direction of the directed measure.

        Returns:
            The magnitude and direction of the directed measure.
        """
        ...

    fn unit_of_measure(self) -> UnitOfMeasure:
        """Gets the units of the directed measure.
        
        Returns:
            The units of the directed measure.
        """
        ...


trait VelocityCollectionElement(CollectionElement, Velocity):
     """Abstract collection element conforming to the Velocity trait."""
     ...


trait Velocity(DirectedMeasure):
    """The instantaneous rate of change of position with time.

    It is usually calculated using the simple formula, the change in position
    during a given time interval.
    """
    ...


trait AngularVelocityCollectionElement(CollectionElement, AngularVelocity):
     """Abstract collection element conforming to the AngularVelocity trait."""
     ...


trait AngularVelocity(DirectedMeasure):
    """The instantaneous rate of change of angular displacement with time."""

    fn unit_of_measure(self) -> UomSpeed:
        """Gets the units of the speed.

        Returns:
            The units of the speed.
        """
        ...

    fn time(self) -> UomTime:
        """Gets the units of the time.

        Returns:
            The units of the time.
        """
        ...

    fn angle(self) -> UomAngle:
        """Gets the units of the angle.

        Returns:
            The units of the angle.
        """
        ...


trait AccelerationCollectionElement(CollectionElement, Acceleration):
     """Abstract collection element conforming to the Acceleration trait."""
     ...


trait Acceleration(DirectedMeasure):
    """The rate of change of velocity per unit of time."""
    ...


trait AngularAccelerationCollectionElement(CollectionElement, AngularAcceleration):
     """Abstract collection element conforming to the AngularAcceleration trait."""
     ...


trait AngularAcceleration(DirectedMeasure):
    """The rate of change of angular velocity per unit of time."""
