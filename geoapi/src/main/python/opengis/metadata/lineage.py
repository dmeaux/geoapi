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

from abc import ABC, abstractmethod
from datetime import datetime
from typing import Sequence

from opengis.metadata.citation import Citation, Identifier, Responsibility
from opengis.metadata.identification import Resolution
from opengis.metadata.maintenance import Scope


class NominalResolution(ABC):
    """Distance between adjacent pixels."""

    @property
    @abstractmethod
    def scanning_resolution(self) -> float:
        """Distance between adjacent pixels in the scan plane."""

    @property
    @abstractmethod
    def ground_resolution(self) -> float:
        """Distance between adjacent pixels in the object space."""


class Source(ABC):
    """
    Information about the source resource used in creating the data specified
    by the scope.
    """

    @property
    @abstractmethod
    def description(self) -> str:
        """Detailed description of the level of the source resource."""

    @property
    @abstractmethod
    def source_spatial_resolution(self) -> Resolution:
        """
        Level of detail expressed as a scale factor, a distance or an angle.
        """

    @property
    @abstractmethod
    def source_reference_system(self):
        """Spatial reference system used by the source resource."""
        # See https://github.com/opengeospatial/geoapi/issues/57

    @property
    @abstractmethod
    def source_citation(self) -> Citation:
        """Recommended reference to be used for the source resource."""

    @property
    @abstractmethod
    def source_metadata(self) -> Sequence[Citation]:
        """Identifier and link to source metadata."""

    @property
    @abstractmethod
    def scope(self) -> Scope:
        """Type of resource and/or extent of the source."""

    @property
    @abstractmethod
    def source_step(self) -> Sequence['ProcessStep']:
        """Information about process steps in which this source was used."""

    @property
    @abstractmethod
    def processed_level(self) -> Identifier:
        """Processing level of the source data."""

    @property
    @abstractmethod
    def resolution(self) -> NominalResolution:
        """Distance between two adjacent pixels."""


class Algorithm(ABC):
    """
    Details of the methodology by which geographic information was derived
    from the instrument readings.
    """

    @property
    @abstractmethod
    def citation(self) -> Citation:
        """Information identifying the algorithm and version or date."""

    @property
    @abstractmethod
    def description(self) -> str:
        """Information describing the algorithm used to generate the data."""


class Processing(ABC):
    """
    Comprehensive information about the procedure(s), process(es) and
    algorithm(s) applied in the process step.
    """

    @property
    @abstractmethod
    def algorithm(self) -> Sequence[Algorithm]:
        """"""

    @property
    @abstractmethod
    def identifier(self) -> Identifier:
        """
        Information to identify the processing package that produced the data.
        """

    @property
    @abstractmethod
    def software_reference(self) -> Sequence[Citation]:
        """Reference to document describing processing software."""

    @property
    @abstractmethod
    def procedure_description(self) -> str:
        """Additional details about the processing procedures."""

    @property
    @abstractmethod
    def documentation(self) -> Sequence[Citation]:
        """Reference to documentation describing the processing."""

    @property
    @abstractmethod
    def run_time_parameters(self) -> str:
        """
        Parameters to control the processing operations, entered at run time.
        """


class ProcessStepReport(ABC):
    """Report of what occurred during the process step."""

    @property
    @abstractmethod
    def name(self) -> str:
        """Name of the processing report."""

    @property
    @abstractmethod
    def description(self) -> str:
        """Textual description of what occurred during the process step."""

    @property
    @abstractmethod
    def file_type(self) -> str:
        """Type of file that contains that processing report."""


class ProcessStep(ABC):
    """
    Information about an event or transformation in the life of a resource,
    including the process used to maintain the resource.
    """

    @property
    @abstractmethod
    def description(self) -> str:
        """
        Description of the event, including related parameters or tolerances.
        """

    @property
    @abstractmethod
    def rationale(self) -> str:
        """Requirement or purpose for the process step."""

    @property
    @abstractmethod
    def step_date_time(self) -> datetime:
        """Date, time, range or period of process step."""

    @property
    @abstractmethod
    def processor(self) -> Sequence[Responsibility]:
        """
        Identification of, and means of communication with, person(s) and
        organisation(s) associated with the process step.
        """

    @property
    @abstractmethod
    def reference(self) -> Sequence[Citation]:
        """Process step documentation."""

    @property
    @abstractmethod
    def scope(self) -> Scope:
        """Type of resource and/or extent to which the process step applies."""

    @property
    @abstractmethod
    def source(self) -> Sequence[Source]:
        """"""

    @property
    @abstractmethod
    def processing_information(self) -> Processing:
        """"""

    @property
    @abstractmethod
    def report(self) -> Sequence[ProcessStepReport]:
        """"""

    @property
    @abstractmethod
    def output(self) -> Sequence[Source]:
        """"""


class Lineage(ABC):
    """
    Information about the events or source data used in constructing the data
    specified by the scope or lack of knowledge about lineage.
    """

    @property
    @abstractmethod
    def statement(self) -> str:
        """
        General explanation of the data producer's knowledge about the lineage
        of a resource.
        """

    @property
    @abstractmethod
    def scope(self) -> Scope:
        """
        Type of resource and/or extent to which the lineage information
        applies.
        """

    @property
    @abstractmethod
    def additional_documentation(self) -> Sequence[Citation]:
        """"""

    @property
    @abstractmethod
    def source(self) -> Sequence[Source]:
        """"""

    @property
    @abstractmethod
    def process_step(self) -> Sequence[ProcessStep]:
        """"""
