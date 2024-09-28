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

"""This is the `lineage` module.

This module contains geographic metadata structures derived from the
ISO 19115-1:2014 and ISO 19115-2:2019 international standards regarding
the lineage of the data, that is how the data has changed and the sources
from which it is derived.
"""

from collections import Optional

from opengis.metadata.citation import (
    Citation,
    CitationCollectionElement,
    Identifier,
    Responsibility,
    ResponsibilityCollectionElement,
)
from opengis.metadata.identification import Resolution
from opengis.metadata.maintenance import Scope


trait NominalResolution:
    """Distance between consistent parts (centre, left side, right side) of
    adjacent pixels."""

    fn scanning_resolution(self) -> Distance:
        """Distance between consistent parts (centre, left side, right side)
        of adjacent pixels in the scan plane.
        """
        ...

    fn ground_resolution(self) -> Distance:
        """Distance between consistent parts (centre, left side, right side)
        of adjacent pixels in the object space.
        """
        ...


trait Source:
    """Information about the source resource used in creating the data specified
    by the scope."""

    fn description(self) -> Optional[String]:
        """Detailed description of the level of the source resource.

        MANDATORY:
            If `scope` is `None`.
        """
        ...

    fn source_spatial_resolution(self) -> Optional[Resolution]:
        """Level of detail expressed as a scale factor, a distance or an angle.
        """
        ...

    fn source_reference_system(self) -> Optional[ReferenceSystem]:
        """Spatial reference system used by the source resource."""
        ...

    fn source_citation(self) -> Optional[Citation]:
        """Recommended reference to be used for the source resource."""
        ...

    fn source_metadata(self) -> Optional[Tuple[Citation]]:
        """Identifier and link to source metadata."""
        ...

    fn scope(self) -> Optional[Scope]:
        """Type of resource and/or extent of the source.

        MANDATORY:
            If `description` is `None`.
        """
        ...

    fn source_step(self) -> Optional[Tuple["ProcessStep"]]:
        """Information about process steps in which this source was used."""
        ...

    fn processed_level(self) -> Optional[Identifier]:
        """Processing level of the source data."""
        ...

    fn resolution(self) -> Optional[NominalResolution]:
        """Distance between consistent parts (centre, left side, right side)
        of two adjacent pixels.
        """
        ...


trait Algorithm:
    """Details of the methodology by which geographic information was derived
    from the instrument readings."""

    fn citation(self) -> Citation:
        """Information identifying the algorithm and version or date."""
        ...

    fn description(self) -> String:
        """Information describing the algorithm used to generate the data."""
        ...


trait ProcessParameter:
    """Parameter (value or resource) used in a process."""

    fn name(self) -> MemberName:
        """Name/type of parameter."""
        ...

    fn direction(self) -> ParameterDirection:
        """Indication the parameter is an input to the process, an output,
        or both.
        """
        ...

    fn description(self) -> Optional[String]:
        """Narrative explaining the role of the parameter."""
        ...

    fn optionality(self) -> Bool:
        """Indication the parameter is required."""
        ...

    fn repeatability(self) -> Bool:
        """Indication if more than one value of the parameter may be provided.
        """
        ...

    fn value_type(self) -> Optional[RecordType]:
        """Data type of the value"""
        ...

    fn value(self) -> Optional[Record]:
        """Constant value."""
        ...

    fn resource(self) -> Optional[Source]:
        """Resource to be processed."""
        ...


trait Processing:
    """Comprehensive information about the procedure(s), process(es) and
    algorithm(s) applied in the process step."""

    fn identifier(self) -> Identifier:
        """Information to identify the processing package that produced the data.
        """
        ...

    fn software_reference(self) -> Optional[Tuple[Citation]]:
        """Reference to document describing processing software."""
        ...

    fn procedure_description(self) -> Optional[String]:
        """Additional details about the processing procedures."""
        ...

    fn documentation(self) -> Optional[Tuple[Citation]]:
        """Reference to documentation describing the processing."""
        ...

    fn run_time_parameters(self) -> Optional[String]:
        """Parameters to control the processing operations, entered at run time.
        """
        ...

    fn other_property(self) -> Optional[Record]:
        """Instance of other property type not included in `Sensor`."""
        ...

    fn other_property_type(self) -> Optional[RecordType]:
        """Type of other property description."""
        ...

    fn algorithm(self) -> Optional[Tuple[Algorithm]]:
        """Details of the methodology by which geographic information was derived
        from the instrument readings.
        """
        ...

    fn parameter(self) -> Optional[ProcessParameter]:
        """Parameter(s) used in a process"""
        ...


trait ProcessStepReport:
    """Report of what occurred during the process step."""

    fn name(self) -> String:
        """Name of the processing report."""
        ...

    fn description(self) -> Optional[String]:
        """Textual description of what occurred during the process step."""
        ...

    fn file_type(self) -> Optional[String]:
        """Type of file that contains that processing report."""
        ...


trait ProcessStep:
    """Information about an event or transformation in the life of the dataset
    including details of the algorithm and software used for processing."""

    fn description(self) -> String:
        """Description of the event, including related parameters or tolerances.
        """
        ...

    fn rationale(self) -> Optional[String]:
        """Requirement or purpose for the process step."""
        ...

    fn step_date_time(self) -> Optional[datetime]:
        """Date, time, range or period of process step."""
        ...

    fn processor(self) -> Optional[Tuple[Responsibility]]:
        """Identification of, and means of communication with, person(s) and
        organisation(s) associated with the process step.
        """
        ...

    fn reference(self) -> Optional[Tuple[Citation]]:
        """Process step documentation."""
        ...

    fn scope(self) -> Optional[Scope]:
        """Type of resource and/or extent to which the process step applies."""
        ...

    fn source(self) -> Optional[Tuple[Source]]:
        """Type of the resource and/or extent to which the process step applies.
        """
        ...

    fn output(self) -> Optional[Tuple[Source]]:
        """Description of the product generated as a result of the process step.
        """
        ...

    fn processing_information(self) -> Optional[Processing]:
        """Comprehensive information about the procedure by which the algorithm
        was applied to derive geographic data from the raw instrument
        measurements, such as datasets, software used, and the processing
        environment.
        """
        ...

    fn report(self) -> Optional[Tuple[ProcessStepReport]]:
        """Report generated by the process step."""
        ...


trait Lineage:
    """Information about the events or source data used in constructing the data
    specified by the scope or lack of knowledge about lineage."""

    fn statement(self) -> Optional[String]:
        """General explanation of the data producer's knowledge about the lineage
        of a resource.
        """
        ...

    fn scope(self) -> Optional[Scope]:
        """Type of resource and/or extent to which the lineage information
        applies.
        """
        ...

    fn additional_documentation(self) -> Optional[Tuple[Citation]]:
        """Resource.

        Example:
            A publication that describes the whole process to
            generate this resource, e.g., a dataset.
        """
        ...

    fn process_step(self) -> Optional[Tuple[ProcessStep]]:
        """Information about events in the life of a resource specified by the
        scope.

        MANDATORY:
            If `statement` and `source` are `None`.
        """
        ...

    fn source(self) -> Optional[Tuple[Source]]:
        """Information about the source data used in creating the data specified
        by the scope.

        MANDATORY:
            If `statement` and `process_step` are `None`.
        """
        ...
