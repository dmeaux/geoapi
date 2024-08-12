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
"""This is the identification module.

This module contains geographic metadata structures regarding identification
information codelists and common base classes derived from the
ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from abc import ABC, abstractmethod
from collections.abc import Sequence
from datetime import datetime, timedelta
from enum import Enum
from typing import Optional

from opengis.metadata.citation import (
    Citation,
    Identifier,
    OnlineResource,
    Responsibility,
)
from opengis.metadata.constraints import Constraints
from opengis.metadata.distribution import Format
from opengis.metadata.extent import Extent
from opengis.metadata.maintenance import MaintenanceInformation
from opengis.metadata.representation import SpatialRepresentationTypeCode


class AssociationTypeCode(Enum):
    """Justification for the correlation of two resources."""

    CROSS_REFERENCE = "crossReference"
    LARGER_WORK_CITATION = "largerWorkCitation"
    PART_OF_SEAMLESS_DATABASE = "partOfSeamlessDatabase"
    SOURCE = "source"
    STEREO_MATE = "stereoMate"
    IS_COMPOSED_OF = "isComposedOf"
    COLLECTIVE_TITLE = "collectiveTitle"
    SERIES = "series"
    DEPENDENCY = "dependency"
    REVISION_OF = "revisionOf"


class InitiativeTypeCode(Enum):
    """Type of aggregation activity in which resources are related."""

    CAMPAIGN = "campaign"
    COLLECTION = "collection"
    EXERCISE = "exercise"
    EXPERIMENT = "experiment"
    INVESTIGATION = "investigation"
    MISSION = "mission"
    SENSOR = "sensor"
    OPERATION = "operation"
    PLATFORM = "platform"
    PROCESS = "process"
    PROGRAM = "program"
    PROJECT = "project"
    STUDY = "study"
    TASK = "task"
    TRIAL = "trial"


class KeywordTypeCode(Enum):
    """Methods used to group similar keywords."""

    DISCIPLINE = "discipline"
    PLACE = "place"
    STRATUM = "stratum"
    TEMPORAL = "temporal"
    THEME = "theme"
    DATA_CENTRE = "dataCentre"
    FEATURE_TYPE = "featureType"
    INSTRUMENT = "instrument"
    PLATFORM = "platform"
    PROCESS = "process"
    PROJECT = "project"
    SERVICE = "service"
    PRODUCT = "product"
    SUB_TOPIC_CATEGORY = "subTopicCategory"
    TAXON = "taxon"


class ProgressCode(Enum):
    """Status of the resource."""

    COMPLETED = "completed"
    HISTORICAL_ARCHIVE = "historicalArchive"
    OBSOLETE = "obsolete"
    ON_GOING = "onGoing"
    PLANNED = "planned"
    REQUIRED = "required"
    UNDER_DEVELOPMENT = "underDevelopment"
    FINAL = "final"
    PENDING = "pending"
    RETIRED = "retired"
    SUPERSEDED = "superseded"
    TENTATIVE = "tentative"
    VALID = "valid"
    ACCEPTED = "accepted"
    NOT_ACCEPTED = "notAccepted"
    WITHDRAWN = "withdrawn"
    PROPOSED = "proposed"
    DEPRECATED = "deprecated"


class TopicCategoryCode(Enum):
    """
    High-level geographic data thematic classification to assist in the
    grouping and search of available geographic datasets.

    NOTE 1: Can be used to group keywords as well. Listed examples are not
    exhaustive.

    NOTE 2: Is is understto there are overlaps between general categories and
    the user is encouraged to select the one most appropriate.
    """

    FARMING = "farming"
    BIOTA = "biota"
    BOUNDARIES = "boundaries"
    CLIMATOLOGY_METEOROLOGY_ATMOSPHERE = "climatologyMeteorologyAtmosphere"
    ECONOMY = "economy"
    ELEVATION = "elevation"
    ENVIRONMENT = "environment"
    SOCIETY = "society"
    STRUCTURE = "structure"
    TRANSPORTATION = "transportation"
    UTILITIES_COMMUNICATION = "utilitiesCommunication"
    EXTRA_TERRESTRIAL = "extraTerrestrial"
    DISASTER = "disaster"


class BrowseGraphic(ABC):
    """
    Graphic that provides an illustration of a resource/dataset

    NOTE: should include a legend for the graphic, if applicable.

    Example: A dataset, an organisation logo, security constraint, or citation
    graphic.
    """

    @property
    @abstractmethod
    def file_name(self) -> str:
        """
        Name of the file that contains a graphic that provides an illustration
        of the resource/dataset.
        """

    @property
    @abstractmethod
    def file_description(self) -> Optional[str]:
        """Text description of the illustration."""

    @property
    @abstractmethod
    def file_type(self) -> Optional[str]:
        """
        Format in which the illustration is encoded.

        Example: EPS, GIF, JPEG, PBM, PS, TIFF, PDF.
        """

    @property
    @abstractmethod
    def image_constraints(self) -> Optional[Sequence[Constraints]]:
        """Restriction on access and/or use of browse graphic."""

    @property
    @abstractmethod
    def linkage(self) -> Optional[Sequence[OnlineResource]]:
        """Link to browse graphic."""


class KeywordClass(ABC):
    """
    Specification of a class to categorize keywords in a domain-specific
    vocabulary that has a binding to a formal ontology.
    """

    @property
    @abstractmethod
    def class_name(self) -> str:
        """
        Character string to label the keyword category in natural language.
        """

    @property
    @abstractmethod
    def concept_identifier(self) -> Optional[URI]:
        """
        URI of concept in ontology specified by the ontology attribute; this
        concept is labeled by the className: CharacterString.
        """

    @property
    @abstractmethod
    def ontology(self) -> Citation:
        """
        A reference that binds the keyword class to a formal conceptualization
        of a knowledge domain for use in semantic processing NOTE: Keywords in
        the associated `Keywords` keyword list must be within the scope of
        this ontology.
        """


class Keywords(ABC):
    """
    Keywords, their type and reference source.

        NOTE: When the resource
    described is a service, one instance of `Keyword` shall refer to the
    service taxonomy defined in ISO 19119, 8.3).
    """

    @property
    @abstractmethod
    def keyword(self) -> Sequence[str]:
        """
        Commonly used word(s) or formalised word(s) or phrase(s) used to
        describe the subject.
        """

    @property
    @abstractmethod
    def type(self) -> Optional[KeywordTypeCode]:
        """Subject matter used to group similar keywords."""

    @property
    @abstractmethod
    def thesaurus_name(self) -> Optional[Citation]:
        """
        Name of the formally registered thesaurus or a similar authoritative
        source of keywords.
        """

    @property
    @abstractmethod
    def keyword_class(self) -> Optional[KeywordClass]:
        """
        Association of an `Keywords` instance with an `KeywordClass` to
        provide user-defined categorization of groups of keywords that extend
        or are orthogonal to the standardized KeywordTypeCodes and are
        associated with an ontology that allows additional semantic query
        processing.

        NOTE: The thesaurus citation specifies a collection of
        instances from some ontology, but is not an ontology. It might be a
        list of places that include rivers, mountains, counties and cities.
        There might be a Laconte County, the city Laconte, the Laconte River,
        and Mt. Laconte; when searching it is useful for the user to be able to
        restrict the search to rivers only.
        """


class Usage(ABC):
    """
    Brief description of ways in which the resource(s) is/are currently or has
    been used.
    """

    @property
    @abstractmethod
    def specific_usage(self) -> str:
        """Brief description of the resource and/or resource series usage."""

    @property
    @abstractmethod
    def usage_date_time(self) -> Optional[Sequence[datetime]]:
        """
        Date and time of the first use or range of uses of the resource and/or
        resource series.
        """

    @property
    @abstractmethod
    def user_determined_limitations(self) -> str:
        """
        Applications, determined by the user for which the resource and/or
        resource series is not suitable.
        """

    @property
    @abstractmethod
    def user_contact_info(self) -> Optional[Sequence[Responsibility]]:
        """
        Identification of and means of communicating with person(s) and
        organisation(s) using the resource(s).
        """

    @property
    @abstractmethod
    def response(self) -> Optional[Sequence[str]]:
        """
        Response to the user-determined limitations, e.g., 'This has been fixed
        in version x.'
        """

    @property
    @abstractmethod
    def additional_documentation(self) -> Optional[Sequence[Citation]]:
        """Publications that describe usage of data."""

    @property
    @abstractmethod
    def identified_issues(self) -> Optional[Sequence[Citation]]:
        """
        Citation of a description of known issues associated with the resource
        along with proposed solutions if available.
        """


class RepresentativeFraction(ABC):
    """
    Derived from ISO 19103 Scale where
    `denominator` = 1 / `Scale.measure`
    and `Scale.target_units` = `Scale.source_units`.
    """

    @property
    @abstractmethod
    def denominator(self) -> int:
        """
        The number below the line in a vulgar fraction.

        Domain: > 0
        """


class Resolution(ABC):
    """Level of detail expressed as a scale factor, a distance or an angle."""

    @property
    @abstractmethod
    def equivalent_scale(self) -> Optional[RepresentativeFraction]:
        """
        Level of detail expressed as the scale of a comparable hardcopy map or
        chart.

        MANDATORY: if `distance`, `vertical`, `angular_distance`,
            or `level_of_detail` not documented.
        """

    @property
    @abstractmethod
    def distance(self) -> Optional[Distance]:
        """
        Horizontal ground sample distance.

        MANDATORY: if `equivalent_scale`, `vertical`, `angular_distance`,
            or `level_of_detail` not documented.
        """

    @property
    @abstractmethod
    def vertical(self) -> Optional[Distance]:
        """
        Vertical sampling distance.

        MANDATORY: if `equivalent_scale`, `distance`, `angular_distance`,
            or `level_of_detail` not documented.
        """

    @property
    @abstractmethod
    def angular_distance(self) -> Optional[Angle]:
        """
        Angular sampling measure.

        MANDATORY: if `equivalent_scale`, `distance`, `vertical`,
            or `level_of_detail` not documented.
        """

    @property
    @abstractmethod
    def level_of_detail(self) -> Optional[str]:
        """
        Brief textual description of the spatial resolution of the resource.

        MANDATORY: if `equivalent_scale`, `distance`, `vertical`,
            or `angular_distance` not documented.
        """


class AssociatedResource(ABC):
    """
    Associated resource information.

    NOTE: An associated resource is a dataset composed of a collection
    of datasets.
    """

    @property
    @abstractmethod
    def name(self) -> Optional[Citation]:
        """
        Citation information about the associated resource.

        MANDATORY: if `metadata_reference` not documented.
        """

    @property
    @abstractmethod
    def association_type(self) -> AssociationTypeCode:
        """Type of relation between the resources."""

    @property
    @abstractmethod
    def initiative_type(self) -> Optional[InitiativeTypeCode]:
        """
        Type of initiative under which the associated resource was produced.

        NOTE: the activity that resulted in the associated resource.
        """

    @property
    @abstractmethod
    def metadata_reference(self) -> Optional[Citation]:
        """
        Reference to the metadata of the associated resource.

        MANDATORY: if `name` not documented.
        """


class Identification(ABC):
    """
    Basic information required to uniquely identify a resource or resources.
    """

    @property
    @abstractmethod
    def citation(self) -> Citation:
        """Citation for the resource(s)."""

    @property
    @abstractmethod
    def abstract(self) -> str:
        """Brief narrative summary of the content of the resource(s)."""

    @abstractmethod
    def purpose(self) -> Optional[str]:
        """
        Summary of the intentions with which the resource(s) was developed.
        """

    @property
    @abstractmethod
    def credit(self) -> Optional[Sequence[str]]:
        """Recognition of those who contributed to the resource(s)."""

    @property
    @abstractmethod
    def status(self) -> Optional[Sequence[ProgressCode]]:
        """Status of the resource(s)."""

    @property
    @abstractmethod
    def point_of_contact(self) -> Optional[Sequence[Responsibility]]:
        """
        Identification of, and means of communication with, person(s) and
        organisation(s) associated with the resource(s).
        """

    @property
    @abstractmethod
    def spatial_representation_type(self) -> Optional[Sequence[
        SpatialRepresentationTypeCode
    ]]:
        """Method used to spatially represent geographic information."""

    @property
    @abstractmethod
    def spatial_resolution(self) -> Optional[Sequence[Resolution]]:
        """
        Factor which provides a general understanding of the density of
        spatial data in the resource.
        """

    @property
    @abstractmethod
    def temporal_resolution(self) -> Optional[Sequence[timedelta]]:
        """Smallest resolvable temporal period in a resource."""

    @property
    @abstractmethod
    def topic_category(self) -> Optional[Sequence[TopicCategoryCode]]:
        """
        Main theme(s) of the resource.

        MANDATORY: if `Metadata.metadata_scope.resource_scope` == 'dataset'
            OR `Metadata.metadata_scope.resource_scope` == 'series'.
        """

    @property
    @abstractmethod
    def extent(self) -> Optional[Sequence[Extent]]:
        """
        Spatial and temporal extent of the resource.

        MANDATORY: if `Metadata.metadata_scope.resource_scope` == 'dataset'
            then `extent.geographic_element.GeographicBoundingBox`
            or  `extent.geographic_element.Geographicdescription` is required.
        """

    @property
    @abstractmethod
    def additional_documentation(self) -> Optional[Sequence[Citation]]:
        """
        Other documentation associated with the resource, e.g.,
        Related articles, publications, user guides, data dictionaries.
        """

    @property
    @abstractmethod
    def processing_level(self) -> Optional[Identifier]:
        """
        Code that identifies the level of processing in the producers coding
        system of a resource, e.g., NOAA level 1B.
        """

    @property
    @abstractmethod
    def resource_maintenance(self) -> Optional[Sequence[
        MaintenanceInformation
    ]]:
        """
        Information about the frequency of resource updates and the scope of
        those updates.
        """

    @property
    @abstractmethod
    def graphic_overview(self) -> Optional[Sequence[BrowseGraphic]]:
        """
        Graphic that illustrates the resource (should include a legend for
        the graphic).
        """

    @property
    @abstractmethod
    def resource_format(self) -> Optional[Sequence[Format]]:
        """Description of the format of the resource."""

    @property
    @abstractmethod
    def descriptive_keywords(self) -> Optional[Sequence[Keywords]]:
        """Category keywords, their type, and reference source."""

    @property
    @abstractmethod
    def resource_specific_usage(self) -> Optional[Sequence[Usage]]:
        """
        Basic information about specific application(s) for which the resource
        has been or is being used by different users.
        """

    @property
    @abstractmethod
    def resource_constraints(self) -> Optional[Sequence[Constraints]]:
        """Information about constraints which apply to the resource."""

    @property
    @abstractmethod
    def associated_resource(self) -> Optional[Sequence[AssociatedResource]]:
        """Associated resource information."""


class DataIdentification(Identification):
    """Information required to identify a resource."""

    @property
    @abstractmethod
    def default_locale(self) -> Optional[PT_Locale]:
        """
        Language and character set used within the resource.

        MANDATORY: if a language is used in the resource.
        """

    @property
    @abstractmethod
    def other_locale(self) -> Optional[Sequence[PT_Locale]]:
        """
        Alternat localised language(s) and character set(s) used within
        the resource.
        """

    @property
    @abstractmethod
    def environment_description(self) -> Optional[str]:
        """
        Description of the resource in the producer's processing environment,
        including items such as the software, the computer operating system,
        file name, and the dataset size.
        """

    @property
    @abstractmethod
    def supplemental_information(self) -> Optional[str]:
        """Any other descriptive information about the resource."""
