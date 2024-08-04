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
"""This is the lineage module.

This module contains geographic metadata structures derived from the
ISO 19115-1:2014 international standard regarding the lineage of the data,
that is how the data has changed and the sources from which it is derived.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass
from datetime import datetime

from opengis.metadata.citation import Citation, Identifier, Responsibility
from opengis.metadata.identification import Resolution
from opengis.metadata.maintenance import Scope


@dataclass(frozen=True, slots=True)
class NominalResolution:
    """Distance between adjacent pixels.

    Attributes:
        scanning_resolution (float): Distance between adjacent pixels in the
            scan plane.
        ground_resolution (float): Distance between adjacent pixels in the
            object space.

    """

    scanning_resolution: float
    ground_resolution: float


@dataclass(frozen=True, slots=True)
class Source:
    """Information about the source resource used in creating the data
    specified by the scope.

    Attributes:
        description (str): Detailed description of the level of the source
            resource.
        source_spatial_resolution (Resolution): Level of detail expressed as a
            scale factor, a distance or an angle.
        source_reference_system (MD_ReferenceSystem): Spatial reference system
            used by the source resource.
        source_citation (Citation): Recommended reference to be used for the
            source resource.
        source_metadata (tuple[Citation, ...]): Identifier and link to source
            metadata.
        scope (Scope): Type of resource and/or extent of the source.
        source_step (tuple['ProcessStep', ...]): Information about process
            steps in which this source was used.
        processed_level (Identifier): Processing level of the source data.
        resolution (NominalResolution): Distance between two adjacent pixels.

    """

    description: str
    source_spatial_resolution: Resolution
    source_reference_system: MD_ReferenceSystem
    source_citation: Citation
    source_metadata: tuple[Citation, ...]
    scope: Scope
    source_step: tuple['ProcessStep', ...]
    processed_level: Identifier
    resolution: NominalResolution


@dataclass(frozen=True, slots=True)
class Algorithm:
    """Details of the methodology by which geographic information was derived
    from the instrument readings.

    Attributes:
        citation (Citation): Information identifying the algorithm and version
            or date.
        description (str): Information describing the algorithm used to
            generate the data.

    """

    citation: Citation
    description: str


@dataclass(frozen=True, slots=True)
class Processing:
    """Comprehensive information about the procedure(s), process(es) and
    algorithm(s) applied in the process step.

    Attributes:
        algorithm (tuple[Algorithm, ...]): 
        identifier (Identifier): Information to identify the processing
            package that produced the data.
        software_reference (tuple[Citation, ...]): Reference to document
            describing processing software.
        procedure_description (str): Additional details about the processing
            procedures.
        documentation (tuple[Citation, ...]): Reference to documentation
            describing the processing.
        run_time_parameters (str): Parameters to control the processing
            operations, entered at run time.

    """

    algorithm: tuple[Algorithm, ...]
    identifier: Identifier
    software_reference: tuple[Citation, ...]
    procedure_description: str
    documentation: tuple[Citation, ...]
    run_time_parameters: str


@dataclass(frozen=True, slots=True)
class ProcessingStepReport:
    """Report of what occurred during the process step.

    Attributes:
        name (str): Name of the processing report.
        description (str): Textual description of what occurred during the
            process step.
        file_type (str): Type of file that contains that processing report.

    """

    name: str
    description: str
    file_type: str


@dataclass(frozen=True, slots=True)
class ProcessStep:
    """Information about an event or transformation in the life of a resource
    including the process used to maintain the resource.

    Attributes:
        description (str): Description of the event, including related
            parameters or tolerances.
        rationale (str): Requirement or purpose for the process step.
        step_date_time (datetime): Date, time, range or period of process step.
        processor (tuple[Responsibility, ...]): Identification of, and means
            of communication with, person(s) and organisation(s) associated
            with the process step.
        reference (tuple[Citation, ...]): Process step documentation.
        scope (Scope): Type of resource and/or extent to which the process
            step applies.
        source (tuple[Source, ...]): 
        processing_information (Processing): 
        report (tuple[ProcessingStepReport, ...]): 
        output (tuple[Source, ...]): 

    """

    description: str
    rationale: str
    step_date_time: datetime
    processor: tuple[Responsibility, ...]
    reference: tuple[Citation, ...]
    scope: Scope
    source: tuple[Source, ...]
    processing_information: Processing
    report: tuple[ProcessingStepReport, ...]
    output: tuple[Source, ...]


@dataclass(frozen=True, slots=True)
class Lineage:
    """Information about the events or source data used in constructing the
    data specified by the scope or lack of knowledge about lineage.

    Attributes:
        statement (str): General explanation of the data producer's knowledge
            about the lineage of a resource.
        scope (Scope): Type of resource and/or extent to which the lineage
            information applies.
        additional_documentation (tuple[Citation, ...]): 
        source (tuple[Source, ...]): 
        process_step (tuple[ProcessStep, ...]): 

    """

    statement: str
    scope: Scope
    additional_documentation: tuple[Citation, ...]
    source: tuple[Source, ...]
    process_step: tuple[ProcessStep, ...]
