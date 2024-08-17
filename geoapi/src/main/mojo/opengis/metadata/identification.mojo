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

"""This is the identification module.

This module contains geographic metadata structures regarding identification information codelists and common base classes
derived from the ISO 19115-1:2014 international standard.
"""


from opengis.metadata.citation import OnlineResource, Citation, Responsibility, Identifier
from opengis.metadata.constraints import Constraints
from opengis.metadata.distribution import Format
from opengis.metadata.extent import Extent
from opengis.metadata.maintenance import MaintenanceInformation
from opengis.metadata.representation import SpatialRepresentationTypeCode


struct AssociationTypeCode():
    alias CROSS_REFERENCE = "crossReference"
    alias LARGER_WORK_CITATION = "largerWorkCitation"
    alias PART_OF_SEAMLESS_DATABASE = "partOfSeamlessDatabase"
    alias SOURCE = "source"
    alias STEREO_MATE = "stereoMate"
    alias IS_COMPOSED_OF = "isComposedOf"
    alias COLLECTIVE_TITLE = "collectiveTitle"
    alias SERIES = "series"
    alias DEPENDENCY = "dependency"
    alias REVISION_OF = "revisionOf"


struct InitiativeTypeCode():
    alias CAMPAIGN = "campaign"
    alias COLLECTION = "collection"
    alias EXERCISE = "exercise"
    alias EXPERIMENT = "experiment"
    alias INVESTIGATION = "investigation"
    alias MISSION = "mission"
    alias SENSOR = "sensor"
    alias OPERATION = "operation"
    alias PLATFORM = "platform"
    alias PROCESS = "process"
    alias PROGRAM = "program"
    alias PROJECT = "project"
    alias STUDY = "study"
    alias TASK = "task"
    alias TRIAL = "trial"


struct KeywordTypeCode():
    alias DISCIPLINE = "discipline"
    alias PLACE = "place"
    alias STRATUM = "stratum"
    alias TEMPORAL = "temporal"
    alias THEME = "theme"
    alias DATA_CENTRE = "dataCentre"
    alias FEATURE_TYPE = "featureType"
    alias INSTRUMENT = "instrument"
    alias PLATFORM = "platform"
    alias PROCESS = "process"
    alias PROJECT = "project"
    alias SERVICE = "service"
    alias PRODUCT = "product"
    alias SUB_TOPIC_CATEGORY = "subTopicCategory"
    alias TAXON = "taxon"


struct ProgressCode():
    alias COMPLETED = "completed"
    alias HISTORICAL_ARCHIVE = "historicalArchive"
    alias OBSOLETE = "obsolete"
    alias ON_GOING = "onGoing"
    alias PLANNED = "planned"
    alias REQUIRED = "required"
    alias UNDER_DEVELOPMENT = "underDevelopment"
    alias FINAL = "final"
    alias PENDING = "pending"
    alias RETIRED = "retired"
    alias SUPERSEDED = "superseded"
    alias TENTATIVE = "tentative"
    alias VALID = "valid"
    alias ACCEPTED = "accepted"
    alias NOT_ACCEPTED = "notAccepted"
    alias WITHDRAWN = "withdrawn"
    alias PROPOSED = "proposed"
    alias DEPRECATED = "deprecated"


struct TopicCategoryCode():
    alias FARMING = "farming"
    alias BIOTA = "biota"
    alias BOUNDARIES = "boundaries"
    alias CLIMATOLOGY_METEOROLOGY_ATMOSPHERE = "climatologyMeteorologyAtmosphere"
    alias ECONOMY = "economy"
    alias ELEVATION = "elevation"
    alias ENVIRONMENT = "environment"
    alias GEOSCIENTIFIC_INFORMATION = "geoscientificInformation"
    alias HEALTH = "health"
    alias IMAGERY_BASE_MAPS_EARTH_COVER = "imageryBaseMapsEarthCover"
    alias INTELLIGENCE_MILITARY = "intelligenceMilitary"
    alias INLAND_WATERS = "inlandWaters"
    alias LOCATION = "location"
    alias OCEANS = "oceans"
    alias PLANNING_CADASTRE = "planningCadastre"
    alias SOCIETY = "society"
    alias STRUCTURE = "structure"
    alias TRANSPORTATION = "transportation"
    alias UTILITIES_COMMUNICATION = "utilitiesCommunication"
    alias EXTRA_TERRESTRIAL = "extraTerrestrial"
    alias DISASTER = "disaster"


trait BrowseGraphic():
    """Graphic that provides an illustration of the dataset (should include a legend for the graphic, if applicable)."""

    fn file_name(self):
        """Name of the file that contains a graphic that provides an illustration of the dataset."""
        ...

    fn file_description(self) -> String:
        """Text description of the illustration."""
        ...

    fn file_type(self) -> String:
        """Format in which the illustration is encoded."""
        ...

    fn image_constraints(self) -> Sequence[Constraints]:
        """Restriction on access and/or use of browse graphic."""
        ...

    fn linkage(self) -> Sequence[OnlineResource]:
        """Link to browse graphic."""
        ...


trait KeywordClass():
    """Specification of a trait to categorize keywords in a domain-specific vocabulary that has a binding to a formal ontology."""

    fn class_name(self) -> String:
        """Character string to label the keyword category in natural language."""
        ...

    fn concept_identifier(self):
        """URI of concept in ontology specified by the ontology attribute; this concept is labeled by the className: CharacterString."""
        ...

    fn ontology(self) -> Citation:
        """A reference that binds the keyword trait to a formal conceptualization of a knowledge domain for use in semantic processingNOTE: Keywords in the associated MD_Keywords keyword list must be within the scope of this ontology."""
        ...


