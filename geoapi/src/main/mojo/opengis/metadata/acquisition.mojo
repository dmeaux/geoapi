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

"""This is the acquisition module.

This module contains geographic metadata structures regarding data
acquisition that are derived from the ISO 19115-2:2019 international
standard.
"""

from opengis.metadata.citation import Citation, Identifier, Responsibility
from opengis.metadata.extent import Extent
from opengis.metadata.identification import ProgressCode


struct ContextCode():
    """Designation of criterion for defining the context of the scanning
    process event.
    """

    alias ACQUISITION = "acquisition"
    """Event related to a specific collection."""
    alias PASS = "pass"
    """Event related to a sequence of collections."""
    alias WAY_POINT = "wayPoint"
    """Event related to a navigational manoeuvre."""


struct EventTypeCode():
    """Type of event related to a platform, instrument, or sensor."""

    alias ANNOUNCEMENT = "announcement"
    """Announcementannouncement about future events relevant to the
    platform/instrument/sensor.
    """
    alias CALIBRATION = "calibration"
    """Calibration event for the platform/instrument/sensor."""
    alias CALIBRATION_COEFFICIENT_UPDATE = "calibrationCoefficientUpdate"
    """Update of calibration information for the platform/instrument/sensor."""
    alias DATA_LOSS = "dataLoss"
    """Event related to data loss."""
    alias FATAL = "fatal"
    """Event that renders the platform/instrument/sensor unusable."""
    alias MANOEUVRE = "manoeuvre"
    """Event related to a manoeuvre of the platform/instrument/sensor."""
    alias MISSING_DATA = "missingData"
    """Event related to missing data from the platform/instrument/sensor."""
    alias NOTICE = "notice"
    """Notice about events related to the platform/instrument/sensor."""
    alias PRELAUNCH = "prelaunch"
    """Event related to prelaunch period for the platform/instrument/sensor."""
    alias SEVERE = "severe"
    """Event with significant impact on the performance of the platform/
    instrument/sensor.
    """
    alias SWITCH_OFF = "switchOff"
    """Event related to switching off platform/instrument/sensor."""
    alias SWITCH_ON = "switchOn"
    """Event related to switching on platform/instrument/sensor."""
    alias CLEAN = "clean"
    """Event related to cleaning the platform/instrument/sensor."""


struct GeometryTypeCode():
    """Geometric description of the collection."""
    alias POINT = "point"
    """Single geographic point of interest."""
    alias LINEAR = "linear"
    """Extended collection in a single vector."""
    alias AREAL = "areal"
    """Collection of a geographic area defined by a polygon (coverage)."""
    alias STRIP = "strip"
    """Series of linear collections grouped by way points."""


struct ObjectiveTypeCode():
    """Temporal persistence of collection objective."""

    alias INSTANTANEOUS_COLLECTION = "instantaneousCollection"
    """Single instance of collection."""
    alias PERSISTENT_VIEW = "persistentView"
    """Multiple instances of collection."""
    alias SURVEY = "survey"
    """Collection over specified domain."""


struct OperationTypeCode():
    """Code indicating whether the data contained in this packet is real
    (originates from live-fly or other non-simulated operational sources),
    simulated (originates from target simulator sources), or synthesized
    (a mix of real and simulated data).
    """

    alias REAL = "real"
    """Originates from live-fly or other non-simulated operational source."""
    alias SIMULATED = "simulated"
    """Originates from target simulator sources."""
    alias SYNTHESIZED = "synthesized"
    """Mix of real and simulated data."""


struct PriorityCode():
    """Ordered list of priorities."""

    alias CRITICAL = "critical"
    """Of decisive importance."""
    alias HIGH_IMPORTANCE = "highImportance"
    """Requires resources to be made available."""
    alias MEDIUM_IMPORTANCE = "mediumImportance"
    """Normal operation priority."""
    alias LOW_IMPORTANCE = "lowImportance"
    """To be completed when resources are available."""


struct SequenceCode():
    """Temporal relation of activation."""

    alias START = "start"
    """Beginning of collection."""
    alias END = "end"
    """End of collection."""
    alias INSTANTANEOUS = "instantaneous"
    """Collection without a significant duration."""


struct TriggerCode():
    """Mechanism of activation."""

    alias AUTOMATIC = "automatic"
    """Event due to external stimuli."""
    alias MANUAL = "manual"
    """Event manually instigated."""
    alias PRE_PROGRAMMED = "preProgrammed"
    """Event instaigated by planned internal stimuli."""


trait Revision():
    """History of the revision of an event"""

    fn description(self) -> String:
        """Description of the revision."""
        ...

    fn responsible_party(self) -> Sequence[Responsibility]:
        """Individual or organisation responsible for the revision."""
        ...

    fn date_info(self) -> Sequence[date]:
        """Information about dates related to the revision."""
        ...


