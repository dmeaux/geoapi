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

# author: OGC Topic 11 (for abstract model and documentation), David Meaux

"""This is the `identification` module.

This module contains geographic metadata structures regarding identification
information codelists and common base classes derived from the
ISO 19115-1:2014 international standard.
"""


from collections import Optional

from opengis.metadata.citation import (
    OnlineResource,
    Citation,
    Responsibility,
    Identifier,
)
from opengis.metadata.constraints import Constraints
from opengis.metadata.distribution import Format
from opengis.metadata.extent import Extent
from opengis.metadata.maintenance import MaintenanceInformation
from opengis.metadata.representation import SpatialRepresentationTypeCode


struct AssociationTypeCode:
    """Justification for the correlation of two resources."""

    alias CROSS_REFERENCE = "crossReference"
    """Reference from one resource to another."""

    alias LARGER_WORK_CITATION = "largerWorkCitation"
    """Reference to a master resource of which this one is a part."""

    alias PART_OF_SEAMLESS_DATABASE = "partOfSeamlessDatabase"
    """Part of same structured set of data held in a computer."""

    # deprecated Removed in ISO 19115:2014.
    # alias SOURCE = "source"
    # """
    # Mapping and charting information from which the dataset content
    # originates.
    # """

    alias STEREO_MATE = "stereoMate"
    """Part of a set of imagery that when used together, provides
    three-dimensional images.
    """

    alias IS_COMPOSED_OF = "isComposedOf"
    """Reference to resources that are parts of this resource."""

    alias COLLECTIVE_TITLE = "collectiveTitle"
    """Common title for a collection of resources.

    alias NOTE: Title identifies elements of a series collectively, combined with
    information about what volumes are available at the source cite.
    """

    alias SERIES = "series"
    """Associated through a common heritage such as produced to a common product
    specification.
    """

    alias DEPENDENCY = "dependency"
    """Associated through a dependency."""

    alias REVISION_OF = "revisionOf"
    """Resource is a revision of associated resource."""


struct InitiativeTypeCode:
    """Type of aggregation activity in which resources are related."""

    alias CAMPAIGN = "campaign"
    """Series of organized planned actions."""

    alias COLLECTION = "collection"
    """Accumulation of resources assembled for a specific purpose."""

    alias EXERCISE = "exercise"
    """Specific performance of a function or group of functions."""

    alias EXPERIMENT = "experiment"
    """Process designed to find if something is effective or valid."""

    alias INVESTIGATION = "investigation"
    """Search or systematic inquiry."""

    alias MISSION = "mission"
    """Specific operation of a data collection system."""

    alias SENSOR = "sensor"
    """Device or piece of equipment which detects or records."""

    alias OPERATION = "operation"
    """Action that is part of a series of actions."""

    alias PLATFORM = "platform"
    """Vehicle or other support base that holds a sensor."""

    alias PROCESS = "process"
    """Method of doing something involving a number of steps."""

    alias PROGRAM = "program"
    """Specific planned activity."""

    alias PROJECT = "project"
    """Organized undertaking, research, or development."""

    alias STUDY = "study"
    """Examination or investigation."""

    alias TASK = "task"
    """Piece of work."""

    alias TRIAL = "trial"
    """Process of testing to discover or demonstrate something."""


struct KeywordTypeCode:
    """Methods used to group similar keywords."""

    alias DISCIPLINE = "discipline"
    """Keyword identifies a branch of instruction or specialized learning."""

    alias PLACE = "place"
    """Keyword identifies a location."""

    alias STRATUM = "stratum"
    """Keyword identifies the layer(s) of any deposited substance or levels
    within an ordered system.
    """

    alias TEMPORAL = "temporal"
    """Keyword identifies a time period related to the resource."""

    alias THEME = "theme"
    """Keyword identifies a particular subject or topic."""

    alias DATA_CENTRE = "dataCentre"
    """Keyword identifies a repository or archive that manages and
    distributes data.
    """

    alias FEATURE_TYPE = "featureType"
    """Keyword identifies a resource containing or about a collection of feature
    instances with common characteristics.
    """

    alias INSTRUMENT = "instrument"
    """Keyword identifies a device used to measure or compare physical properties.
    """

    alias PLATFORM = "platform"
    """Keyword identifies a structure upon which an instrument is mounted."""

    alias PROCESS = "process"
    """Keyword identifies a series of actions or natural occurrences."""

    alias PROJECT = "project"
    """Keyword identifies an endeavour undertaken to create or modify a product
    or service.
    """

    alias SERVICE = "service"
    """Keyword identifies an activity carried out by one party for the benefit
    of another.
    """

    alias PRODUCT = "product"
    """Keyword identifies a type of product."""

    alias SUB_TOPIC_CATEGORY = "subTopicCategory"
    """Refinement of a topic category for the purpose of geographic
    data classification.
    """

    alias TAXON = "taxon"
    """Keyword identifies a taxonomy of the resource."""