trait Keywords():
    """Keywords, their type and reference source. NOTE: When the resource described is a service, one instance of MD_Keyword shall refer to the service taxonomy defined in ISO 19119, 8.3)."""

    fn keyword(self) -> Sequence[String]:
        """Commonly used word(s) or formalised word(s) or phrase(s) used to describe the subject."""
        ...

    fn type(self) -> KeywordTypeCode:
        """Subject matter used to group similar keywords."""
        ...

    fn thesaurus_name(self) -> Citation:
        """Name of the formally registered thesaurus or a similar authoritative source of keywords."""
        ...

    fn keyword_class(self) -> KeywordClass:
        ...


trait Usage():
    """Brief description of ways in which the resource(s) is/are currently or has been used."""

    fn specific_usage(self) -> String:
        """Brief description of the resource and/or resource series usage."""
        ...

    fn usage_date_time(self) -> datetime:
        """Date and time of the first use or range of uses of the resource and/or resource series."""
        ...

    fn user_determined_limitations(self) -> String:
        """Applications, determined by the user for which the resource and/or resource series is not suitable."""
        ...

    fn user_contact_info(self) -> Sequence[Responsibility]:
        """Identification of and means of communicating with person(s) and organisation(s) using the resource(s)."""
        ...

    fn response(self) -> Sequence[String]:
        """Response to the user-determined limitationsE.G.. 'this has been fixed in version x'."""
        ...

    fn additional_documentation(self) -> Sequence[Citation]:
        ...

    fn identified_issues(self) -> Sequence[Citation]:
        ...


trait RepresentativeFraction():
    """Derived from ISO 19103 Scale where MD_RepresentativeFraction.denominator = 1 / Scale.measure And Scale.targetUnits = Scale.sourceUnits."""

    fn denominator(self) -> Int:
        """The number below the line in a vulgar fraction."""
        ...


trait Resolution():
    """Level of detail expressed as a scale factor, a distance or an angle."""

    fn equivalent_scale(self) -> RepresentativeFraction:
        """Level of detail expressed as the scale of a comparable hardcopy map or chart."""
        ...

    fn distance(self) -> Float64:
        """Horizontal ground sample distance."""
        ...

    fn vertical(self) -> Float64:
        """Vertical sampling distance."""
        ...

    fn angular_distance(self) -> Float64:
        """Angular sampling measure."""
        ...

    fn level_of_detail(self) -> String:
        """Brief textual description of the spatial resolution of the resource."""
        ...


trait AssociatedResource():
    """Associated resource information. NOTE: An associated resource is a dataset composed of a collection of datasets."""

    fn name(self) -> Citation:
        """Citation information about the associated resource."""
        ...

    fn association_type(self) -> AssociationTypeCode:
        """Type of relation between the resources."""
        ...

    fn initiative_type(self) -> InitiativeTypeCode:
        """Type of initiative under which the associated resource was produced. NOTE: the activity that resulted in the associated resource."""
        ...

    fn metadata_reference(self) -> Citation:
        """Reference to the metadata of the associated resource."""
        ...


trait Identification():
    """Basic information required to uniquely identify a resource or resources."""

    fn citation(self) -> Citation:
        """Citation for the resource(s)."""
        ...

    fn abstract(self) -> String:
        """Brief narrative summary of the content of the resource(s)."""
        ...

    fn purpose(self) -> String:
        """Summary of the intentions with which the resource(s) was developed."""
        ...

    fn credit(self) -> Sequence[String]:
        """Recognition of those who contributed to the resource(s)."""
        ...

    fn status(self) -> Sequence[ProgressCode]:
        """Status of the resource(s)."""
        ...

    fn point_of_contact(self) -> Sequence[Responsibility]:
        """Identification of, and means of communication with, person(s) and organisation(s) associated with the resource(s)."""
        ...

    fn spatial_representation_type(self) -> Sequence[SpatialRepresentationTypeCode]:
        """Method used to spatially represent geographic information."""
        ...

    fn spatial_resolution(self) -> Sequence[Resolution]:
        """Factor which provides a general understanding of the density of spatial data in the resource."""
        ...

    fn temporal_resolution(self):
        """Resolution of the resource with respect to time."""
        ...

    fn topic_category(self) -> Sequence[TopicCategoryCode]:
        """Main theme(s) of the resource."""
        ...

    fn extent(self) -> Sequence[Extent]:
        """Spatial and temporal extent of the resource."""
        ...

    fn additional_documentation(self) -> Sequence[Citation]:
        """Other documentation associated with the resource."""
        ...

    fn processing_level(self) -> Identifier:
        """Code that identifies the level of processing in the producers coding system of a resource eg. NOAA level 1B."""
        ...

    fn resource_maintenance(self) -> Sequence[MaintenanceInformation]:
        ...

    fn graphic_overview(self) -> Sequence[BrowseGraphic]:
        ...

    fn resource_format(self) -> Sequence[Format]:
        ...

    fn descriptive_keywords(self) -> Sequence[Keywords]:
        ...

    fn resource_specific_usage(self) -> Sequence[Usage]:
        ...

    fn resource_constraints(self) -> Sequence[Constraints]:
        ...

    fn associated_resource(self) -> Sequence[AssociatedResource]:
        ...


trait DataIdentification(Identification):
    """Information required to identify a resource."""

    fn default_locale(self):
        """Provides information about an alternatively used localized character string for a linguistic extension."""
        ...

    fn environment_description(self) -> String:
        """Description of the resource in the producer's processing environment, including items such as the software, the computer operating system, file name, and the dataset size."""
        ...

    fn supplemental_information(self) -> String:
        """Any other descriptive information about the resource."""
        ...