trait InstrumentEvent():
    """An event related to a platform, instrument, or sensor."""

    fn citation(self) -> Optional[Sequence[Citation]]:
        """Citation to the `InstrumentEvent`."""
        ...

    fn description(self) -> String:
        """Description of the `InstumentEvent`."""
        ...

    fn extent(self) -> Optional[Sequence[Extent]]:
        """Extent of the `InstrumentEvent`."""
        ...

    fn type(self) -> EventTypeCode:
        """Type of the `InstrumentEvent`."""
        ...

    fn revision_history(self) -> Optional[Sequence[Revision]]:
        """History of the revisions of the `InstrumentEvent`."""
        ...


trait InstrumentEventList():
    """List of events relaed to platform, instrument, or sensor."""

    fn citation(self) -> Optional[Sequence[Citation]]:
        """Citation to the `InstrumentEventList`."""
        ...

    fn description(self) -> String:
        """
        Description of the language and character set used for the
        `InstrumentationEventList`.
        """
        ...

    fn locale(self) -> Optional[PT_Locale]:
        """
        Description of the language and character set used for the
        `InstrumentationEventList`.
        """
        ...

    fn constraints(self) -> Optional[Sequence[Constraints]]:
        """Use and access constraints."""
        ...

    fn instrumentation_event(self) -> Optional[Sequence[InstrumentEvent]]:
        """Events(s) in the list of events."""
        ...


trait Instrument():
    """Designations for the measuring instruments."""

    fn citation(self) -> Sequence[Citation]:
        """Complete citation of the instrument."""
        ...

    fn identifier(self) -> Identifier:
        """Complete citation of the instrument."""
        ...

    fn type(self) -> String:
        """Name of the type of instrument. Examples: framing, line-scan,
        push-broom, pan-frame.
        """
        ...

    fn description(self) -> String:
        """Textual description of the instrument."""
        ...

    fn mounted_on(self) -> Platform:
        """Platform on which the instrument is mounted"""
        ...

    fn sensor(self) -> Optional[Sequence[Sensor]]:
        """Instrument has a sensor."""
        ...

    fn history(self) -> Optional[InstrumentEventList]:
        """List of events associated with the instrument."""
        ...


trait Sensor(Instrument):
    """Specific type of instrument"""

    fn hosted(self) -> Optional[Instrument]:
        """Instrument on which the sensor is hosted"""
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

    fn other_property(self) -> Optional[Record]:
        """Instance of other property type not included in `Sensor`."""
        ...

    fn other_property_type(self) -> Optional[RecordType]:
        """Type of other property description."""
        ...

    fn instrument(self) -> Sequence[Instrument]:
        """Instrument(s) mounted on a platform"""
        ...

    fn history(self) -> Optional[Sequence[InstrumentEventList]]:
        """List of events affecting a platform."""
        ...


trait PlatformPass():
    """Identification of collection coverage. Identifies a particular pass
    made by the platform during data acquisition. A platform pass is used to
    provide supporting identifying information for an event and for data
    acquisition of a particular objective."""

    fn identifier(self) -> Identifier:
        """Unique name of the pass."""
        ...

    fn extent(self) -> Optional[Extent]:
        """Temporal and spatial extent of the pass."""
        ...

    fn related_event(self) -> Optional[Sequence['Event']]:
        """Occurrence of one or more events for a pass."""
        ...


trait Event():
    """Identification of a significant collection point within an
    operation.
    """

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

    fn expected_objective(self) -> Optional[Sequence['Objective']]:
        """An objective expected to be completed by the event."""
        ...

    fn related_pass(self) -> PlatformPass:
        """A `PlatformPass` related to the `Event`."""
        ...

    fn related_sensor(self) -> Sequence[Instrument]:
        """An `Instrument` related to
            the event."""


trait EnvironmentalRecord():
    """Information about the environmental conditions during the acquisition.
    """

    fn average_air_temperature(self) -> Optional[Float64]:
        """
        Average air temperature along the flight pass during the photo flight.
        """
        ...

    fn max_relative_humidity(self) -> Optional[Float64]:
        """
        Maximum realative humitiy along the flight pass during the photo
        flight.
        """
        ...

    fn max_altitude(self) -> Optional[Float64]:
        """
        Maximum altitude during the photo flight.
        """
        ...

    fn meteorological_conditions(self) -> Optional[String]:
        """
        Meteorological conditions in the photo flight area, in particular
        clouds, snow, and wind.
        """
        ...

    fn solar_azimuth(self) -> Optional[Float64]:
        """
        Clockwise angle in degrees from north to the centre of the sun's disc.

        NOTE: This Angle is calculated from the nadir point of the sensor, not
        the centre point of the image.
        """
        ...

    fn solar_elevation(self) -> Optional[Float64]:
        """
        Angle between the horizonand the centre of the sun's disk.
        """


