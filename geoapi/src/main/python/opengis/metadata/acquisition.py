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

This subpackage contains geographic metadata structures regarding data
acquisition that are derived from the ISO 19115-1:2014 international
standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"


from abc import ABC, abstractmethod
from collections.abc import Sequence
from datetime import datetime
from enum import Enum
from typing import Optional

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


class InstrumentEventList(ABC):
    """"""


class Instrument(ABC):
    """Designations for the measuring instruments."""

    @property
    @abstractmethod
    def citation(self) -> Optional[Sequence[Citation]]:
        """Complete citation of the instrument."""

    @property
    @abstractmethod
    def identifier(self) -> Identifier:
        """Complete citation of the instrument."""

    @property
    @abstractmethod
    def type(self) -> str:
        """Code describing the type of instrument."""

    @property
    @abstractmethod
    def description(self) -> Optional[str]:
        """Textual description of the instrument."""

    @property
    @abstractmethod
    def mounted_on(self) -> Optional['Platform']:
        """Platform on which the instrument is mounted"""

    @property
    @abstractmethod
    def sensor(self) -> Optional[Sequence['Sensor']]:
        """Instrument has a sensor."""

    @property
    @abstractmethod
    def history(self) -> Optional['InstrumentEventList']:
        """List of events associated with the instrument."""


class Sensor(Instrument):
    """Specific type of instrument"""

    @property
    @abstractmethod
    def hosted(self) -> Optional[Instrument]:
        """Instrument on which the sensor is hosted"""


class Platform(ABC):
    """Designations for the platform used to acquire the dataset."""

    @property
    @abstractmethod
    def citation(self) -> Optional[Citation]:
        """Complete citation of the platform."""

    @property
    @abstractmethod
    def identifier(self) -> Identifier:
        """Unique identification of the platform."""

    @property
    @abstractmethod
    def description(self) -> str:
        """Narrative description of the platform supporting the instrument."""

    @property
    @abstractmethod
    def sponsor(self) -> Optional[Sequence[Responsibility]]:
        """
        Organization responsible for building, launch, or operation of the
        platform.
        """

    @property
    @abstractmethod
    def instrument(self) -> Sequence[Instrument]:
        """"""


class PlatformPass(ABC):
    """Identification of collection coverage. Identifies a particular pass
    made by the platform during data acquisition. A platform pass is used to
    provide supporting identifying information for an event and for data
    acquisition of a particular objective."""

    @property
    @abstractmethod
    def identifier(self) -> Identifier:
        """Unique name of the pass."""

    @property
    @abstractmethod
    def extent(self) -> Optional[GM_Object]:
        """Area covered by the pass."""

    @property
    @abstractmethod
    def related_event(self) -> Optional[Sequence['Event']]:
        """"""


class Event(ABC):
    """
    Identification of a significant collection point within an
    operation.
    """

    @property
    @abstractmethod
    def identifier(self) -> Identifier:
        """Event name or number."""

    @property
    @abstractmethod
    def trigger(self) -> TriggerCode:
        """Initiator of the event."""

    @property
    @abstractmethod
    def context(self) -> ContextCode:
        """Meaning of the event."""

    @property
    @abstractmethod
    def sequence(self) -> SequenceCode:
        """Relative time ordering of the event."""

    @property
    @abstractmethod
    def time(self) -> datetime:
        """Time the event occurred."""

    @property
    @abstractmethod
    def related_pass(self) -> PlatformPass:
        """A `PlatformPass` related to the `Event`."""

    @property
    @abstractmethod
    def related_sensor(self) -> Sequence[Instrument]:
        """An `Instrument` related to
            the event."""

    @property
    @abstractmethod
    def expected_objective(self) -> Sequence['Objective']:
        """An objective expected to be completed by the event."""


class EnvironmentalRecord(ABC):
    """"""

    @property
    @abstractmethod
    def average_air_temperature(self) -> float:
        """"""

    @property
    @abstractmethod
    def max_relative_humidity(self) -> float:
        """"""

    @property
    @abstractmethod
    def max_altitude(self) -> float:
        """"""

    @property
    @abstractmethod
    def meteorological_conditions(self) -> str:
        """"""


class Objective(ABC):
    """
    Describes the characteristics, spatial and temporal extent of the intended
    object to be observed.
    """

    @property
    @abstractmethod
    def identifier(self) -> Sequence[Identifier]:
        """Registered code used to identify the objective."""

    @property
    @abstractmethod
    def priority(self) -> str:
        """Priority applied to the target."""

    @property
    @abstractmethod
    def type(self) -> Sequence[ObjectiveTypeCode]:
        """Collection technique for the objective."""

    @property
    @abstractmethod
    def function(self) -> Sequence[str]:
        """Function performed by or at the objective."""

    @property
    @abstractmethod
    def extent(self) -> Sequence[Extent]:
        """
        Extent information including the bounding box, bounding polygon,
        vertical and temporal extent of the objective.
        """

    @property
    @abstractmethod
    def sensing_instrument(self) -> Sequence[Instrument]:
        """"""

    @property
    @abstractmethod
    def platformPass(self) -> Sequence[PlatformPass]:
        """"""

    @property
    @abstractmethod
    def objective_occurence(self) -> Sequence[Event]:
        """"""


