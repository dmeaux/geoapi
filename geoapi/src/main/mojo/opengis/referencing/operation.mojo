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
"""This is the operation module.

This module contains geographic metadata structures regarding referencing
system operations derived from the ISO 19111 international standard.
"""

from opengis.referencing.datum import IdentifiedObject
from opengis.referencing.crs import CoordinateReferenceSystem
from opengis.metadata.quality import PositionalAccuracy
from opengis.metadata.extent import Extent
from opengis.metadata.citation import Citation
from opengis.geometry.primitive import DirectPosition


trait Formula:
    """
    Specification of the coordinate operation method formula.
    """

    fn formula(self) -> String:
        """
        Formula(s) or procedure used by the operation method.
        """
        ...

    fn citation(self) -> Citation:
        """
        Reference to a publication giving the formula(s) or procedure used by the coordinate operation method.
        """
        ...


trait OperationMethod(IdentifiedObject):
    """
    Definition of an algorithm used to perform a coordinate operation.
    """

    fn formula(self) -> Formula:
        """
        Formula(s) or procedure used by this operation method. This may be a reference to a publication.
        Note that the operation method may not be analytic, in which case this attribute references or
        contains the procedure, not an analytic formula.
        """
        ...

    fn parameters(self):
        """
        The set of parameters.
        """
        ...


trait CoordinateOperation(IdentifiedObject):
    """
    A mathematical operation on coordinates that transforms or converts coordinates to another coordinate reference
    system.
    """

    fn source_crs(self) -> CoordinateReferenceSystem:
        """
        Returns the source CRS. The source CRS is mandatory for transformations only.
        Conversions may have a source CRS that is not specified here, but through
        `DerivedCRS.getBaseCRS()` instead.
        """
        ...

    fn target_crs(self) -> CoordinateReferenceSystem:
        """
        Returns the target CRS. The target CRS is mandatory for transformations only.
        Conversions may have a target CRS that is not specified here, but through
        `DerivedCRS` instead.
        """
        ...

    fn operation_version(self) -> String:
        """
        Version of the coordinate transformation (i.e., instantiation due to the stochastic nature of the parameters).
        Mandatory when describing a transformation, and should not be supplied for a conversion.
        """
        ...

    fn coordinate_operation_accuracy(self) -> Sequence[PositionalAccuracy]:
        """
        Estimate(s) of the impact of this operation on point accuracy. Gives position error estimates for target
        coordinates of this coordinate operation, assuming no errors in source coordinates.
        """
        ...

    fn domain_of_validity(self) -> Extent:
        """
        Area or region or timeframe in which this coordinate operation is valid.
        """
        ...

    fn scope(self) -> String:
        """
        Description of domain of usage, or limitations of usage, for which this operation is valid.
        """
        ...


trait SingleOperation(CoordinateOperation):
    """
    A parameterized mathematical operation on coordinates that transforms or converts coordinates to another coordinate
    reference system.
    """

    fn method(self) -> OperationMethod:
        """
        Returns the operation method.
        """
        ...

    fn parameter_values(self):
        """
        Returns the parameter values.
        """
        ...


trait PassThroughOperation(SingleOperation):
    """
    A pass-through operation specifies that a subset of a coordinate tuple is subject to a specific coordinate
    operation.
    """

    fn operation(self) -> SingleOperation:
        """
        Returns the operation to apply on the subset of a coordinate tuple.
        """
        ...

    fn modified_coordinates(self) -> Sequence[int]:
        """
        Ordered sequence of positive integers defining the positions in a coordinate tuple of the coordinates affected
        by this pass-through operation.
        """
        ...


trait Transformation(SingleOperation):
    """
    An operation on coordinates that usually includes a change of Datum.
    """

    fn source_crs(self) -> CoordinateReferenceSystem:
        """Returns the source CRS.
        """
        ...

    fn target_crs(self) -> CoordinateReferenceSystem:
        """
        Returns the target CRS.
        """
        ...

    fn operation_version(self) -> String:
        """
        Version of the coordinate transformation (i.e., instantiation due to the stochastic nature of the parameters).
        This attribute is mandatory in a Transformation.
        """
        ...


trait Conversion(SingleOperation):
    """
    An operation on coordinates that does not include any change of Datum.
    """

    fn source_crs(self) -> CoordinateReferenceSystem:
        """
        Returns the source CRS. Conversions may have a source CRS that is not specified here, but through
        `DerivedCRS.getBaseCRS()` instead.
        """
        ...

    fn target_crs(self) -> CoordinateReferenceSystem:
        """
        Returns the target CRS. Conversions may have a target CRS that is not specified here, but through
        `DerivedCRS` instead.
        """
        ...

    fn operation_version(self) -> None:
        """
        This attribute is declared in `CoordinateOperation` but is not used in a conversion.
        """
        ...