struct ProgressCode:
    """Status of the resource."""

    alias COMPLETED = "completed"
    """Has been completed."""

    alias HISTORICAL_ARCHIVE = "historicalArchive"
    """Stored in an offline storage facility."""

    alias OBSOLETE = "obsolete"
    """No longer relevant."""

    alias ON_GOING = "onGoing"
    """Continually being updated."""

    alias PLANNED = "planned"
    """Fixed date has been established upon or by which the resource will be
    created or updated.
    """

    alias REQUIRED = "required"
    """Needs to be generated or updated."""

    alias UNDER_DEVELOPMENT = "underDevelopment"
    """Currently in the process of being created."""

    alias FINAL = "final"
    """Progress concluded and no changes will be accepted."""

    alias PENDING = "pending"
    """Committed to, but not yet addressed."""

    alias RETIRED = "retired"
    """Item is no longer recommended for use. It has not been superseded
    by another item.
    """

    alias SUPERSEDED = "superseded"
    """Replaced by new."""

    alias TENTATIVE = "tentative"
    """Provisional changes likely before resource becomes final or complete."""

    alias VALID = "valid"
    """Acceptable under specific conditions."""

    alias ACCEPTED = "accepted"
    """Agreed to by sponsor."""

    alias NOT_ACCEPTED = "notAccepted"
    """Rejected by sponsor."""

    alias WITHDRAWN = "withdrawn"
    """Removed from consideration."""

    alias PROPOSED = "proposed"
    """Suggested that development needs to be undertaken."""

    alias DEPRECATED = "deprecated"
    """Resource superseded and will become obsolete, use only
    for historical purposes.
    """


