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
"""This is the `primitive` module.

This module contains primitive geometry data structures derived from
the ISO 19107 international standard.
"""

# author: OGC Topic 11 (for abstract model and documentation), David Meaux

from collections import Optional, KeyElement

from opengis.referencing.crs import (
    CoordinateReferenceSystem,
    CoordinateSystem,
    )
from opengis.util.measure import (
    AngleCollectionElement,
    LengthCollectionElement,
    )


trait Direction():
     """Abstract trait from which all types of direction inherit."""
     ...


@value
struct CurveRelativeDirection(
    Direction,
    CollectionElement,
    KeyElement,
    Representable,
    Stringable,
    Writable,
    ):
    """`CurveRelativeDirection` refers to the vectors associated with
    a curve.

    Some common vector directions are:

        - tangent, the direction in which the curve points;
        - the inverse tangent, i.e. the opposite of the tangent;
        - the binormal, the direction towards the center of curvature, i.e.
            the inside of the curve;
        - the inverse binormal (reverseBiNormal), the opposite of the
            binormal, on the outside of the curve;
        - leftNormal, to the left of the tangent;
        - rightNormal, to the right of the tangent;
        - upNormal, relative to the reference surface;
        - downNormal, the opposite of upNormal.

    These values can be used to extend or replace the 2D directions
    of `RelativeDirection`.
    """

    alias type = String
    var value: Self.type
    """The underlying storage value for the CurveRelativeDirection value."""

    alias TANGENT = CurveRelativeDirection("tangent")
    alias REVERSE_TANGENT = CurveRelativeDirection("reverseTangent")
    alias NORMAL = CurveRelativeDirection("normal")
    alias REVERSE_NORMAL = CurveRelativeDirection("reverseNormal")
    alias BINORMAL = CurveRelativeDirection("biNormal")
    alias REVERSE_BINORMAL = CurveRelativeDirection("reverseBiNormal")
    alias LEFT_NORMAL = CurveRelativeDirection("leftNormal")
    alias RIGHT_NORMAL = CurveRelativeDirection("rightNormal")
    alias UP_NORMAL = CurveRelativeDirection("upNormal")
    alias DOWN_NORMAL = CurveRelativeDirection("downNormal")

    @always_inline
    fn __init__(out self, *, other: Self):
        """Copy this CurveRelativeDirection.

        Args:
            other: The CurveRelativeDirection to copy.
        """
        self = other

    @staticmethod
    fn _from_str(str: String) -> CurveRelativeDirection:
        """Construct a CurveRelativeDirection from a string.

        Args:
            str: The name of the CurveRelativeDirection.
        """
        if str.startswith(String("CurveRelativeDirection.")):
            return Self._from_str(str.removeprefix("CurveRelativeDirection."))
        elif str == String("tangent"):
            return CurveRelativeDirection.TANGENT
        elif str == String("reverseTangent"):
            return CurveRelativeDirection.REVERSE_TANGENT
        elif str == String("normal"):
            return CurveRelativeDirection.NORMAL
        elif str == String("reverseNormal"):
            return CurveRelativeDirection.REVERSE_NORMAL
        elif str == String("biNormal"):
            return CurveRelativeDirection.BINORMAL
        elif str == String("reverseBiNormal"):
            return CurveRelativeDirection.REVERSE_BINORMAL
        elif str == String("leftNormal"):
            return CurveRelativeDirection.LEFT_NORMAL
        elif str == String("rightNormal"):
            return CurveRelativeDirection.RIGHT_NORMAL
        elif str == String("upNormal"):
            return CurveRelativeDirection.UP_NORMAL
        elif str == String("downNormal"):
            return CurveRelativeDirection.DOWN_NORMAL

    @no_inline
    fn __str__(self) -> String:
        """Gets the name of the CurveRelativeDirection.

        Returns:
            The name of the CurveRelativeDirection.
        """

        return String.write(self)

    @no_inline
    fn write_to[W: Writer](self, mut writer: W):
        """
        Formats this CurveRelativeDirection to the provided Writer.

        Parameters:
            W: A type conforming to the Writable trait.

        Args:
            writer: The object to write to.
        """

        return writer.write(self.value)

    @always_inline("nodebug")
    fn __repr__(self) -> String:
        """Gets the representation of the CurveRelativeDirection e.g. `"CurveRelativeDirection.TANGENT"`.

        Returns:
            The representation of the CurveRelativeDirection.
        """
        return String.write("CurveRelativeDirection.", self)

    @always_inline("nodebug")
    fn __is__(self, rhs: CurveRelativeDirection) -> Bool:
        """Compares one CurveRelativeDirection to another for equality.

        Args:
            rhs: The CurveRelativeDirection to compare against.

        Returns:
            True if the CurveRelativeDirections are the same and False otherwise.
        """
        return self == rhs

    @always_inline("nodebug")
    fn __isnot__(self, rhs: CurveRelativeDirection) -> Bool:
        """Compares one CurveRelativeDirection to another for inequality.

        Args:
            rhs: The CurveRelativeDirection to compare against.

        Returns:
            True if the CurveRelativeDirections are the same and False otherwise.
        """
        return self != rhs

    @always_inline("nodebug")
    fn __eq__(self, rhs: CurveRelativeDirection) -> Bool:
        """Compares one CurveRelativeDirection to another for equality.

        Args:
            rhs: The CurveRelativeDirection to compare against.

        Returns:
            True if the CurveRelativeDirections are the same and False otherwise.
        """
        return self.value == rhs.value

    @always_inline("nodebug")
    fn __ne__(self, rhs: CurveRelativeDirection) -> Bool:
        """Compares one CurveRelativeDirection to another for inequality.

        Args:
            rhs: The CurveRelativeDirection to compare against.

        Returns:
            False if the CurveRelativeDirections are the same and True otherwise.
        """
        return self.value != rhs.value

    fn __hash__(self) -> UInt:
        """Return a 64-bit hash for this `CurveRelativeDirection` value.

        Returns:
            A 64-bit integer hash of this `CurveRelativeDirection` value.
        """
        return hash(self.value)    


