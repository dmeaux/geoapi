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
"""This is the acquisition module.

This module contains geographic metadata structures regarding data
acquisition that are derived from the ISO 19115-2:2019 international
standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass
from datetime import datetime
from enum import Enum

from opengis.metadata.citation import Citation, Identifier, Responsibility
from opengis.metadata.extent import Extent
from opengis.metadata.identification import ProgressCode


class ContextCode(Enum):
    """
    Designation of criterion for defining the context of the scanning
    process event.
    """

    ACQUISITION = "acquisition"
    PASS = "pass"
    WAY_POINT = "wayPoint"


class GeometryTypeCode(Enum):
    """Geometric description of the collection."""

    POINT = "point"
    LINEAR = "linear"
    AREAL = "areal"
    STRIP = "strip"


class ObjectiveTypeCode(Enum):
    """Temporal persistence of collection objective."""

    INSTANTANEOUS_COLLECTION = "instantaneousCollection"
    PERSISTENT_VIEW = "persistentView"
    SURVEY = "survey"


class OperationTypeCode(Enum):
    """
    Code indicating whether the data contained in this packet is real
    (originates from live-fly or other non-simulated operational sources),
    simulated (originates from target simulator sources), or synthesized
    (a mix of real and simulated data).
    """

    REAL = "real"
    SIMULATED = "simulated"
    SYNTHESIZED = "synthesized"


class PriorityCode(Enum):
    """Ordered list of priorities."""

    CRITICAL = "critical"
    HIGH_IMPORTANCE = "highImportance"
    MEDIUM_IMPORTANCE = "mediumImportance"
    LOW_IMPORTANCE = "lowImportance"


class SequenceCode(Enum):
    """Temporal relation of activation."""

    START = "start"
    END = "end"
    INSTANTANEOUS = "instantaneous"


class TriggerCode(Enum):
    """Mechanism of activation."""

    AUTOMATIC = "automatic"
    MANUAL = "manual"
    PRE_PROGRAMMED = "preProgrammed"


@dataclass(frozen=True, slots=True)
class Instrument:
    """Designation for a measuring instrument.

    Attributes:
        citation (tuple[Citation, ...]): Complete citation of the instrument.
        identifier (Identifier): Unique identification of the instrument.
        type (str): Code describing the type of instrument.
        description (str): Textual description of the instrument.
        mounted_on (Platform): The platform on which the instrument is
            mounted.

    """

    citation: tuple[Citation, ...]
    identifier: Identifier
    type: str
    description: str
    mounted_on: "Platform"


@dataclass(frozen=True, slots=True)
class Platform:
    """Designations for the platform used to acquire the dataset.

    Attributes:
        citation (Citation): Complete citation of the platform.
        identifier (Identifier): Unique identification of the platform.
        description (str): Narrative description of the platform supporting
            the instrument.
        sponsor (tuple[Responsibility, ...]): Organization responsible for
            building, launch, or operation of the platform.
        instrument (tuple[Instrument, ...]): The instrument(s) mounted on the
            platform.

    """

    citation: Citation
    identifier: Identifier
    description: str
    sponsor: tuple[Responsibility, ...]
    instrument: tuple[Instrument, ...]


@dataclass(frozen=True, slots=True)
class PlatformPass:
    """Identification of collection coverage.

    Attrubutes:
        identifier (Identifier): Unique name of the pass.
        extent (Extent): Area covered by the pass.
        related_event (tuple[Event, ...]): A particular event related to the
            pass.

    """

    identifier: Identifier
    extent: Extent
    related_event: tuple["Event", ...]


@dataclass(frozen=True, slots=True)
class Event:
    """Identification of a significant collection point within an operation.

    Attributes:
        identifier (Identifier): Event name or number.
        trigger (TriggerCode): Initiator of the event.
        context (ContextCode): Meaning of the event.
        sequence (SequenceCode): Relative time ordering of the event.
        time (datetime): Time the event occurred.
        related_pass (PlatformPass): A `PlatformPass` related to the `Event`.
        related_sensor (tuple[Instrument, ...]): An `Instrument` related to
            the event.
        expected_objective (tuple[Objective, ...]): An objective expected to
            be completed by the event.

    """

    identifier: Identifier
    trigger: TriggerCode
    context: ContextCode
    sequence: SequenceCode
    time: datetime
    related_pass: PlatformPass
    related_sensor: tuple[Instrument, ...]
    expected_objective: tuple["Objective", ...]


@dataclass(frozen=True, slots=True)
class EnvironmentalRecord:
    """ 

    Attributes:
        average_air_temperature (float): 
        max_relative_humidity (float): 
        max_altitude (float): 
        meteorological_conditions (str): 

    """

    average_air_temperature: float
    max_relative_humidity: float
    max_altitude: float
    meteorological_conditions: str


@dataclass(frozen=True, slots=True)
class Objective:
    """Describes the characteristics, spatial and temporal extent of the
    intended object to be observed.

    Attributes:
        identifier (Identifier): Registered code used to identify the
            objective.
        priority (str): Priority applied to the target.
        type (tuple[ObjectiveTypeCode, ...]): Collection technique for the
            objective.
        function (tuple[str, ...]): Function performed by or at the objective.
        extent (tuple[Extent, ...]): Extent information including the bounding
            box, bounding polygon, vertical and temporal extent of the
            objective.
        sensing_instrument (tuple[Instrument, ...]): 
        platform_pass (PlatformPass): 
        objective_occurence (tuple[Event, ...]): 

    """

    identifier: Identifier
    priority: str
    type: tuple[ObjectiveTypeCode, ...]
    function: tuple[str, ...]
    extent: tuple[Extent, ...]
    sensing_instrument: tuple[Instrument, ...]
    platform_pass: PlatformPass
    objective_occurence: tuple[Event, ...]


@dataclass(frozen=True, slots=True)
class Operation:
    """Designations for the operation used to acquire the dataset.

    Attributes:
        description (str): Description of the mission on which the platform
            observations are part and the objectives of that mission.
        citation (Citation): Character string by which the mission is known.
        identifier (Identifier): Character string by which the mission is
            known.
        status (ProgressCode): Status of the data acquisition.
        type (OperationTypeCode): 
        parent_operation (Operation): 
        child_operation (tuple[Operation, ...]): 
        platform (tuple[Platform, ...]): Platform(s) used in the operation.
        objective (tuple[Objective, ...]): 
        plan (Plan): 
        significant_event (tuple[Event, ...]): 

    """

    description: str
    citation: Citation
    identifier: Identifier
    status: ProgressCode
    type: OperationTypeCode
    parent_operation: "Operation"
    child_operation: tuple["Operation", ...]
    platform: tuple[Platform, ...]
    objective: tuple[Objective, ...]
    plan: "Plan"
    significant_event: tuple[Event, ...]


@dataclass(frozen=True, slots=True)
class RequestedDate:
    """Range of date validity.

    Attributes:
        requested_date_of_collection (datetime): Preferred date and time of
            collection.
        latest_acceptable_date (datetime): Latest date and time collection
            must be completed.

    """

    requested_date_of_collection: datetime
    latest_acceptable_date: datetime


@dataclass(frozen=True, slots=True)
class Requirement:
    """Requirement to be satisfied by the planned data acquisition.

    Attributes:
        citation (Citation): Identification of reference or guidance material
            for the requirement.
        identifier (Identifier): Unique name, or code, for the requirement.
        requestor (tuple[Responsibility, ...]): Origin of requirement.
        recipient (tuple[Responsibility, ...]): Person(s), or body(ies), to
            receive results of requirement.
        priority (PriorityCode): Relative ordered importance, or urgency, of
            the requirement.
        requested_date (RequestedDate): Required or preferred acquisition date
            and time.
        expiry_date (datetime): Date and time after which collection is no
            longer valid.
        satisfied_plan (tuple[Plan, ...]): Plan that identifies solution to
            satisfy the requirement.

    """

    citation: Citation
    identifier: Identifier
    requestor: tuple[Responsibility, ...]
    recipient: tuple[Responsibility, ...]
    priority: PriorityCode
    requested_date: RequestedDate
    expiry_date: datetime
    satisfied_plans: tuple["Plan", ...]


@dataclass(frozen=True, slots=True)
class Plan:
    """Designations for the planning information related to meeting
    requirements.

    Attributes:
        type (GeometryTypeCode): Manner of sampling geometry the planner
            expects for collection of the objective data.
        status (ProgressCode): Current status of the plan (pending, completed,
            etc.).
        citation (Citation): Identification of authority requesting target
            collection.
        operation (tuple[Operation, ...]): 
        satisfied_requirement (tuple[Requirement, ...]): Requirement satisfied
            by the plan.

    """

    type: GeometryTypeCode
    status: ProgressCode
    citation: Citation
    operation: tuple[Operation, ...]
    satisfied_requirement: tuple[Requirement, ...]


@dataclass(frozen=True, slots=True)
class AcquisitionInformation:
    """Designations for the measuring instruments and their bands, the
        platform carrying them, and the mission to which
    the data contributes.

    Attributes:
        instrument (tuple[Instrument, ...]): The instrument(s) used to collect
            the data.
        operation (tuple[Operation, ...]): The associated operation(s).
        platform (tuple[Platform, ...]): The associated platform(s).
        acquisition_plan (tuple[Plan, ...]): The associated acquisition
            plan(s).
        objective (tuple[Objective, ...]): The associated objective(s).
        acquisition_requirement (tuple[Requirement, ...]): The associated
            acquisition requirement(s).
        environmental_conditions (EnvironmentalRecord): The associated
            environmental condition(s).
    """

    instrument: tuple[Instrument, ...]
    operation: tuple[Operation, ...]
    platform: tuple[Platform, ...]
    acquisition_plan: tuple[Plan, ...]
    objective: tuple[Objective, ...]
    acquisition_requirement: tuple[Requirement, ...]
    environmental_conditions: EnvironmentalRecord