struct TopicCategoryCode:
    """High-level geographic data thematic classification to assist in the
    grouping and search of available geographic datasets.

    alias NOTE 1: Can be used to group keywords as well. Listed examples are not
    exhaustive.

    alias NOTE 2: Is is understto there are overlaps between general categories and
    the user is encouraged to select the one most appropriate.
    """

    alias FARMING = "farming"
    """Rearing of animals and/or cultivation of plants.

    alias Examples: Agriculture, irrigation, aquaculture, plantations, herding,
    pests and diseases affecting crops and livestock.
    """

    alias BIOTA = "biota"
    """Flora and/or fauna in natural environment.

    alias Examples: Wildlife, vegetation, biological sciences, ecology, wilderness,
    sealife, wetlands, habitat.
    """

    alias BOUNDARIES = "boundaries"
    """Legal land descriptions, maritime boundaries.

    alias Examples: Political and administrative boundaries, territorial seas, EEZ,
    port security zones.
    """

    alias CLIMATOLOGY_METEOROLOGY_ATMOSPHERE = "climatologyMeteorologyAtmosphere"
    """Processes and phenomena of the atmosphere.

    alias Examples: Cloud cover, weather, climate, atmospheric conditions,
    climate change, precipitation.
    """

    alias ECONOMY = "economy"
    """Economic activities, conditions and employment.

    alias Examples: Production, labour, revenue, commerce, industry, tourism and
    ecotourism, forestry, fisheries, commercial or subsistence hunting,
    exploration and exploitation of resources such as minerals, oil and gas.
    """

    alias ELEVATION = "elevation"
    """Height above or below a vertical datum.

    alias Examples: Altitude, bathymetry, digital elevation models, slope,
    derived products.
    """

    alias ENVIRONMENT = "environment"
    """Environmental resources, protection and conservation.

    alias Examples: Environmental pollution, waste storage and treatment,
    environmental impact assessment, monitoring environmental risk,
    nature reserves, landscape.
    """

    alias GEOSCIENTIFIC_INFORMATION = "geoscientificInformation"
    """Information pertaining to earth sciences.

    alias Examples: Geophysical features and processes, geology, minerals,
    sciences dealing with the composition, structure and origin of the
    Earth's rocks, risks of earthquakes, volcanic activity, landslides,
    gravity information, soils, permafrost, hydrogeology, erosion.
    """

    alias HEALTH = "health"
    """Health, health services, human ecology, and safety.

    alias Examples: Disease and illness, factors affecting health, hygiene,
    substance abuse, mental and physical health, health services.
    """

    alias IMAGERY_BASE_MAPS_EARTH_COVER = "imageryBaseMapsEarthCover"
    """Base maps.

    alias Examples: Land cover, topographic maps, imagery, unclassified images,
    annotations.
    """

    alias INTELLIGENCE_MILITARY = "intelligenceMilitary"
    """Military bases, structures, activities.

    alias Examples: Barracks, training grounds, military transportation,
    information collection.
    """

    alias INLAND_WATERS = "inlandWaters"
    """Inland water features, drainage systems and their characteristics.

    alias Examples: Rivers and glaciers, salt lakes, water utilization plans, dams,
    currents, floods, water quality, hydrologic information.
    """

    alias LOCATION = "location"
    """Positional information and services.

    alias Examples: Addresses, geodetic networks, control points, postal zones and
    services, place names.
    """

    alias OCEANS = "oceans"
    """Features and characteristics of salt water bodies (excluding
    inland waters).

    alias Examples: Tides, tsunamis, coastal information, reefs.
    """

    alias PLANNING_CADASTRE = "planningCadastre"
    """Information used for appropriate actions for future use of the land.

    alias Examples: Land use maps, zoning maps, cadastral surveys, land ownership.
    """

    alias SOCIETY = "society"
    """Characteristics of society and cultures.

    alias Examples: Settlements, anthropology, archaeology, education,
    traditional beliefs, manners and customs, demographic data,
    recreational areas and activities, social impact assessments,
    crime and justice, census information.
    """

    alias STRUCTURE = "structure"
    """Man-made construction.

    alias Examples: Buildings, museums, churches, factories, housing, monuments,
    shops, towers.
    """

    alias TRANSPORTATION = "transportation"
    """Means and aids for conveying persons and/or goods.

    alias Examples: Roads, airports/airstrips, shipping routes, tunnels,
    nautical charts, vehicle or vessel location, aeronautical charts,
    railways.
    """

    alias UTILITIES_COMMUNICATION = "utilitiesCommunication"
    """Energy, water and waste systems and communications infrastructure
    and services.

    alias Examples: Hydroelectricity, geothermal, solar and nuclear sources
    of energy, water purification and distribution, sewage collection and
    disposal, electricity and gas distribution, data communication,
    telecommunication, radio, communication networks.
    """

    alias EXTRA_TERRESTRIAL = "extraTerrestrial"
    """Region more than 100 km above the surface of the Earth."""

    alias DISASTER = "disaster"
    """Information related to disasters.

    alias Examples: Site of the disaster, evacuation zone,
    disaster-prevention facility, disaster relief activities.
    """


trait BrowseGraphic:
    """Graphic that provides an illustration of a resource/dataset

    NOTE:
        Should include a legend for the graphic, if applicable.

    Example:
        A dataset, an organisation logo, security constraint, or citation
        graphic."""

    fn file_name(self) -> String:
        """Name of the file that contains a graphic that provides an illustration
        of the resource/dataset.
        """
        ...

    fn file_description(self) -> Optional[String]:
        """Text description of the illustration."""
        ...

    fn file_type(self) -> Optional[String]:
        """Format in which the illustration is encoded.

        Example:
            EPS, GIF, JPEG, PBM, PS, TIFF, PDF.
        """
        ...

    fn image_constraints(self) -> Optional[Tuple[Constraints]]:
        """Restriction on access and/or use of browse graphic."""
        ...

    fn linkage(self) -> Optional[Tuple[OnlineResource]]:
        """Link to browse graphic."""
        ...


trait KeywordClass:
    """Specification of a trait to categorize keywords in a domain-specific
    vocabulary that has a binding to a formal ontology."""

    fn class_name(self) -> String:
        """Character string to label the keyword category in natural language.
        """
        ...

    fn concept_identifier(self) -> Optional[String]:
        """URI (as a string) of concept in ontology specified by the ontology
        attribute; this concept is labeled by a `str`.
        """
        ...

    fn ontology(self) -> Citation:
        """A reference that binds the keyword trait to a formal conceptualization
        of a knowledge domain for use in semantic processing NOTE: Keywords in
        the associated `Keywords` keyword list must be within the scope of
        this ontology.
        """
        ...