@value
struct FixedDirection(
    Direction,
    CollectionElement,
    KeyElement,
    Representable,
    Stringable,
    Writable,
    ):
    """Enumerates common potential fixed reference directions
    for azimuth, generally used in reference to the globe, a map,
    a coordinate system or a grid. Common values include true north or south,
    magnetic north or south, grid north or south (reference to a grid
    or projection).
    """

    alias type = String
    var value: Self.type
    """The underlying storage value for the FixedDirection value."""

    alias TRUE_NORTH = FixedDirection("trueNorth")
    alias MAGNETIC_NORTH = FixedDirection("magneticNorth")
    alias GRID_NORTH = FixedDirection("gridNorth")
    alias TRUE_SOUTH = FixedDirection("trueSouth")
    alias MAGNETIC_SOUTH = FixedDirection("magneticsouth")
    alias GRID_SOUTH = FixedDirection("gridsouth")

    @always_inline
    fn __init__(out self, *, other: Self):
        """Copy this FixedDirection.

        Args:
            other: The FixedDirection to copy.
        """
        self = other

    @staticmethod
    fn _from_str(str: String) -> FixedDirection:
        """Construct a FixedDirection from a string.

        Args:
            str: The name of the FixedDirection.
        """
        if str.startswith(String("FixedDirection.")):
            return Self._from_str(str.removeprefix("FixedDirection."))
        elif str == String("trueNorth"):
            return FixedDirection.TRUE_NORTH
        elif str == String("magneticNorth"):
            return FixedDirection.MAGNETIC_NORTH
        elif str == String("gridNorth"):
            return FixedDirection.GRID_NORTH
        elif str == String("trueSouth"):
            return FixedDirection.TRUE_SOUTH
        elif str == String("magneticsouth"):
            return FixedDirection.MAGNETIC_SOUTH
        elif str == String("gridsouth"):
            return FixedDirection.GRID_SOUTH

    @no_inline
    fn __str__(self) -> String:
        """Gets the name of the FixedDirection.

        Returns:
            The name of the FixedDirection.
        """

        return String.write(self)

    @no_inline
    fn write_to[W: Writer](self, mut writer: W):
        """
        Formats this FixedDirection to the provided Writer.

        Parameters:
            W: A type conforming to the Writable trait.

        Args:
            writer: The object to write to.
        """

        return writer.write(self.value)

    @always_inline("nodebug")
    fn __repr__(self) -> String:
        """Gets the representation of the FixedDirection e.g. `"FixedDirection.TRUE_NORTH"`.

        Returns:
            The representation of the FixedDirection.
        """
        return String.write("FixedDirection.", self)

    @always_inline("nodebug")
    fn __is__(self, rhs: FixedDirection) -> Bool:
        """Compares one FixedDirection to another for equality.

        Args:
            rhs: The FixedDirection to compare against.

        Returns:
            True if the FixedDirections are the same and False otherwise.
        """
        return self == rhs

    @always_inline("nodebug")
    fn __isnot__(self, rhs: FixedDirection) -> Bool:
        """Compares one FixedDirection to another for inequality.

        Args:
            rhs: The FixedDirection to compare against.

        Returns:
            True if the FixedDirections are the same and False otherwise.
        """
        return self != rhs

    @always_inline("nodebug")
    fn __eq__(self, rhs: FixedDirection) -> Bool:
        """Compares one FixedDirection to another for equality.

        Args:
            rhs: The FixedDirection to compare against.

        Returns:
            True if the FixedDirections are the same and False otherwise.
        """
        return self.value == rhs.value

    @always_inline("nodebug")
    fn __ne__(self, rhs: FixedDirection) -> Bool:
        """Compares one FixedDirection to another for inequality.

        Args:
            rhs: The FixedDirection to compare against.

        Returns:
            False if the FixedDirections are the same and True otherwise.
        """
        return self.value != rhs.value

    fn __hash__(self) -> UInt:
        """Return a 64-bit hash for this `FixedDirection` value.

        Returns:
            A 64-bit integer hash of this `FixedDirection` value.
        """
        return hash(self.value)    


