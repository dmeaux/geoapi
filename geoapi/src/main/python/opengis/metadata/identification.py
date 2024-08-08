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

from dataclasses import dataclass
from datetime import datetime
from enum import Enum

from uri.uri import URI

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
    grouping and search of available geographic data sets.

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
    GEOSCIENTIFIC_INFORMATION = "geoscientificInformation"
    HEALTH = "health"
    IMAGERY_BASE_MAPS_EARTH_COVER = "imageryBaseMapsEarthCover"
    INTELLIGENCE_MILITARY = "intelligenceMilitary"
    INLAND_WATERS = "inlandWaters"
    LOCATION = "location"
    OCEANS = "oceans"
    PLANNING_CADASTRE = "planningCadastre"
    SOCIETY = "society"
    STRUCTURE = "structure"
    TRANSPORTATION = "transportation"
    UTILITIES_COMMUNICATION = "utilitiesCommunication"
    EXTRA_TERRESTRIAL = "extraTerrestrial"
    DISASTER = "disaster"


@dataclass(frozen=True, slots=True)
class BrowseGraphic:
    """Graphic that provides an illustration of the dataset (should include a
    legend for the graphic, if applicable).

    Attributes:
        file_name (str): Name of the file that contains a graphic that
            provides an illustration of the dataset.
        file_description (str): Text description of the illustration.
        file_type (str): Format in which the illustration is encoded.
        image_constraints (tuple[Constraints, ...]): Restriction on access
            and/or use of browse graphic.
        linkage (tuple[OnlineResource, ...]): Link to browse graphic.

    """

    file_name: str
    file_description: str
    file_type: str
    image_constraints: tuple[Constraints, ...]
    linkage: tuple[OnlineResource, ...]


@dataclass(frozen=True, slots=True)
class KeywordClass:
    """Specification of a class to categorize keywords in a domain-specific
    vocabulary that has a binding to a formal ontology.

    Attributes:
        class_name (str): Character string to label the keyword category in
            natural language.
        concept_identifier (URI): URI of concept in ontology specified by the
            ontology attribute; this concept is labeled by the className:
            CharacterString.
        ontology (Citation): A reference that binds the keyword class to a
            formal conceptualization of a knowledge domain for use in semantic
            processing. NOTE: Keywords in the associated MD_Keywords keyword
            list must be within the scope of this ontology.

    """

    class_name: str
    concept_identifier: URI
    ontology: Citation


@dataclass(frozen=True, slots=True)
class Keywords:
    """Keywords, their type and reference source. NOTE: When the resource
    described is a service, one instance of MD_Keyword shall refer to the
    service taxonomy defined in ISO 19119, 8.3).

    Attributes:
        keyword (tuple[str, ...]): Commonly used word(s) or formalised word(s)
            or phrase(s) used to describe the subject.
        type (KeywordTypeCode): Subject matter used to group similar keywords.
        thesaurus_name (Citation): Name of the formally registered thesaurus
            or a similar authoritative source of keywords.
        keyword_class (KeywordClass): Association of an MD_Keywords instance
            with an MD_KeywordsClass to provide user-defined categorization of
            groups of keywords that extend or are orthogonal to the
            standardized KeywordTypeCodes and are associated with an ontology
            that allows additional semantic query processing. NOTE: The
            thesaurus citation specifies a collection of instances from some
            ontology, but is not an ontology. It might be a list of places
            that include rivers, mountains, counties and cities. There might
            be a Laconte County, the city Laconte, the Laconte River, and Mt.
            Laconte; when searching it is useful for the user to be able to
            restrict the search to rivers only.

    """

    keyword: tuple[str, ...]
    type: KeywordTypeCode
    thesaurus_name: Citation
    keyword_class: KeywordClass


@dataclass(frozen=True, slots=True)
class Usage:
    """Brief description of ways in which the resource(s) is/are currently or
    has been used.

    Attributes:
        specific_usage (str): Brief description of the resource and/or
            resource series usage.
        usage_date_time (datetime): Date and time of the first use or range of
            uses of the resource and/or resource series.
        user_determined_limitations (str): Applications, determined by the
            user for which the resource and/or resource series is not suitable.
        user_contact_info (tuple[Responsibility, ...]): Identification of and
            means of communicating with person(s) and organisation(s) using
            the resource(s).
        response (tuple[str, ...]): Response to the user-determined
            limitations, e.g., "this has been fixed in version x".
        additional_documentation (tuple[Citation, ...]): 
        identified_issues (tuple[Citation, ...]): 

    """

    specific_usage: str
    usage_date_time: datetime
    user_determined_limitations: str
    user_contact_info: tuple[Responsibility, ...]
    response: tuple[str, ...]
    additional_documentation: tuple[Citation, ...]
    identified_issues: tuple[Citation, ...]


