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
"""This is the `lineage` module.

This module contains geographic metadata structures derived from the
ISO 19115-1:2014 and ISO 19115-2:2019 international standards regarding
the lineage of the data, that is how the data has changed and the sources
from which it is derived.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from collections.abc import Sequence
from datetime import datetime

import opengis.metadata.citation as meta_ctitation
import opengis.metadata.identification as meta_identification
import opengis.metadata.maintenance as meta_maintenance
import opengis.metadata.naming as meta_naming
import opengis.metadata.service as meta_service
import opengis.referencing.crs as crs
import opengis.util.measure as measure

__author__ = "OGC Topic 11 (for abstract model and documentation), " +\
    "Martin Desruisseaux (Geomatys), David Meaux (Geomatys)"


class NominalResolution(ABC):
    """
    Distance between consistent parts (centre, left side, right side) of
    adjacent pixels.
    """

    @property
    @abstractmethod
    def scanning_resolution(self) -> measure.Distance:
        """
        Distance between consistent parts (centre, left side, right side)
        of adjacent pixels in the scan plane.
        """

    @property
    @abstractmethod
    def ground_resolution(self) -> measure.Distance:
        """
        Distance between consistent parts (centre, left side, right side)
        of adjacent pixels in the object space.
        """


class Source(ABC):
    """
    Information about the source resource used in creating the data specified
    by the scope.
    """

    @property
    @abstractmethod
    def description(self) -> str | None:
        """
        Detailed description of the level of the source resource.

        MANDATORY:
            If `scope` is `None`.
        """

    @property
    @abstractmethod
    def source_spatial_resolution(self) -> \
            meta_identification.Resolution | None:
        """
        Level of detail expressed as a scale factor, a distance or an angle.
        """

    @property
    @abstractmethod
    def source_reference_system(self) -> crs.ReferenceSystem | None:
        """Spatial reference system used by the source resource."""

    @property
    @abstractmethod
    def source_citation(self) -> meta_ctitation.Citation | None:
        """Recommended reference to be used for the source resource."""

    @property
    @abstractmethod
    def source_metadata(self) -> Sequence[meta_ctitation.Citation] | None:
        """Identifier and link to source metadata."""

    @property
    @abstractmethod
    def scope(self) -> meta_maintenance.Scope | None:
        """
        Type of resource and/or extent of the source.

        MANDATORY:
            If `description` is `None`.
        """

    @property
    @abstractmethod
    def source_step(self) -> Sequence[ProcessStep] | None:
        """Information about process steps in which this source was used."""

    @property
    @abstractmethod
    def processed_level(self) -> meta_ctitation.Identifier | None:
        """Processing level of the source data."""

    @property
    @abstractmethod
    def resolution(self) -> NominalResolution | None:
        """
        Distance between consistent parts (centre, left side, right side)
        of two adjacent pixels.
        """


class Algorithm(ABC):
    """
    Details of the methodology by which geographic information was derived
    from the instrument readings.
    """

    @property
    @abstractmethod
    def citation(self) -> meta_ctitation.Citation:
        """Information identifying the algorithm and version or date."""

    @property
    @abstractmethod
    def description(self) -> str:
        """Information describing the algorithm used to generate the data."""


class ProcessParameter(ABC):
    """Parameter (value or resource) used in a process."""

    @property
    @abstractmethod
    def name(self) -> meta_naming.MemberName:
        """Name/type of parameter."""

    @property
    @abstractmethod
    def direction(self) -> meta_service.ParameterDirection:
        """
        Indication the parameter is an input to the process, an output,
        or both.
        """

    @property
    @abstractmethod
    def description(self) -> str | None:
        """Narrative explaining the role of the parameter."""

    @property
    @abstractmethod
    def optionality(self) -> bool:
        """Indication the parameter is required."""

    @property
    @abstractmethod
    def repeatability(self) -> bool:
        """
        Indication if more than one value of the parameter may be provided.
        """

    @property
    @abstractmethod
    def value_type(self) -> meta_naming.RecordType | None:
        """Data type of the value"""

    @property
    @abstractmethod
    def value(self) -> meta_naming.Record | None:
        """Constant value."""

    @property
    @abstractmethod
    def resource(self) -> Source | None:
        """Resource to be processed."""


class Processing(ABC):
    """
    Comprehensive information about the procedure(s), process(es) and
    algorithm(s) applied in the process step.
    """

    @property
    @abstractmethod
    def identifier(self) -> meta_ctitation.Identifier:
        """
        Information to identify the processing package that produced the data.
        """

    @property
    @abstractmethod
    def software_reference(self) -> \
            Sequence[meta_ctitation.Citation] | None:
        """Reference to document describing processing software."""

    @property
    @abstractmethod
    def procedure_description(self) -> str | None:
        """Additional details about the processing procedures."""

    @property
    @abstractmethod
    def documentation(self) -> Sequence[meta_ctitation.Citation] | None:
        """Reference to documentation describing the processing."""

    @property
    @abstractmethod
    def run_time_parameters(self) -> str | None:
        """
        Parameters to control the processing operations, entered at run time.
        """

    @property
    @abstractmethod
    def other_property(self) -> meta_naming.Record | None:
        """Instance of other property type not included in `Sensor`."""

    @property
    @abstractmethod
    def other_property_type(self) -> meta_naming.RecordType | None:
        """Type of other property description."""

    @property
    @abstractmethod
    def algorithm(self) -> Sequence[Algorithm] | None:
        """
        Details of the methodology by which geographic information was derived
        from the instrument readings.
        """

    @property
    @abstractmethod
    def parameter(self) -> ProcessParameter | None:
        """Parameter(s) used in a process"""


class ProcessStepReport(ABC):
    """Report of what occurred during the process step."""

    @property
    @abstractmethod
    def name(self) -> str:
        """Name of the processing report."""

    @property
    @abstractmethod
    def description(self) -> str | None:
        """Textual description of what occurred during the process step."""

    @property
    @abstractmethod
    def file_type(self) -> str | None:
        """Type of file that contains that processing report."""


class ProcessStep(ABC):
    """
    Information about an event or transformation in the life of the dataset
    including details of the algorithm and software used for processing.
    """

    @property
    @abstractmethod
    def description(self) -> str:
        """
        Description of the event, including related parameters or tolerances.
        """

    @property
    @abstractmethod
    def rationale(self) -> str | None:
        """Requirement or purpose for the process step."""

    @property
    @abstractmethod
    def step_date_time(self) -> datetime | None:
        """Date, time, range or period of process step."""

    @property
    @abstractmethod
    def processor(self) -> Sequence[meta_ctitation.Responsibility] | None:
        """
        Identification of, and means of communication with, person(s) and
        organisation(s) associated with the process step.
        """

    @property
    @abstractmethod
    def reference(self) -> Sequence[meta_ctitation.Citation] | None:
        """Process step documentation."""

    @property
    @abstractmethod
    def scope(self) -> meta_maintenance.Scope | None:
        """Type of resource and/or extent to which the process step applies."""

    @property
    @abstractmethod
    def source(self) -> Sequence[Source] | None:
        """
        Type of the resource and/or extent to which the process step applies.
        """

    @property
    @abstractmethod
    def output(self) -> Sequence[Source] | None:
        """
        Description of the product generated as a result of the process step.
        """

    @property
    @abstractmethod
    def processing_information(self) -> Processing | None:
        """
        Comprehensive information about the procedure by which the algorithm
        was applied to derive geographic data from the raw instrument
        measurements, such as datasets, software used, and the processing
        environment.
        """

    @property
    @abstractmethod
    def report(self) -> Sequence[ProcessStepReport] | None:
        """Report generated by the process step."""


class Lineage(ABC):
    """
    Information about the events or source data used in constructing the data
    specified by the scope or lack of knowledge about lineage.
    """

    @property
    @abstractmethod
    def statement(self) -> str | None:
        """
        General explanation of the data producer's knowledge about the lineage
        of a resource.
        """

    @property
    @abstractmethod
    def scope(self) -> meta_maintenance.Scope | None:
        """
        Type of resource and/or extent to which the lineage information
        applies.
        """

    @property
    @abstractmethod
    def additional_documentation(self) -> \
            Sequence[meta_ctitation.Citation] | None:
        """
        Resource.

        Example:
            A publication that describes the whole process to
            generate this resource, e.g., a dataset.
        """

    @property
    @abstractmethod
    def process_step(self) -> Sequence[ProcessStep] | None:
        """
        Information about events in the life of a resource specified by the
        scope.

        MANDATORY:
            If `statement` and `source` are `None`.
        """

    @property
    @abstractmethod
    def source(self) -> Sequence[Source] | None:
        """
        Information about the source data used in creating the data specified
        by the scope.

        MANDATORY:
            If `statement` and `process_step` are `None`.
        """