@value
struct RelativeDirection(
    Direction,
    CollectionElement,
    KeyElement,
    Representable,
    Stringable,
    Writable,
    ):
    """Enumerates common potential relative reference directions for azimuth,
    generally used in reference to a moving vehicle. Common values include front, rear,
    port (90° left) or starboard (90° right).
    """

    alias type = String
    var value: Self.type
    """The underlying storage value for the RelativeDirection value."""
    
    alias FORE_FOREWARD = RelativeDirection("fore/forward")
    alias AFT_BACKWARD = RelativeDirection("aft/backward")
    alias PORT_LEFT = RelativeDirection("port/left")
    alias STARBOARD_RIGHT = RelativeDirection("starboard/right")

    @always_inline
    fn __init__(out self, *, other: Self):
        """Copy this RelativeDirection.

        Args:
            other: The RelativeDirection to copy.
        """
        self = other

    @staticmethod
    fn _from_str(str: String) -> RelativeDirection:
        """Construct a RelativeDirection from a string.

        Args:
            str: The name of the RelativeDirection.
        """
        if str.startswith(String("RelativeDirection.")):
            return Self._from_str(str.removeprefix("RelativeDirection."))
        elif str == String("fore/forward"):
            return RelativeDirection.FORE_FOREWARD
        elif str == String("aft/backward"):
            return RelativeDirection.AFT_BACKWARD
        elif str == String("port/left"):
            return RelativeDirection.PORT_LEFT
        elif str == String("starboard/right"):
            return RelativeDirection.STARBOARD_RIGHT

    @no_inline
    fn __str__(self) -> String:
        """Gets the name of the RelativeDirection.

        Returns:
            The name of the RelativeDirection.
        """

        return String.write(self)

    @no_inline
    fn write_to[W: Writer](self, mut writer: W):
        """Formats this RelativeDirection to the provided Writer.

        Parameters:
            W: A type conforming to the Writable trait.

        Args:
            writer: The object to write to.
        """

        return writer.write(self.value)

    @always_inline("nodebug")
    fn __repr__(self) -> String:
        """Gets the representation of the RelativeDirection e.g. `"RelativeDirection.TRUE_NORTH"`.

        Returns:
            The representation of the RelativeDirection.
        """
        return String.write("RelativeDirection.", self)

    @always_inline("nodebug")
    fn __is__(self, rhs: RelativeDirection) -> Bool:
        """Compares one RelativeDirection to another for equality.

        Args:
            rhs: The RelativeDirection to compare against.

        Returns:
            True if the RelativeDirections are the same and False otherwise.
        """
        return self == rhs

    @always_inline("nodebug")
    fn __isnot__(self, rhs: RelativeDirection) -> Bool:
        """Compares one RelativeDirection to another for inequality.

        Args:
            rhs: The RelativeDirection to compare against.

        Returns:
            True if the RelativeDirections are the same and False otherwise.
        """
        return self != rhs

    @always_inline("nodebug")
    fn __eq__(self, rhs: RelativeDirection) -> Bool:
        """Compares one RelativeDirection to another for equality.

        Args:
            rhs: The RelativeDirection to compare against.

        Returns:
            True if the RelativeDirections are the same and False otherwise.
        """
        return self.value == rhs.value

    @always_inline("nodebug")
    fn __ne__(self, rhs: RelativeDirection) -> Bool:
        """Compares one RelativeDirection to another for inequality.

        Args:
            rhs: The RelativeDirection to compare against.

        Returns:
            False if the RelativeDirections are the same and True otherwise.
        """
        return self.value != rhs.value

    fn __hash__(self) -> UInt:
        """Return a 64-bit hash for this `RelativeDirection` value.

        Returns:
            A 64-bit integer hash of this `RelativeDirection` value.
        """
        return hash(self.value)


