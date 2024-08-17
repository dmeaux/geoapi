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

"""This is the lineage module.

This module contains geographic metadata structures derived from the
ISO 19115-1:2014 and ISO 19115-2:2019 international standards regarding
the lineage of the data, that is how the data has changed and the sources
from which it is derived.
"""

from opengis.metadata.citation import (
    Citation,
    CitationCollectionElement,
    Identifier,
    Responsibility,
    ResponsibilityCollectionElement,
)
from opengis.metadata.identification import Resolution
from opengis.metadata.maintenance import Scope

trait NominalResolution():
    """Distance between adjacent pixels."""

    fn scanning_resolution(self) -> Float64:
        """Distance between adjacent pixels in the scan plane."""
        ...

    fn ground_resolution(self) -> Float64:
        """Distance between adjacent pixels in the object space."""
        ...


trait Source():
    """Information about the source resource used in creating the data specified
    by the scope.
    """

    fn description(self) -> String:
        """Detailed description of the level of the source resource."""
        ...

    fn source_spatial_resolution(self) -> Resolution:
        """Level of detail expressed as a scale factor, a distance or an 
        angle.
        """
        ...

    fn source_reference_system(self):
        """Spatial reference system used by the source resource."""
        # See https://github.com/opengeospatial/geoapi/issues/57
        ...

    fn source_citation(self) -> Citation:
        """Recommended reference to be used for the source resource."""
        ...

    fn source_metadata[ElementType: CitationCollectionElement](self) -> Tuple[ElementType]:
        """Identifier and link to source metadata."""
        ...

    fn scope(self) -> Scope:
        """Type of resource and/or extent of the source."""
        ...

    fn source_step[ElementType: ProcessStepCollectionElement](self) -> Tuple[ElementType]:
        """Information about process steps in which this source was used."""
        ...

    fn processed_level(self) -> Identifier:
        """Processing level of the source data."""
        ...

    fn resolution(self) -> NominalResolution:
        """Distance between two adjacent pixels."""
        ...


trait SourceCollectionElement(CollectionElement, Source):
    """
    Abstract collection element conforming to the Source trait.
    """
    ...


trait Algorithm():
    """Details of the methodology by which geographic information was derived from the instrument readings."""

    fn citation(self) -> Citation:
        """Information identifying the algorithm and version or date."""
        ...

    fn description(self) -> String:
        """Information describing the algorithm used to generate the data."""
        ...


trait AlgorithmCollectionElement(CollectionElement, Algorithm):
    """
    Abstract collection element conforming to the Algorithm trait.
    """
    ...


trait Processing():
    """Comprehensive information about the procedure(s), process(es) and algorithm(s) applied in the process step."""

    fn algorithm[ElementType: AlgorithmCollectionElement](self) -> Tuple[ElementType]:
        ...

    fn identifier(self) -> Identifier:
        """Information to identify the processing package that produced the data."""
        ...

    fn software_reference[ElementType: CitationCollectionElement](self) -> Tuple[ElementType]:
        """Reference to document describing processing software."""
        ...

    fn procedure_description(self) -> String:
        """Additional details about the processing procedures."""
        ...

    fn documentation[ElementType: CitationCollectionElement](self) -> Tuple[ElementType]:
        """Reference to documentation describing the processing."""
        ...

    fn run_time_parameters(self) -> String:
        """Parameters to control the processing operations, entered at run time."""
        ...


trait ProcessStepReport():
    """Report of what occurred during the process step."""

    fn name(self) -> String:
        """Name of the processing report."""
        ...

    fn description(self) -> String:
        """Textual description of what occurred during the process step."""
        ...

    fn file_type(self) -> String:
        """Type of file that contains that processing report."""
        ...


trait ProcessStepReportCollectionElement(CollectionElement, ProcessStepReport):
    """
    Abstract collection element conforming to the ProcessStepReport trait.
    """
    ...


trait ProcessStep():
    """Information about an event or transformation in the life of a resource including the process used to maintain the resource."""

    fn description(self) -> String:
        """Description of the event, including related parameters or tolerances."""
        ...

    fn rationale(self) -> String:
        """Requirement or purpose for the process step."""
        ...

    fn step_date_time(self) -> datetime:
        """Date, time, range or period of process step."""
        ...

    fn processor[ElementType: ResponsibilityCollectionElement](self) -> Tuple[ElementType]:
        """Identification of, and means of communication with, person(s) and organisation(s) associated with the process step."""
        ...

    fn reference[ElementType: CitationCollectionElement](self) -> Tuple[ElementType]:
        """Process step documentation."""
        ...

    fn scope(self) -> Scope:
        """Type of resource and/or extent to which the process step applies."""
        ...

    fn source[ElementType: SourceCollectionElement](self) -> Tuple[ElementType]:
        ...

    fn processing_information(self) -> Processing:
        ...

    fn report[ElementType: ProcessStepReportCollectionElement](self) -> Tuple[ElementType]:
        ...

    fn output[ElementType: SourceCollectionElement](self) -> Tuple[ElementType]:
        ...


trait ProcessStepCollectionElement(CollectionElement, ProcessStep):
    """
    Abstract collection element conforming to the ProcessStep trait.
    """
    ...


trait Lineage():
    """Information about the events or source data used in constructing the data specified by the scope or lack of knowledge about lineage."""

    fn statement(self) -> String:
        """General explanation of the data producer's knowledge about the lineage of a resource."""
        ...

    fn scope(self) -> Scope:
        """Type of resource and/or extent to which the lineage information applies."""
        ...

    fn additional_documentation[ElementType: CitationCollectionElement](self) -> Tuple[ElementType]:
        ...

    fn source[ElementType: SourceCollectionElement](self) -> Tuple[ElementType]:
        ...

    fn process_step[ElementType: ProcessStepCollectionElement](self) -> Tuple[ElementType]:
        ...