class Operation(ABC):
    """Designations for the operation used to acquire the dataset."""

    @property
    @abstractmethod
    def description(self) -> str:
        """
        Description of the mission on which the platform observations are part
        and the objectives of that mission.
        """

    @property
    @abstractmethod
    def citation(self) -> Citation:
        """Character string by which the mission is known."""

    @property
    @abstractmethod
    def identifier(self) -> Identifier:
        """Character string by which the mission is known."""

    @property
    @abstractmethod
    def status(self) -> ProgressCode:
        """Status of the data acquisition."""

    @property
    @abstractmethod
    def type(self) -> OperationTypeCode:
        """Status of the data acquisition."""

    @property
    @abstractmethod
    def parent_operation(self) -> 'Operation':
        """"""

    @property
    @abstractmethod
    def child_operation(self) -> Sequence['Operation']:
        """"""

    @property
    @abstractmethod
    def platform(self) -> Sequence[Platform]:
        """Platform (or platforms) used in the operation."""

    @property
    @abstractmethod
    def objective(self) -> Sequence[Objective]:
        """"""

    @property
    @abstractmethod
    def plan(self) -> 'Plan':
        """"""

    @property
    @abstractmethod
    def significant_event(self) -> Sequence[Event]:
        """"""


class RequestedDate(ABC):
    """Range of date validity."""

    @property
    @abstractmethod
    def requested_date_of_collection(self) -> datetime:
        """Preferred date and time of collection."""

    @property
    @abstractmethod
    def latest_acceptable_date(self) -> datetime:
        """Latest date and time collection must be completed."""


class Requirement(ABC):
    """Requirement to be satisfied by the planned data acquisition."""

    @property
    @abstractmethod
    def citation(self) -> Citation:
        """
        Identification of reference or guidance material for the requirement.
        """

    @property
    @abstractmethod
    def identifier(self) -> Identifier:
        """Unique name, or code, for the requirement."""

    @property
    @abstractmethod
    def requestor(self) -> Sequence[Responsibility]:
        """Origin of requirement."""

    @property
    @abstractmethod
    def recipient(self) -> Sequence[Responsibility]:
        """Person(s), or body(ies), to receive results of requirement."""

    @property
    @abstractmethod
    def priority(self) -> PriorityCode:
        """Relative ordered importance, or urgency, of the requirement."""

    @property
    @abstractmethod
    def requested_date(self) -> RequestedDate:
        """Required or preferred acquisition date and time."""

    @property
    @abstractmethod
    def expiry_date(self) -> datetime:
        """Date and time after which collection is no longer valid."""

    @property
    @abstractmethod
    def satisfied_plan(self) -> Sequence['Plan']:
        """Plan that identifies solution to satisfy the requirement."""


class Plan(ABC):
    """
    Designations for the planning information related to meeting requirements.
    """

    @property
    @abstractmethod
    def type(self) -> GeometryTypeCode:
        """
        Manner of sampling geometry the planner expects for collection of the
        objective data.
        """

    @property
    @abstractmethod
    def status(self) -> ProgressCode:
        """Current status of the plan (pending, completed, etc.)."""

    @property
    @abstractmethod
    def citation(self) -> Citation:
        """Identification of authority requesting target collection."""

    @property
    @abstractmethod
    def operation(self) -> Sequence[Operation]:
        """"""

    @property
    @abstractmethod
    def satisfied_requirement(self) -> Sequence[Requirement]:
        """Requirement satisfied by the plan."""


class AcquisitionInformation(ABC):
    """
    Designations for the measuring instruments and their bands, the platform
    carrying them, and the mission to which the data contributes.
    """

    @property
    @abstractmethod
    def instrument(self) -> Sequence[Instrument]:
        """The instrument(s) used to collect the data."""

    @property
    @abstractmethod
    def operation(self) -> Sequence[Operation]:
        """The associated operation(s)."""

    @property
    @abstractmethod
    def platform(self) -> Sequence[Platform]:
        """The associated platform(s)."""

    @property
    @abstractmethod
    def acquisition_plan(self) -> Sequence[Plan]:
        """The associated acquisition plan(s)."""

    @property
    @abstractmethod
    def objective(self) -> Sequence[Objective]:
        """The associated objective(s)."""

    @property
    @abstractmethod
    def acquisition_requirement(self) -> Sequence[Requirement]:
        """The associated acquisition requirement(s)."""

    @property
    @abstractmethod
    def environmental_conditions(self) -> EnvironmentalRecord:
        """The associated environmental condition(s)."""