@value
struct Rotation(
    CollectionElement,
    KeyElement,
    Representable,
    Stringable,
    Writable,
    ):
    """Enumerates the two potential directions of rotation for an
    angular measurement, clockwise and anti-clockwise. These directions
    of rotation are considered as seen from above the reference surface.
    """

    alias type = String
    var value: String
    """The underlying storage value for the Rotation value."""

    alias CLOCKWISE_RIGHT = Rotation("clockwise/right")
    alias COUNTER_CLOCKWISE_LEFT = Rotation("counter-clockwise/left")

    @always_inline
    fn __init__(out self, *, other: Self):
        """Copy this Rotation.

        Args:
            other: The Rotation to copy.
        """
        self = other

    @staticmethod
    fn _from_str(str: String) -> Rotation:
        """Construct a Rotation from a string.

        Args:
            str: The name of the Rotation.
        """
        if str.startswith(String("Rotation.")):
            return Self._from_str(str.removeprefix("Rotation."))
        elif str == String("clockwise/right"):
            return Rotation.CLOCKWISE_RIGHT
        elif str == String("counter-clockwise/left"):
            return Rotation.COUNTER_CLOCKWISE_LEFT

    @no_inline
    fn __str__(self) -> String:
        """Gets the name of the Rotation.

        Returns:
            The name of the Rotation.
        """

        return String.write(self)

    @no_inline
    fn write_to[W: Writer](self, mut writer: W):
        """
        Formats this Rotation to the provided Writer.

        Parameters:
            W: A type conforming to the Writable trait.

        Args:
            writer: The object to write to.
        """

        return writer.write(self.value)

    @always_inline("nodebug")
    fn __repr__(self) -> String:
        """Gets the representation of the Rotation e.g. `"Rotation.TRUE_NORTH"`.

        Returns:
            The representation of the Rotation.
        """
        return String.write("Rotation.", self)

    @always_inline("nodebug")
    fn __is__(self, rhs: Rotation) -> Bool:
        """Compares one Rotation to another for equality.

        Args:
            rhs: The Rotation to compare against.

        Returns:
            True if the Rotations are the same and False otherwise.
        """
        return self == rhs

    @always_inline("nodebug")
    fn __isnot__(self, rhs: Rotation) -> Bool:
        """Compares one Rotation to another for inequality.

        Args:
            rhs: The Rotation to compare against.

        Returns:
            True if the Rotations are the same and False otherwise.
        """
        return self != rhs

    @always_inline("nodebug")
    fn __eq__(self, rhs: Rotation) -> Bool:
        """Compares one Rotation to another for equality.

        Args:
            rhs: The Rotation to compare against.

        Returns:
            True if the Rotations are the same and False otherwise.
        """
        return self.value == rhs.value

    @always_inline("nodebug")
    fn __ne__(self, rhs: Rotation) -> Bool:
        """Compares one Rotation to another for inequality.

        Args:
            rhs: The Rotation to compare against.

        Returns:
            False if the Rotations are the same and True otherwise.
        """
        return self.value != rhs.value

    fn __hash__(self) -> UInt:
        """Return a 64-bit hash for this `Rotation` value.

        Returns:
            A 64-bit integer hash of this `Rotation` value.
        """
        return hash(self.value)


