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
"""This is the acquisition module.

This module contains geographic metadata structures regarding data
acquisition that are derived from the ISO 19115-2:2019 international
standard.
"""

from opengis.metadata.citation import Citation, Identifier, Responsibility
from opengis.metadata.extent import Extent
from opengis.metadata.identification import ProgressCode


struct ContextCode():
    alias ACQUISITION = "acquisition"
    alias PASS = "..."
    alias WAY_POINT = "wayPoint"


struct GeometryTypeCode():
    alias POINT = "point"
    alias LINEAR = "linear"
    alias AREAL = "areal"
    alias STRIP = "strip"


struct ObjectiveTypeCode():
    alias INSTANTANEOUS_COLLECTION = "instantaneousCollection"
    alias PERSISTENT_VIEW = "persistentView"
    alias SURVEY = "survey"


struct OperationTypeCode():
    alias REAL = "real"
    alias SIMULATED = "simulated"
    alias SYNTHESIZED = "synthesized"


struct PriorityCode():
    alias CRITICAL = "critical"
    alias HIGH_IMPORTANCE = "highImportance"
    alias MEDIUM_IMPORTANCE = "mediumImportance"
    alias LOW_IMPORTANCE = "lowImportance"


struct SequenceCode():
    alias START = "start"
    alias END = "end"
    alias INSTANTANEOUS = "instantaneous"


struct TriggerCode():
    alias AUTOMATIC = "automatic"
    alias MANUAL = "manual"
    alias PRE_PROGRAMMED = "preProgrammed"


trait Instrument():
    """Designations for the measuring instruments."""

    fn citation(self) -> Sequence[Citation]:
        """Complete citation of the instrument."""
        ...

    fn identifier(self) -> Identifier:
        """Complete citation of the instrument."""
        ...

    fn type(self) -> String:
        """Code describing the type of instrument."""
        ...

    fn description(self) -> String:
        """Textual description of the instrument."""
        ...

    fn mounted_on(self) -> Platform:
        ...


trait Platform():
    """Designations for the platform used to acquire the dataset."""

    fn citation(self) -> Citation:
        """Complete citation of the platform."""
        ...

    fn identifier(self) -> Identifier:
        """Unique identification of the platform."""
        ...

    fn description(self) -> String:
        """Narrative description of the platform supporting the instrument."""
        ...

    fn sponsor(self) -> Sequence[Responsibility]:
        """Organization responsible for building, launch, or operation of the platform."""
        ...

    fn instrument(self) -> Sequence[Instrument]:
        ...


trait PlatformPass():
    """Identification of collection coverage."""

    fn identifier(self) -> Identifier:
        """Unique name of the  pass."""
        ...

    fn related_event(self) -> Sequence[Event]:
        ...


trait Event():
    """Identification of a significant collection point within an operation."""

    fn identifier(self) -> Identifier:
        """Event name or number."""
        ...

    fn trigger(self) -> TriggerCode:
        """Initiator of the event."""
        ...

    fn context(self) -> ContextCode:
        """Meaning of the event."""
        ...

    fn sequence(self) -> SequenceCode:
        """Relative time ordering of the event."""
        ...

    fn time(self) -> datetime:
        """Time the event occurred."""
        ...

    fn related_pass(self) -> PlatformPass:
        ...

    fn related_sensor(self) -> Sequence[Instrument]:
        ...

    fn expected_objective(self) -> Sequence[Objective]:
        ...


trait EnvironmentalRecord():

    fn average_air_temperature(self) -> Float64:
        ...

    fn max_relative_humidity(self) -> Float64:
        ...

    fn max_altitude(self) -> Float64:
        ...

    fn meteorological_conditions(self) -> String:
        ...