@dataclass(frozen=True, slots=True)
class RepresentativeFraction:
    """Derived from ISO 19103 Scale where
    MD_RepresentativeFraction.denominator = 1 / Scale.measure and
    Scale.targetUnits = Scale.sourceUnits.

    Attributes:
    denominator (int): The number below the line in a vulgar fraction.

    """

    denominator: int


@dataclass(frozen=True, slots=True)
class Resolution:
    """Level of detail expressed as a scale factor, a distance or an angle.

    Attributes:
        equivalent_scale (RepresentativeFraction): Level of detail expressed
            as the scale of a comparable hardcopy map or chart.
        distance (float): Horizontal ground sample distance.
        vertical (float): Vertical sampling distance.
        angular_distance (float): Angular sampling measure.
        level_of_detail (str): Brief textual description of the spatial
            resolution of the resource.

    """

    equivalent_scale: RepresentativeFraction
    distance: float
    vertical: float
    angular_distance: float
    level_of_detail: str


@dataclass(frozen=True, slots=True)
class AssociatedResource:
    """Associated resource information. NOTE: An associated resource is a
    dataset composed of a collection of datasets.

    Attributes:
        name (Citation): Citation information about the associated resource.
        association_type (AssociationTypeCode): Type of relation between the
            resources.
        initiative_type (InitiativeTypeCode): Type of initiative under which
            the associated resource was produced. NOTE: the activity that
            resulted in the associated resource.
        metadata_reference (Citation): Reference to the metadata of the
            associated resource."

    """

    name: Citation
    association_type: AssociationTypeCode
    initiative_type: InitiativeTypeCode
    metadata_reference: Citation


@dataclass(frozen=True, slots=True)
class Identification:
    """Basic information required to uniquely identify a resource or resources.

    Attributes:
        citation (Citation): Citation for the resource(s).
        abstract (str): Brief narrative summary of the content of the
            resource(s).
        purpose (str):Summary of the intentions with which the resource(s) was
            developed.
        credit (tuple[str, ...]): Recognition of those who contributed to the
            resource(s).
        status (tuple[ProgressCode, ...]): Status of the resource(s).
        point_of_contact (tuple[Responsibility, ...]): Identification of, and
            means of communication with, person(s) and organisation(s)
            associated with the resource(s).
        spatial_representation_type 
            (tuple[SpatialRepresentationTypeCode, ...]): Method used to
            spatially represent geographic information.
        spatial_resolution (tuple[Resolution, ...]): Factor which provides a
            general understanding of the density of spatial data in the
            resource.
        temporal_resolution (TM_Duration): Resolution of the resource with
            respect to time.
        topic_category (tuple[TopicCategoryCode, ...]): Main theme(s) of the
            resource.
        extent (tuple[Extent, ...]): Spatial and temporal extent of the
            resource.
        additional_documentation (tuple[Citation, ...]): Other documentation
            associated with the resource.
        processing_level (Identifier): Code that identifies the level of
            processing in the producers coding system of a resource e.g.,
            NOAA level 1B.
        resource_maintenance (tuple[MaintenanceInformation, ...]): 
        graphic_overview (tuple[BrowseGraphic, ...]): 
        resource_format (tuple[Format, ...]): 
        descriptive_keywords (tuple[Keywords, ...]): 
        resource_specific_usage (tuple[Usage, ...]): 
        resource_constraints (tuple[Constraints]): 
        associated_resource (tuple[AssociatedResource, ...]): 

    """

    citation: Citation
    abstract: str
    purpose: str
    credit: tuple[str, ...]
    status: tuple[ProgressCode, ...]
    point_of_contact: tuple[Responsibility, ...]
    spatial_representation_type: tuple[SpatialRepresentationTypeCode, ...]
    spatial_resolution: tuple[Resolution, ...]
    temporal_resolution: TM_Duration
    topic_category: tuple[TopicCategoryCode, ...]
    extent: tuple[Extent, ...]
    additional_documentation: tuple[Citation, ...]
    processing_level: Identifier
    resource_maintenance: tuple[MaintenanceInformation, ...]
    graphic_overview: tuple[BrowseGraphic, ...]
    resource_format: tuple[Format, ...]
    descriptive_keywords: tuple[Keywords, ...]
    resource_specific_usage: tuple[Usage, ...]
    resource_constraints: tuple[Constraints]
    associated_resource: tuple[AssociatedResource, ...]


@dataclass(frozen=True, slots=True)
class DataIdentification(Identification):
    """Basic information required to uniquely identify a resource or resources.

    Attributes:
        default_locale (PT_Locale): Language and charcter set used localized
            character string for a linguistic extension.
        other_Locale (PT_Locale): Provides information about an alternatively
            used localized character string for a linguistic extension.
        environment_description (str): Description of the resource in the
            producer's processing environment, including items such as the
            software, the computer operating system, file name, and the
            dataset size.
        supplemental_information (str): Any other descriptive information
            about the resource.

    """

    default_locale: PT_Locale
    other_Locale: PT_Locale
    environment_description: str
    supplemental_information: str