trait DirectPositionCollectionElement(CollectionElement, DirectPosition):
    """Abstract collection element conforming to the DirectPosition trait."""
    ...


trait DirectPosition:
    """Holds the coordinates for a position within some coordinate reference system."""

    fn coordinate[dtype: DType](self) -> Tuple[SIMD[dtype, 1]]:
        """A sequence of real numbers that hold the coordinate values for this
        position in the specified reference system.
        """
        ...

    fn coordinate_reference_system(self) -> CoordinateReferenceSystem:
        """The coordinate reference system in which the coordinate tuple is given."""
        ...

    fn dimension(self) -> Int:
        """The length of coordinate sequence (the number of entries)."""
        ...


trait EnvelopeCollectionElement(CollectionElement, Envelope):
     """Abstract collection element conforming to the Envelope trait."""
     ...


trait Envelope:
    """An `Envelope` is often referred to as a box or rectangle defining a minimum
    enclosing area. Whatever its size, an `Envelope` can be represented
    unambiguously as two `DirectPositions` (coordinate points).
    
    To code an`Envelope`, you simply need to code these two points. This is consistent
    with all the coordinate systems in ISO 19107:2019. It should be remembered
    that, even if the CoordinateSystem is purely spatial without being
    globally bijective, the coordinate may not be valid in the associated
    coordinate system."""

    fn lower_corner(self) -> DirectPosition:
        """The “lowerCorner” of an Envelope is a coordinate position consisting
        of all the minimum coordinates for each dimension, for all points
        within the Envelope.

        Math: For each coordinate offset, the corresponding lower corner
        offset is the minimum of that offset in all direct positions of the
        original geometry, and the corresponding upper corner offset is the
        maximum of those same direct positions.
        """
        ...

    fn upper_corner(self) -> DirectPosition:
        """The “upperCorner” of an Envelope is a coordinate position consisting
        of all the maximum coordinates for each dimension, for all points
        within the Envelope.

        Offset in all direct positions of the original geometry.
        """
        ...


trait ReferenceDirectionCollectionElement(CollectionElement, ReferenceDirection):
     """Abstract collection element conforming to the ReferenceDirection trait."""
     ...


trait ReferenceDirection(Direction):
    """The ReferenceDirection interface is empty, but must be “implemented” by
    any data type that can represent a direction (or tangent unit vector) at
    a point. This leads to a circular, but valid, possibly recursive
    definition for the Bearing data type.
    """
    ...


trait BearingCollectionElement(CollectionElement, Bearing):
     """Abstract collection element conforming to the Bearing trait."""
     ...


