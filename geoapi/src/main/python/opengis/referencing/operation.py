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
"""This is the operation module.

This module contains geographic metadata structures regarding referencing
system operations derived from the ISO 19111 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass

import numpy as np

from opengis.geometry.primitive import DirectPosition
from opengis.metadata.citation import Citation
from opengis.metadata.extent import Extent
from opengis.metadata.quality import PositionalAccuracy
from opengis.referencing.crs import CoordinateReferenceSystem
from opengis.referencing.datum import IdentifiedObject

# TODO: from opengis.parameter import ParameterValueGroup,
# ParameterDescriptorGroup


@dataclass(frozen=True, slots=True)
class MathTransform:
    """Transforms multi-dimensional coordinate points.

    Attributes:
        source_dimensions (int): Gets the dimension of input points.
        target_dimensions (int): Gets the dimension of output points.
        is_identity (bool): Tests whether this transform does not move any
            points.
        to_wkt (str): Returns a Well Known Text (WKT) for this object. Well
            know text are defined in extended Backus Naur form. This operation
            may fails if an object is too complex for the WKT format
            capability.

    """

    source_dimensions: int
    target_dimensions: int
    is_identity: bool
    to_wkt: str


@dataclass(frozen=True, slots=True)
class MathTransform1D(MathTransform):
    """Transforms one-dimensional coordinate points.

    Attributes:
        source_dimensions (int): Gets the dimension of input points.
        target_dimensions (int): Gets the dimension of output points.
        is_identity (bool): Tests whether this transform does not move any
            points.
        to_wkt (str): Returns a Well Known Text (WKT) for this object. Well
            know text are defined in extended Backus Naur form. This operation
            may fails if an object is too complex for the WKT format
            capability.

    """

    source_dimensions: int
    target_dimensions: int
    is_identity: bool
    to_wkt: str


@dataclass(frozen=True, slots=True)
class Formula:
    """Specification of the coordinate operation method formula.

    Attributes:
        formula (str): Formula(s) or procedure used by the operation method.
        citation (Citation): Reference to a publication giving the formula(s)
            or procedure used by the coordinate operation method.

    """

    formula: str
    citation: Citation


@dataclass(frozen=True, slots=True)
class OperationMethod(IdentifiedObject):
    """Definition of an algorithm used to perform a coordinate operation.

    Attributes:
        formula (Formula): Formula(s) or procedure used by this operation
            method. This may be a reference to a publication. Note that the
            operation method may not be analytic, in which case this attribute
            references or contains the procedure, not an analytic formula.
        parameters (...): The set of parameters.

    """

    formula: Formula
    parameters: ...


@dataclass(frozen=True, slots=True)
class CoordinateOperation(IdentifiedObject):
    """A mathematical operation on coordinates that transforms or converts
    coordinates to another coordinate reference system.

    Attributes:
        source_crs (CoordinateReferenceSystem): Returns the source CRS. The
            source CRS is mandatory for transformations only. Conversions may
            have a source CRS that is not specified here, but through
            `DerivedCRS.getBaseCRS()` instead.
        target_crs (CoordinateReferenceSystem): Returns the target CRS. The
            target CRS is mandatory for transformations only. Conversions may
            have a target CRS that is not specified here, but through
            `DerivedCRS` instead.
        operation_version (str): Version of the coordinate transformation
            (i.e. instantiation due to the stochastic nature of the
            parameters). Mandatory when describing a transformation, and
            should not be supplied for a conversion.
        coordinate_operation_accuracy (Sequence[PositionalAccuracy]):
            Estimate(s) of the impact of this operation on point accuracy.
            Gives position error estimates for target coordinates of this
            coordinate operation, assuming no errors in source coordinates.
        domain_of_validity (Extent): Area or region or timeframe in which this
            coordinate operation is valid.
        scope (str): Description of domain of usage, or limitations of usage,
            for which this operation is valid.
        math_transform (MathTransform): Gets the math transform. The math
            transform will transform positions in the source coordinate
            reference system into positions in the target coordinate reference
            system. It may be null in the case of defining conversions.

    """

    source_crs: CoordinateReferenceSystem
    target_crs: CoordinateReferenceSystem
    operation_version: str
    coordinate_operation_accuracy: tuple[PositionalAccuracy, ...]
    domain_of_validity: Extent
    scope: str
    math_transform: MathTransform


@dataclass(frozen=True, slots=True)
class SingleOperation(CoordinateOperation):
    """A parameterized mathematical operation on coordinates that transforms
    or converts coordinates to another coordinate reference system.

    Attributes:
        method (OperationMethod): Returns the operation method.
        parameter_values (...): Returns the parameter values.

    """

    method: OperationMethod
    parameter_values: ...


@dataclass(frozen=True, slots=True)
class PassThroughOperation(SingleOperation):
    """A pass-through operation specifies that a subset of a coordinate tuple
    is subject to a specific coordinate operation.

    Attributes:
        operation (SingleOperation): Returns the operation to apply on the
            subset of a coordinate tuple.
        modified_coordinates (tuple[int, ...]): Ordered sequence of positive
            integers defining the positions in a coordinate tuple of the
            coordinates affected by this pass-through operation.

    """

    operation: SingleOperation
    modified_coordinates: tuple[int, ...]


@dataclass(frozen=True, slots=True)
class Transformation(SingleOperation):
    """An operation on coordinates that usually includes a change of Datum.

    Attributes:
        source_crs (CoordinateReferenceSystem): The source CRS (never null).
        target_crs (CoordinateReferenceSystem): The target CRS (never null).
        operation_version (str): Version of the coordinate transformation
            (i.e. instantiation due to the stochastic nature of the
            parameters). This attribute is mandatory in a Transformation.

    """

    source_crs: CoordinateReferenceSystem
    target_crs: CoordinateReferenceSystem
    operation_version: str


@dataclass(frozen=True, slots=True)
class Conversion(SingleOperation):
    """An operation on coordinates that does not include any change of Datum.

    Attributes:
        source_crs (CoordinateReferenceSystem): Returns the source CRS.
            Conversions may have a source CRS that is not specified here, but
            through `DerivedCRS.getBaseCRS()` instead. The source CRS, or null
            if not available.
        target_crs (CoordinateReferenceSystem): Returns the target CRS.
            Conversions may have a target CRS that is not specified here, but
            through `DerivedCRS` instead. The target CRS, or null if not
            available.
        operation_version (None): This attribute is declared in
            `CoordinateOperation` but is not used in a conversion.
        
    """

    source_crs: CoordinateReferenceSystem
    target_crs: CoordinateReferenceSystem
    operation_version: None


def inverse_of_math_transform(math_transform: MathTransform):
    """ Creates the inverse transform of this object. This method may fail if
    the transform is not one to one.

    :return: The inverse transform.
    :rtype: MathTransform
    """
    ...


def transform_math_transform(math_transform: MathTransform,
                             pt_src: DirectPosition,
                             pt_dst: DirectPosition,
                             ) -> DirectPosition:
    """Transforms the specified ptSrc and stores the result in ptDst.

    :param pt_src: the specified coordinate point to be transformed.
    :type pt_src: DirectPosition
    :param pt_dst: the specified coordinate point that stores the result of
        transforming ptSrc, or null.
    :type pt_dst: DirectPosition
    :return: the coordinate point after transforming ptSrc and storing the
        result in ptDst, or a newly created point if ptDst was null.
    :rtype: DirectPosition
    """
    return None


def transform_list_of_math_transform(math_transform: MathTransform,
                                     src_pts: np.ndarray,
                                     src_off: int,
                                     dst_pts: np.ndarray,
                                     dst_off: int,
                                     num_pts: int,
                                     ):
    """Transforms a list of coordinate point ordinal values. This method is
    provided for efficiently transforming many points. The supplied array of
    ordinal values will contain packed ordinal values. For example, if the
    source dimension is 3, then the ordinals will be packed in this order:
    (x0,y0,z0, x1,y1,z1 ...).

    :param src_pts: the array containing the source point coordinates.
    :type src_pts: numpy.ndarray
    :param src_off: the offset to the first point to be transformed in the
        source array.
    :type src_off: int
    :param dst_pts: the array into which the transformed point coordinates are
        returned. May be the same as srcPts
    :type dst_pts: numpy.ndarray
    :param dst_off: the offset to the location of the first transformed point
        that is stored in the destination
    :type dst_off: int
    :param num_pts: the number of point objects to be transformed.
    :type num_pts: int
    """
    pass


def derivative_of_math_transform(math_transform: MathTransform,
                                 point: DirectPosition,
                                 ) -> np.ndarray:
    """Gets the derivative of this transform at a point. The derivative is the
    matrix of the non-translating portion of the approximate affine map at the
    point. The matrix will have dimensions corresponding to the source and
    target coordinate systems.

    :param point: The coordinate point where to evaluate the derivative. Null
        value is accepted only if the derivative is the same everywhere (e.g.,
        with affine transforms). But most map projection will requires a
        non-null value.
    :type point: DirectPosition
    :return: The derivative at the specified point (never null).
    :rtype: numpy.ndarray
    """
    return None


def inverse_of_math_tranform_1d(math_tranform_1d: MathTransform1D):
    """Creates the inverse transform of this object.

    :return: The inverse transform.
    :rtype: MathTransform1D
    """
    pass


def transform_value_of_math_tranform_1d(math_tranform_1d: MathTransform1D,
                                        value: float,
                                        ) -> float:
    """Transforms the specified value.

    :param value: The value to transform.
    :type value: float
    :return: the transformed value.
    :rtype: float
    """
    return None


def derivative_of_math_tranform_1d_(math_tranform_1d: MathTransform1D,
                                    value: float
                                    ) -> float:
    """Gets the derivative of this function at a value. The derivative is the
    1x1 matrix of the non-translating portion of the approximate affine map at
    the value.

    :param value: The value where to evaluate the derivative.
    :type value: float
    :return: The derivative at the specified point.
    :rtype: float
    """
    return None