trait Keywords:
    """Keywords, their type and reference source.

    NOTE: When the resource described is a service, one instance of `Keyword`
    shall refer to the service taxonomy defined in ISO 19119, 8.3)."""

    fn keyword(self) -> Tuple[String]:
        """Commonly used word(s) or formalised word(s) or phrase(s) used to
        describe the subject.
        """
        ...

    fn type(self) -> Optional[KeywordTypeCode]:
        """Subject matter used to group similar keywords."""
        ...

    fn thesaurus_name(self) -> Optional[Citation]:
        """Name of the formally registered thesaurus or a similar authoritative
        source of keywords.
        """
        ...

    fn keyword_class(self) -> Optional[KeywordClass]:
        """Association of an `Keywords` instance with an `KeywordClass` to
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
        ...


trait Usage:
    """Brief description of ways in which the resource(s) is/are currently or has
    been used."""

    fn specific_usage(self) -> String:
        """Brief description of the resource and/or resource series usage."""
        ...

    fn usage_date_time(self) -> Optional[Tuple[datetime]]:
        """Date and time of the first use or range of uses of the resource and/or
        resource series.
        """
        ...

    fn user_determined_limitations(self) -> String:
        """Applications, determined by the user for which the resource and/or
        resource series is not suitable.
        """
        ...

    fn user_contact_info(self) -> Optional[Tuple[Responsibility]]:
        """Identification of and means of communicating with person(s) and
        organisation(s) using the resource(s).
        """
        ...

    fn response(self) -> Optional[Tuple[String]]:
        """Response to the user-determined limitations, e.g., 'This has been fixed
        in version x.'
        """
        ...

    fn additional_documentation(self) -> Optional[Tuple[Citation]]:
        """Publications that describe usage of data."""
        ...

    fn identified_issues(self) -> Optional[Tuple[Citation]]:
        """Citation of a description of known issues associated with the resource
        along with proposed solutions if available.
        """
        ...


trait RepresentativeFraction:
    """Derived from ISO 19103 Scale where
    `denominator` = 1 / `Scale.measure`
    and `Scale.target_units` = `Scale.source_units`."""

    fn denominator(self) -> Int:
        """The number below the line in a vulgar fraction.

        Domain:
            > 0
        """
        ...


trait Resolution:
    """Level of detail expressed as a scale factor, a distance, or an angle."""

    fn equivalent_scale(self) -> Optional[RepresentativeFraction]:
        """Level of detail expressed as the scale of a comparable hardcopy map or
        chart.

        MANDATORY:
            If `distance`, `vertical`, `angular_distance`,
            or `level_of_detail` not documented.
        """
        ...

    fn distance(self) -> Optional[Distance]:
        """Horizontal ground sample distance.

        MANDATORY:
            If `equivalent_scale`, `vertical`, `angular_distance`,
            or `level_of_detail` not documented.
        """
        ...

    fn vertical(self) -> Optional[Distance]:
        """Vertical sampling distance.

        MANDATORY:
            If `equivalent_scale`, `distance`, `angular_distance`,
            or `level_of_detail` not documented.
        """
        ...

    fn angular_distance(self) -> Optional[Angle]:
        """Angular sampling measure.

        MANDATORY:
            If `equivalent_scale`, `distance`, `vertical`,
            or `level_of_detail` not documented.
        """
        ...

    fn level_of_detail(self) -> Optional[String]:
        """Brief textual description of the spatial resolution of the resource.

        MANDATORY:
            If `equivalent_scale`, `distance`, `vertical`,
            or `angular_distance` not documented.
        """
        ...


trait AssociatedResource:
    """Associated resource information.

    NOTE: An associated resource is a dataset composed of a collection
    of datasets."""

    fn name(self) -> Optional[Citation]:
        """Citation information about the associated resource.

        MANDATORY:
            If `metadata_reference` not documented.
        """
        ...

    fn association_type(self) -> AssociationTypeCode:
        """Type of relation between the resources."""
        ...

    fn initiative_type(self) -> Optional[InitiativeTypeCode]:
        """Type of initiative under which the associated resource was produced.

        NOTE: the activity that resulted in the associated resource.
        """
        ...

    fn metadata_reference(self) -> Optional[Citation]:
        """Reference to the metadata of the associated resource.

        MANDATORY:
            If `name` not documented.
        """
        ...


trait Identification:
    """Basic information required to uniquely identify a resource or resources.
    """

    fn citation(self) -> Citation:
        """Citation for the resource(s)."""
        ...

    fn abstract(self) -> String:
        """Brief narrative summary of the content of the resource(s)."""
        ...

    fn purpose(self) -> Optional[String]:
        """Summary of the intentions with which the resource(s) was developed.
        """
        ...

    fn credit(self) -> Optional[Tuple[String]]:
        """Recognition of those who contributed to the resource(s)."""
        ...

    fn status(self) -> Optional[Tuple[ProgressCode]]:
        """Status of the resource(s)."""
        ...

    fn point_of_contact(self) -> Optional[Tuple[Responsibility]]:
        """Identification of, and means of communication with, person(s) and
        organisation(s) associated with the resource(s).
        """
        ...

    fn spatial_representation_type(
        self,
    ) -> Optional[Tuple[SpatialRepresentationTypeCode]]:
        """Method used to spatially represent geographic information."""
        ...

    fn spatial_resolution(self) -> Optional[Tuple[Resolution]]:
        """Factor which provides a general understanding of the density of
        spatial data in the resource.
        """
        ...

    fn temporal_resolution(self) -> Optional[Tuple[timedelta]]:
        """Smallest resolvable temporal period in a resource."""
        ...

    fn topic_category(self) -> Optional[Tuple[TopicCategoryCode]]:
        """Main theme(s) of the resource.

        MANDATORY:
            If `Metadata.metadata_scope.resource_scope` == 'dataset'
            OR `Metadata.metadata_scope.resource_scope` == 'series'.
        """
        ...

    fn extent(self) -> Optional[Tuple[Extent]]:
        """Spatial and temporal extent of the resource.

        MANDATORY:
            If `Metadata.metadata_scope.resource_scope` == 'dataset'
            then `extent.geographic_element.GeographicBoundingBox`
            or  `extent.geographic_element.Geographicdescription` is required.
        """
        ...

    fn additional_documentation(self) -> Optional[Tuple[Citation]]:
        """Other documentation associated with the resource, e.g.,
        Related articles, publications, user guides, data dictionaries.
        """
        ...

    fn processing_level(self) -> Optional[Identifier]:
        """Code that identifies the level of processing in the producers coding
        system of a resource, e.g., NOAA level 1B.
        """
        ...

    fn resource_maintenance(self) -> Optional[Tuple[MaintenanceInformation]]:
        """Information about the frequency of resource updates and the scope of
        those updates.
        """
        ...

    fn graphic_overview(self) -> Optional[Tuple[BrowseGraphic]]:
        """Graphic that illustrates the resource (should include a legend for
        the graphic).
        """
        ...

    fn resource_format(self) -> Optional[Tuple[Format]]:
        """Description of the format of the resource."""
        ...

    fn descriptive_keywords(self) -> Optional[Tuple[Keywords]]:
        """Category keywords, their type and reference source."""
        ...

    fn resource_specific_usage(self) -> Optional[Tuple[Usage]]:
        """Basic information about specific application(s) for which the resource
        has been or is being used by different users.
        """
        ...

    fn resource_constraints(self) -> Optional[Tuple[Constraints]]:
        """Information about constraints which apply to the resource."""
        ...

    fn associated_resource(self) -> Optional[Tuple[AssociatedResource]]:
        """Associated resource information."""
        ...


trait DataIdentification(Identification):
    """Information required to identify a resource."""

    fn default_locale(self) -> Optional[String]:
        """Language and character set used within the resource. A string
        conforming to IETF BCP 47.

        MANDATORY:
            If a language is used in the resource.
        """
        ...

    fn other_locale(self) -> Optional[Tuple[String]]:
        """Alternate localised language(s) and character set(s) used within
        the resource. A string conforming to IETF BCP 47.
        """
        ...

    fn environment_description(self) -> Optional[String]:
        """Description of the resource in the producer's processing environment,
        including items such as the software, the computer operating system,
        file name, and the dataset size.
        """
        ...

    fn supplemental_information(self) -> Optional[String]:
        """AnyType other descriptive information about the resource."""
        ...