trait Bearing:
    """The Bearing data type indicates a direction.
    
    The azimuth can take one of two forms forms:

    - a set of angles, one of which is a plane azimuth and the second a
      measure of altitude (positive above the horizontal, negative below
      the horizon). above the horizontal, negative below the horizon),
      essentially by creating a spherical spherical coordinate system;

    - a directional vector derived from the coordinate system at the
      initial point, a unit vector with the direction associated with
      the set of angles.

    Since the two types of measurement are identical, the azimuth values
    are the same, but the interpretations will depend on the usage (usually
    a reference direction, the offset “0”). will depend on usage (usually a
    reference direction, offset “0”, and a direction of rotation, clockwise).

    The value of the Bearing data type can only be valid at the point from
    which the measurement is taken. The common “parallel” transformation of
    vectors from one point to another is only valid if the
    `GeometricReferenceSurface` used is planar (i.e. Cartesian and, therefore,
    Euclidean). The fundamental problem is that the sphere has no universally
    valid 2D world coordinate system for its tangent spaces. Using a fixed
    direction reference such as “true north” does allow some translation,
    however, if the reference exists and is unique at a given position.
    For example, north does not exist at the North Pole and is not unique at
    the South Pole.

    Azimuths can be measured in both directions, as absolute values (such as
    true north, see azimuth) or relative (such as “before” or “after”)."""

    fn __init__[reference_type: Direction](
        out self,
        v: Vector,
        reference: reference_type,
        rotation: Rotation,
    ):
        """The default azimuth constructor considers a non-zero vector at a
        point and creates an azimuth at that point, with the classic default
        values for the most common fixed azimuth.
        """
        ...

    fn angle[type: AngleCollectionElement](self) -> Tuple[type]:
        """In this variant of Bearing, generally used for 2D coordinate systems,
        the first angle (azimuth) is measured from a coordinate axis (usually
        north) in a clockwise direction, parallel to the tangent plane of the
        reference surface. Given two angles, the second angle (altitude)
        generally represents the angle above (for positive angles) or below
        (for negative angles) a local plane parallel to the tangent plane
        of the reference surface.

        NOTE: 1 or more angles should be returned.
        """
        ...

    fn direction[type: VectorCollectionElement](self) -> Optional[type]:
        """In this variant of Bearing, generally used for 3D coordinate systems,
        the direction is expressed as an arbitrary vector in the
        coordinate system.
        """
        ...

    fn reference(self) -> ReferenceDirection:
        """The reference attribute is the direction from which the azimuth is
        measured, i.e. the direction of a positive measurement. Most systems
        can use a negative number to express a measurement opposite to the
        default rotation.
        """
        ...

    fn rotation(self) -> Rotation:
        """The rotation attribute specifies the direction from which the azimuth
        is measured.
        """
        ...


trait VectorCollectionElement(CollectionElement, Vector):
    """Abstract collection element conforming to the Vector trait."""
    ...