trait Objective():
    """Describes the characteristics, spatial and temporal extent of the intended object to be observed."""

    fn identifier(self) -> Sequence[Identifier]:
        """Registered code used to identify the objective."""
        ...

    fn priority(self) -> String:
        """Priority applied to the target."""
        ...

    fn type(self) -> Sequence[ObjectiveTypeCode]:
        """Collection technique for the objective."""
        ...

    fn function(self) -> Sequence[String]:
        """Function performed by or at the objective."""
        ...

    fn extent(self) -> Sequence[Extent]:
        """Extent information including the bounding box, bounding polygon, vertical and temporal extent of the objective."""
        ...

    fn sensing_instrument(self) -> Sequence[Instrument]:
        ...

    fn platformPass(self) -> Sequence[PlatformPass]:
        ...

    fn objective_occurence(self) -> Sequence[Event]:
        ...


trait Operation():
    """Designations for the operation used to acquire the dataset."""

    fn description(self) -> String:
        """Description of the mission on which the platform observations are part and the objectives of that mission."""
        ...

    fn citation(self) -> Citation:
        """Character string by which the mission is known."""
        ...

    fn identifier(self) -> Identifier:
        """Character string by which the mission is known."""
        ...

    fn status(self) -> ProgressCode:
        """Status of the data acquisition."""
        ...

    fn type(self) -> OperationTypeCode:
        """Status of the data acquisition."""
        ...

    fn parent_operation(self) -> Operation:
        ...

    fn child_operation(self) -> Sequence[Operation]:
        ...

    fn platform(self) -> Sequence[Platform]:
        """Platform (or platforms) used in the operation."""
        ...

    fn objective(self) -> Sequence[Objective]:
        ...

    fn plan(self) -> Plan:
        ...

    fn significant_event(self) -> Sequence[Event]:
        ...


trait RequestedDate():
    """Range of date validity."""

    fn requested_date_of_collection(self) -> datetime:
        """Preferred date and time of collection."""
        ...

    fn latest_acceptable_date(self) -> datetime:
        """Latest date and time collection must be completed."""
        ...


trait Requirement():
    """Requirement to be satisfied by the planned data acquisition."""

    fn citation(self) -> Citation:
        """Identification of reference or guidance material for the requirement."""
        ...

    fn identifier(self) -> Identifier:
        """Unique name, or code, for the requirement."""
        ...

    fn requestor(self) -> Sequence[Responsibility]:
        """Origin of requirement."""
        ...

    fn recipient(self) -> Sequence[Responsibility]:
        """Person(s), or body(ies), to receive results of requirement."""
        ...

    fn priority(self) -> PriorityCode:
        """Relative ordered importance, or urgency, of the requirement."""
        ...

    fn requested_date(self) -> RequestedDate:
        """Required or preferred acquisition date and time."""
        ...

    fn expiry_date(self) -> datetime:
        """Date and time after which collection is no longer valid."""
        ...

    fn satisfied_plan(self) -> Sequence[Plan]:
        ...


trait Plan():
    """Designations for the planning information related to meeting requirements."""

    fn type(self) -> GeometryTypeCode:
        """Manner of sampling geometry the planner expects for collection of the objective data."""
        ...

    fn status(self) -> ProgressCode:
        """Current status of the plan (pending, completed, etc.)."""
        ...

    fn citation(self) -> Citation:
        """Identification of authority requesting target collection."""
        ...

    fn operation(self) -> Sequence[Operation]:
        ...

    fn satisfied_requirement(self) -> Sequence[Requirement]:
        ...


trait AcquisitionInformation():
    """Designations for the measuring instruments and their bands, the platform carrying them, and the mission to which the data contributes."""

    fn instrument(self) -> Sequence[Instrument]:
        ...

    fn operation(self) -> Sequence[Operation]:
        ...

    fn platform(self) -> Sequence[Platform]:
        ...

    fn acquisition_plan(self) -> Sequence[Plan]:
        ...

    fn objective(self) -> Sequence[Objective]:
        ...

    fn acquisition_requirement(self) -> Sequence[Requirement]:
        ...

    fn environmental_conditions(self) -> EnvironmentalRecord:
        ...