trait Objective():
    """Describes the characteristics, spatial and temporal extent of the intended
    object to be observed.
    """

    fn identifier(self) -> Sequence[Identifier]:
        """Registered code used to identify the objective."""
        ...

    fn priority(self) -> Optional[String]:
        """Priority applied to the target."""
        ...

    fn type(self) -> Optional[Sequence[ObjectiveTypeCode]]:
        """Collection technique for the objective."""
        ...

    fn function(self) -> Optional[Sequence[String]]:
        """Function performed by or at the objective."""
        ...

    fn extent(self) -> Optional[Sequence[Extent]]:
        """Extent information including the bounding box, bounding polygon,
        vertical and temporal extent of the objective.
        """
        ...

    fn objective_occurence(self) -> Optional[Sequence[Event]]:
        """Event or events associated with objective completion."""
        ...

    fn platform_pass(self) -> Optional[Sequence[PlatformPass]]:
        """Pass of the platform over the objective."""
        ...

    fn sensing_instrument(self) -> Optional[Sequence[Instrument]]:
        """Instrument which senses the objective data."""


trait Operation():
    """Designations for the operation used to acquire the dataset."""

    fn description(self) -> Optional[String]:
        """Description of the mission on which the platform observations are part
        and the objectives of that mission.
        """
        ...

    fn citation(self) -> Optional[Citation]:
        """Identification of the mission."""
        ...

    fn identifier(self) -> Optional[Identifier]:
        """Unique identification of the operation."""
        ...

    fn status(self) -> ProgressCode:
        """Status of the data acquisition."""
        ...

    fn type(self) -> Optional[OperationTypeCode]:
        """Collection technique for the operation."""
        ...

    fn other_property(self) -> Optional[Record]:
        """Instance of other property type not included in `Sensor`."""
        ...

    fn other_property_type(self) -> Optional[RecordType]:
        """Type of other property description."""
        ...

    fn child_operation(self) -> Optional[Sequence['Operation']]:
        """Sub-missions that make up part of a larger mission."""
        ...

    fn objective(self) -> Optional[Sequence[Objective]]:
        """Object(s) or area(s) of interest to be sensed."""
        ...

    fn parent_operation(self) -> 'Operation':
        """Heritage of the operation."""
        ...

    fn plan(self) -> Optional['Plan']:
        """Plan satisfied by th operation."""
        ...

    fn platform(self) -> Optional[Sequence[Platform]]:
        """Platform (or platforms) used in the operation."""
        ...

    fn significant_event(self) -> Optional[Sequence[Event]]:
        """Record of an event occuring during an operation."""


trait RequestedDate():
    """Range of date validity."""

    fn requested_date_of_collection(self) -> datetime:
        """Preferred date and time of collection."""
        ...

    fn latest_acceptable_date(self) -> datetime:
        """Latest date and time collection must be completed."""


trait Requirement():
    """Requirement to be satisfied by the planned data acquisition."""

    fn citation(self) -> Optional[Citation]:
        """
        Identification of reference or guidance material for the requirement.
        """
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

    fn satisfied_plan(self) -> Optional[Sequence['Plan']]:
        """Plan that identifies solution to satisfy the requirement."""


trait Plan():
    """Designations for the planning information related to meeting requirements.
    """

    fn type(self) -> Optional[GeometryTypeCode]:
        """
        Manner of sampling geometry the planner expects for collection of the
        objective data.
        """
        ...

    fn status(self) -> ProgressCode:
        """Current status of the plan (pending, completed, etc.)."""
        ...

    fn citation(self) -> Citation:
        """Identification of authority requesting target collection."""
        ...

    fn operation(self) -> Optional[Sequence[Operation]]:
        """Identification of the activity or activities that satisfy a plan."""
        ...

    fn satisfied_requirement(self) -> Optional[Sequence[Requirement]]:
        """Requirement satisfied by the plan."""


trait AcquisitionInformation():
    """Designations for the measuring instruments and their bands, the platform
    carrying them, and the mission to which the data contributes.
    """

    fn scope(self) -> Optional[Sequence[Scope]]:
        """The specific data to which the acquisition information applies."""
        ...

    fn acquisition_plan(self) -> Optional[Sequence[Plan]]:
        """Identifies the plan as implemented by the acquisition."""
        ...

    fn acquisition_requirement(self) -> Optional[Sequence[Requirement]]:
        """
        Identifies the requirement the data acquisition intends to satisfy.
        """
        ...

    fn environmental_conditions(self) -> Optional[EnvironmentalRecord]:
        """
        A record of the environmental circumstances during the data
        acquisition.
        """
        ...

    fn instrument(self) -> Optional[Sequence[Instrument]]:
        """
        General information about the instrument used in data acquisition.
        """
        ...

    fn objective(self) -> Optional[Sequence[Objective]]:
        """Identification of the area or object to be sensed."""
        ...

    fn operation(self) -> Optional[Sequence[Operation]]:
        """
        General information about an identifiable activity which provided the
        data.
        """
        ...

    fn platform(self) -> Optional[Sequence[Platform]]:
        """
        General information about the platform from which the data were taken.
        """