trait Vector:
    """The common “vector” in Euclidean spaces can be translated to any point
    in space because the flat nature of Euclidean space has a universal
    coordinate system that works at any “starting” point of a vector.

    The Vector data type in this document must be associated with a point
    on the GeometricReferenceSurface, which must be well defined.
    The directional parts of the vector must also specify the
    “starting position” of the vector. Where the coordinate system performs
    well, the generating family of vectors in tangent space is represented
    in 3D geocentric space by the tangents to the coordinate functions.
    For example, in a latitude-longitude system, the unit vectors tangent
    to the constant longitude curves, as well as to the latitude curves,
    represent a local tangent space basis, except for the poles where the
    longitude function has a zero tangent. longitude function has a zero
    tangent at the pole. If (lat, long = (dφ, dλ), then the symbols (dφ, dλ)
    are the differentials of the two-coordinate functions represented by the
    tangents in the direction of increasing φ, respectively λ, and represent
    a basis for local tangent spaces."""

    fn __init__[coordinate_type: DType,
    coordinate_size: Int,
    direction_type: BearingCollectionElement,
    length_type: LengthCollectionElement](
        out self,
        position: DirectPosition,
        coordinates: Optional[Tuple[Float64]],
        direction: Optional[direction_type],
        length: Optional[length_type],
    ):
        """The constructor vector creates a vector with the given offsets or
        direction and length at the specified direct position, in the
        coordinate space of the direct position.

        NOTE: if `coordinates` is not specified then `direction` and `length`
        must be specified. Likewise if `direction` or `length` is not specified
        then `coordinates` must be specified.
        """
        ...

    fn origin(self) -> DirectPosition:
        """The origin attribute is the location of the point on the
        `GeometricReferenceSurface` for which the vector is a tangent.
        The direct position is associated with the coordinate system.
        This determines the coordinate system for the vector. The spatial
        dimension of the direct position determines the dimension of
        the vector.
        """
        ...

    fn offsets(self) -> Tuple[Float64]:
        """The offset attribute uses the direct position coordinate system and
        represents the local tangent vector vector in the local
        coordinate differentials.

        Example:
            If the Euclidean (E²) plane is used, then the `DirectPosition`
            is a pair of coordinates (x, y) and the the vector consists of the
            differentials in both directions. Consequently, the offset is of
            length 2 and has a coordinate base of (dx, dy).
        """
        ...

    fn dimension(self) -> Int:
        """The dimension attribute is the dimension of the origin and,
        consequently, the dimension of the tangent space of the vector.
        """
        ...

    fn coordinate_system(self) -> CoordinateSystem:
        """The `coordinate_system` attribute is the origin system and, therefore,
        determines the coordinates of the local tangent space in which the
        vector exists.
        """
        ...

    fn cross_product(self, v2: Vector) -> Vector:
        """The cross product is a third vector perpendicular to the other two.
        If the vector space is only two-dimensional, the cross product gives
        an oriented intensity and not a vector.
        """
        ...

    fn dot_product(self, v2: Vector) -> Float64:
        """The dot product operation yields a real value which is the sum of the
        products of the corresponding coefficients coefficients of the
        two vectors.
        """
        ...


trait TransfiniteSetOfDirectPositionsCollectionElement(CollectionElement, TransfiniteSetOfDirectPositions):
     """Abstract collection element conforming to the TransfiniteSetOfDirectPositions trait."""
     ...


trait TransfiniteSetOfDirectPositions:
    """Many geometry operations are based on simple set theory, which does not
    vary according to the cardinality of the sets concerned. Unfortunately,
    the term “set” in most programming languages refers to a finite collection
    of objects or object identities. The abstract class
    `TransfiniteSetOfDirectPositions` represents set-theoretic operations that
    cannot always be tested by simple enumeration techniques for sets with a
    small number of elements.

    A `TransfiniteSetOfDirectPositions` can be very large in terms of its
    number of elements (limited only to a finite number by the use of
    finite-precision numerical computation). The collection

    {x ∈ R |0 ≤ x ≤ 1}

    is logically infinite. On a digital computer, it may consist of only
    2^64 objects. That's a lot, but it's not infinite. The term “transfinite”
    indicates that nothing on a digital computer is truly infinite, but that
    doesn't prevent it from being too big to process in a reasonable
    time interval."""

    fn contains(self, pt: DirectPosition) -> Bool:
        """Determine whether a particular `DirectPosition` is part of the set.
        Each type of `Geometry` interface will have to implement this with
        the limitations of a computing platform with limited precision.

        Let À be a transfinite set of direct positions. Then we have:
            [x ∈ A] ⇒ [A.contains(x) = TRUE]
        """
        ...


trait GeometryCollectionElement(CollectionElement, Geometry):
     """Abstract collection element conforming to the Geometry trait."""
     ...


trait Geometry(TransfiniteSetOfDirectPositions):
    """Geometry is the base trait of the geometric object taxonomy, supporting
    interfaces common to all geographically referenced geometric objects.
    Instances of `Geometry` are sets of `DirectPosition` attributes in a
    particular reference coordinate system. `Geometry` can be thought of as an
    infinite set of points that satisfies the set operation interfaces for a
    set of direct positions constituting a `TransfiniteSetOfDirectPositions`
    (essentially a set defined by a `bool` “isIn” operator). As an infinite
    collection trait cannot be implemented directly, a `bool` inclusion test
    must be provided by the `Geometry` interface. This document focuses on
    vector geometry classes, but future developments may use `Geometry` as a
    base trait without modification.

    NOTE 1: As a type, `Geometry` has neither a well-defined default state
    nor a value representation as a data type. As far as these are concerned,
    instantiated subclasses of `Geometry` do.

    NOTE 2: In its current state this abstract trait is a partial
    implementation of the `Geometry` interface described in ISO 19107:2019."""

    fn is_empty(self) -> Bool:
        """The boolean `is_empty` attribute indicates that the geometric object
        instance is the empty set. Since the empty set is unique, all empty
        objects are “spatially equivalent” to any other empty object.
        As soon as an instance is known to be empty (`self.is_empty = True`),
        the rest of the information in the object becomes redundant until the
        boolean value `self.is_empty` is reset to `False`.

        If the `is_empty` attribute is set to `True`, the object is locked
        until the `is_empty` attribute is set to `False`. Essentially, setting
        the `is_empty` attribute to `True` changes the behavior (as defined by
        its class) of the object to match the `Empty` class, defined in
        ISO 19107:2019 section 6.4.10.
        """
        ...

    fn coordinate_reference_system(self) -> CoordinateReferenceSystem:
        """The coordinate reference system in which the coordinate geometry
        is given.
        """
        ...


trait PrimitiveCollectionElement(CollectionElement, Primitive):
    """Abstract collection element conforming to the Primitive trait."""
    ...


trait Primitive(Geometry):
    """A geometry primitive is a related geometric object with a uniform
    dimension at each interior point. Depending on the spatial dimension
    of the coordinate space, primitives are made up of the subclasses Point,
    Curve, Surface and Solid.
    """

    fn segment[type: PrimitiveCollectionElement](self) -> Optional[Tuple[type]]:
        """The `segment` role lists the components (smallest primitives of the
        same dimension contained) of Primitive, each of which defines aGeometry
        portion of the Primitive. The order of the segments is the order in
        which they are used to define the Primitive.
        """
        ...


trait PointCollectionElement(CollectionElement, Point):
     """Abstract collection element conforming to the Point trait."""
     ...


trait Point(Primitive):
    """A Geometry Point instance is a unique location given by a direct position."""

    fn position(self) -> DirectPosition:
        """The `position` attribute gives the location of the `Point` in its
        reference system. The distinction between `Point` and `DirectPosition`
        lies in the fact that `Point` as an object instance has an identity
        provided by the system, whereas a `DirectPosition` instance is a data
        type whose only identity is its own value.
        """
        ...

    fn boundary(self) -> Geometry:
        """The “boundary” attribute gives the Point's boundary in the form of a
        `Geometry` reference system. Since a point's boundary is always empty,
        the boundary object will always have the value is_empty = TRUE.
        """
        ...

    fn bearing(self, to_point: DirectPosition) -> Bearing:
        """The `bearing` operation is similar to `vector_to_point` without the
        distance information in the vector. It is essentially a constructor
        for `Bearing` based on this point and a target point.
        """
        ...

    fn point_at_distance(self, bearing: Vector) -> DirectPosition:
        """The `point_at_distance` operation will return a `DirectPosition`
        attribute given a vector in space tangent to the point whose direction
        determines a geodesic curve that intersects this `DirectPosition` at
        a distance equal to the length of the vector. This operation solves
        the first geodesic problem.
        """
        ...

    fn vector_to_point(self, to_point: DirectPosition) -> Vector:
        """The `vector_to_point` operation will return a vector in space tangent
        to the point whose direction determines a geodesic curve that
        intersects `to_point` at a distance equal to the length of the vector.
        This operation solves the second geodesic problem.
        """
        ...
