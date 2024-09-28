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

"""This is the `citation` module.

This module contains geographic metadata structures regarding metadata
citations derived from the ISO 19115-1:2014 international standard.
"""
from collections import Optional

from opengis.metadata.extent import Extent, ExtentCollectionElement
from opengis.metadata.identification import (
    BrowseGraphic,
    BrowseGraphicCollectionElement,
)


struct DateTypeCode:
    """Identification of when a given event occurred."""

    alias CREATION = "creation"
    """Date identifies when the resource was brought into existence."""

    alias PUBLICATION = "publication"
    """Date identifies when the resource was issued."""

    alias REVISION = "revision"
    """Date identifies when the resource was examined or rexamined and improved
    or amended.
    """

    alias EXPIRY = "expiry"
    """Date identifies when resource expires."""

    alias LAST_UPDATE = "lastUpdate"
    """Date identifies when resource was last updated."""

    alias LAST_REVISION = "lastRevision"
    """Date identifies when resource was last reviewed."""

    alias NEXT_UPDATE = "nextUpdate"
    """Date identifies when resource will be next updated."""

    alias UNAVAILABLE = "unavailable"
    """Date identifies when resource became not available or obtainable."""

    alias IN_FORCE = "inForce"
    """Date identifies when resource became in force."""

    alias ADOPTED = "adopted"
    """Date identifies when resource was adopted."""

    alias DEPRECATED = "deprecated"
    """Date identifies when resource was deprecated."""

    alias SUPERSEDED = "superseded"
    """Date identifies when resource was superceded or replaced by another
    resource.
    """

    alias VALIDITY_BEGINS = "validityBegins"
    """Time at which the data are considered to become valid.

    alias NOTE: There could be quite a delay between creation and validity begins.
    """

    alias VALIDITY_EXPIRES = "validityExpires"
    """Time at which the data are no longer considered to be valid."""

    alias RELEASED = "released"
    """The date that the resource shall be released for public access."""

    alias DISTRIBUTION = "distribution"
    """Date identifies when an instance of the resource was distributed."""


struct OnLineFunctionCode:
    """Function performed by the resource."""

    alias DOWNLOAD = "download"
    """Online instructions for transferring data from one storage device or
    system to another.
    """
    alias INFORMATION = "information"
    """Online information about the resource."""

    alias OFFLINE_ACCESS = "offlineAccess"
    """Online instructions for requesting the resource from the provider."""

    alias ORDER = "order"
    """Online order process for obtaining the resource."""

    alias SEARCH = "search"
    """Online search interface for seeking out information about the resource.
    """

    alias COMPLETE_METADATA = "completeMetadata"
    """Complete metadata provided."""

    alias BROWSE_GRAPHIC = "browseGraphic"
    """Browse graphic provided."""

    alias UPLOAD = "upload"
    """Online resource upload capability provided."""

    alias EMAIL_SERVICE = "emailService"
    """Online email service provided."""

    alias BROWSING = "browsing"
    """Online browsing provided."""

    alias FILE_ACCESS = "fileAccess"
    """Online file access provided."""


struct PresentationFormCode:
    """Mode in which the data are represented."""

    alias DOCUMENT_DIGITAL = "documentDigital"
    """Digital representation of a primarily textual item (can contain
    illustrations also).
    """

    alias DOCUMENT_HARDCOPY = "documentHardcopy"
    """Representaiton of a primarily textual item (can contain illustrations
    also) on paper, photographic material, or other media.
    """

    alias IMAGE_DIGITAL = "imageDigital"
    """Likeness of natural or man-made features, objects, and activities acquired
    through the sensing of visual or any other segment of the electronic
    spectrum by sensors, such as thermal infrared and high resolution radar,
    and stored in digital format.
    """

    alias IMAGE_HARDCOPY = "imageHardcopy"
    """Likeness of natural or man-made features, objects, and activities acquired
    through the sensing of visual or any other segment of the electronic
    spectrum by sensors, such as thermal infrared and high resolution radar,
    and stored on paper, photographic material, or other media for use
    directly by the human user.
    """

    alias MAP_DIGITAL = "mapDigital"
    """Map represented in raster or vector form."""

    alias MAP_HARDCOPY = "mapHardcopy"
    """Map printed on paper, photographic material, or other media for use
    directly by the human user.
    """

    alias MODEL_DIGITAL = "modelDigital"
    """Multi-dimensional digital representation of a feature, process, etc."""

    alias MODEL_HARDCOPY = "modelHardcopy"
    """3-dimensional, physical model."""

    alias PROFILE_DIGITAL = "profileDigital"
    """Vertical cross-section in digital form."""

    alias PROFILE_HARDCOPY = "profileHardcopy"
    """Vertical cross-section on paper, etc."""

    alias TABLE_DIGITAL = "tableDigital"
    """"
    Digital representation of facts or figures systematically displayed,
    especially in columns.
    """

    alias TABLE_HARDCOPY = "tableHardcopy"
    """"
    Representation of facts or figures systematically displayed, especially in
    columns, printed on paper, photographic material, or other media.
    """

    alias VIDEO_DIGITAL = "videoDigital"
    """Digital video recording."""

    alias VIDEO_HARDCOPY = "videoHardcopy"
    """Video recording on film."""

    alias AUDIO_DIGITAL = "audioDigital"
    """Digital audio recording."""

    alias AUDIO_HARDCOPY = "audioHardcopy"
    """Audio recroding delivered by analog media, such as a magnetic tape."""

    alias MULTIMEDIA_DIGITAL = "multimediaDigital"
    """Information representation using simultaneously various digital modes
    text, sound, image.
    """

    alias MULTIMEDIA_HARDCOPY = "multimediaHardcopy"
    """Information representation using simultaneously various analog modes
    text, sound, image.
    """

    alias PHYSICAL_OBJECT = "physicalObject"
    """A physical object.

    alias Example:
        Rock or mineral sample, microscope slide.
    """

    alias DIAGRAM_DIGITAL = "diagramDigital"
    """Information represented graphically by charts such as pie chart,
    bar chart, and other type of diagrms and recorded in digital format.
    """

    alias DIAGRAM_HARDCOPY = "diagramHardcopy"
    """Information represented graphically by charts such as pie chart,
    bar chart, and other type of diagrams and printed on paper, photographic
    material, or other media.
    """


struct RoleCode:
    """Function performed by the responsible party."""

    alias RESOURCE_PROVIDER = "resourceProvider"
    """Party that supplies the resource."""

    alias CUSTODIAN = "custodian"
    """Party that accepts accountability and responsibility for the resource and
    ensures appropriate care an maintenance of the resource.
    """

    alias OWNER = "owner"
    """Party that owns the resource."""

    alias USER = "user"
    """Party who uses the resource."""

    alias DISTRIBUTOR = "distributor"
    """Party who distributes the resource."""

    alias ORIGINATOR = "originator"
    """Party who created the resource."""

    alias POINT_OF_CONTACT = "pointOfContact"
    """Party who can be contactedfor acquiring knowledge about or acquisition of
    the resource.
    """

    alias PRINCIPAL_INVESTIGATOR = "principalInvestigator"
    """Key party responsible for gathering information and conducting research.
    """

    alias PROCESSOR = "processor"
    """Party who has processed the data in a manner such that the resource has
    been modified.
    """

    alias PUBLISHER = "publisher"
    """Party who published resource."""

    alias AUTHOR = "author"
    """Party who authored the resource."""

    alias SPONSOR = "sponsor"
    """Party who speaks for the resource."""

    alias CO_AUTHOR = "coAuthor"
    """Party who jointly authors the resource."""

    alias COLLABORATOR = "collaborator"
    """Party who assists with the generation of the resource other than the
    principal investigator.
    """

    alias EDITOR = "editor"
    """Party who reviewed or modified the resource to improve the content.
    """

    alias MEDIATOR = "mediator"
    """A trait of entity that mediates access to the resource and for whom the
    resource is intended or useful.
    """

    alias RIGHTS_HOLDER = "rightsHolder"
    """Party owning or managing the rights over the resource."""

    alias CONTRIBUTOR = "contributor"
    """Party contributing to the resource."""

    alias FUNDER = "funder"
    """Party providing monetary support for the resource."""

    alias STAKEHOLDER = "stakeholder"
    """Party who has an interest in the resource or the use of the resource."""


struct TelephoneTypeCode:
    """Type of telephone."""

    alias VOICE = "voice"
    """Telephone provides voice service."""

    alias FACSIMILE = "facsimile"
    """Telephone provides facsimile service."""

    alias SMS = "sms"
    """Telephone provides sms service."""


trait Series:
    """Information about the series, or aggregate resource, to which a resource
    belongs."""

    fn name(self) -> Optional[String]:
        """Name of the series, or aggregate resource, of which the resource is a
        part.
        """
        ...

    fn issue_identification(self) -> Optional[String]:
        """Information identifying the issue of the series."""
        ...

    fn page(self) -> Optional[String]:
        """Details on which pages of the publication the article was published.
        """
        ...


trait Address:
    """Location of the responsible individual or organisation."""

    fn delivery_point(self) -> Optional[Tuple[String]]:
        """Address line for the location (as described in ISO 11180, Annex A).
        """
        ...

    fn city(self) -> Optional[String]:
        """City of the location."""
        ...

    fn administrative_area(self) -> Optional[String]:
        """State, province of the location."""
        ...

    fn postal_code(self) -> Optional[String]:
        """ZIP or other postal code."""
        ...

    fn country(self) -> Optional[String]:
        """Country of the physical address."""
        ...

    fn electronic_mail_address(self) -> Optional[Tuple[String]]:
        """Address of the electronic mailbox of the responsible organisation or
        individual.
        """
        ...


trait Telephone:
    """Telephone numbers for contacting the responsible individual or
    organisation."""

    fn number(self) -> String:
        """Telephone number by which individuals can contact responsible
        organisation or individual.
        """
        ...

    fn number_type(self) -> Optional[TelephoneTypeCode]:
        """Type of telephone responsible organisation or individual."""
        ...


trait OnlineResource:
    """Information about on-line sources from which the resource, specification,
    or community profile name and extended metadata elements can be obtained."""

    fn linkage(self) -> String:
        """Location (address) for on-line access using a Uniform Resource Locator/
        Uniform Resource Identifier address or similar addressing scheme such
        as http://www.statkart.no/isotc211.
        """
        ...

    fn protocol(self) -> Optional[String]:
        """Connection protocol to be used e.g. http, ftp, file."""
        ...

    fn application_profile(self) -> Optional[String]:
        """Name of an application profile that can be used with the online
        resource.
        """
        ...

    fn name(self) -> Optional[String]:
        """Name of the online resource."""
        ...

    fn description(self) -> Optional[String]:
        """Detailed text description of what the online resource is/does."""
        ...

    fn function(self) -> Optional[OnLineFunctionCode]:
        """Code for function performed by the online resource."""
        ...

    fn protocol_request(self) -> Optional[String]:
        """Request used to access the resource depending on the protocol
        (to be used mainly for POST requests).

        Protocol used by the accessed resource.

        Example POST/XML:

        ```
        <Get Features service = "WFS"
                     version="2.0.0"
                     outputFormat="application/gml+xml; version=3.2"
                     xmlns=http://www.opengis.net/wfs/2.0
                     xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance
                     xsi:schemaLocation="http://www.opengis.net/wfs/2.0
                        http://schemas.opengis.net/wfs/2.0.0/wfs.xsd">
        <Query typeNames="Roads" />
        </GetFeatures>
        ```
        """
        ...


trait Contact:
    """Information required to enable contact with the responsible person and/or
    organisation."""

    fn phone(self) -> Optional[Tuple[Telephone]]:
        """Telephone numbers at which the organisation or individual may be
        contacted.
        """
        ...

    fn address(self) -> Optional[Tuple[Address]]:
        """Physical and email address at which the organisation or individual may
        be contacted.
        """
        ...

    fn online_resource(self) -> Optional[Tuple[OnlineResource]]:
        """On-line information that can be used to contact the individual or
        organisation.
        """
        ...

    fn hours_of_service(self) -> Optional[Tuple[String]]:
        """Time period (including time zone) when individuals can contact the
        organisation or individual.
        """
        ...

    fn contact_instructions(self) -> Optional[String]:
        """Supplemental instructions on how or when to contact the individual or
        organisation.
        """
        ...

    fn contact_type(self) -> Optional[String]:
        """Type of the contact."""
        ...


trait Party:
    """Information about the individual and/or organisation of the party."""

    fn name(self) -> Optional[String]:
        """Name of the party.

        MANDATORY:
            If `logo` and `position_name`are `None`.
        """
        ...

    fn contact_info(self) -> Tuple[Contact]:
        """Contact information for the party."""
        ...

    fn party_identifier(self) -> Optional[Tuple["Identifier"]]:
        """Identifier of the party.

        MANDATORY:
            If `name` and `logo` are `None`.
        """
        ...


trait Responsibility:
    """Information about the party and their role."""

    fn role(self) -> RoleCode:
        """Function performed by the responsible party."""
        ...

    fn extent(self) -> Optional[Tuple["Extent"]]:
        """Spatial or temporal extent of the role."""
        ...

    fn party(self) -> Tuple[Party]:
        """Information about the Party."""
        ...


trait Individual(Party):
    """Information about the party if the party is an individual."""

    fn position_name(self) -> Optional[String]:
        """Position of the individual in an organisation.

        MANDATORY:
            If `name` and `logo` are `None`.
        """
        ...


trait Organisation(Party):
    """Information about the party if the party is an organisation."""

    fn logo(self) -> Tuple[BrowseGraphic]:
        """Graphic identifying organisation.

        MANDATORY:
            If `name` and `position_name`are `None`.
        """
        ...

    fn individual(self) -> Optional[Tuple[Individual]]:
        """Individuals belonging to the Organisation."""
        ...


trait Date:
    """Reference date and event used to describe it."""

    fn date(self) -> datetime:
        """Reference date for the cited resource."""
        ...

    fn date_type(self) -> DateTypeCode:
        """Event used for reference date."""
        ...


trait Citation:
    """Standardized resource reference."""

    fn title(self) -> String:
        """Name by which the cited resource is known."""
        ...

    fn alternate_title(self) -> Optional[Tuple[String]]:
        """Short name or other language name by which the cited information is
        known.

        Example:
            'DCW' as an alternative title for Digital Chart of the World.
        """
        ...

    fn date(self) -> Optional[Tuple[Date]]:
        """Reference date for the cited resource."""
        ...

    fn edition(self) -> Optional[String]:
        """Version of the cited resource."""
        ...

    fn edition_date(self) -> Optional[datetime]:
        """Date of the edition."""
        ...

    fn identifier(self) -> Optional[Tuple["Identifier"]]:
        """Value uniquely identifying an object within a namespace."""
        ...

    fn cited_responsible_party(self) -> Optional[Tuple[Responsibility]]:
        """Name and position information for an individual or organisation that
        is responsible for the resource.
        """
        ...

    fn presentation_form(self) -> Optional[Tuple[PresentationFormCode]]:
        """Mode in which the resource is represented."""
        ...

    fn series(self) -> Optional[Series]:
        """Information about the series, or aggregate resource, of which the
        resource is a part.
        """
        ...

    fn other_citation_details(self) -> Optional[Tuple[String]]:
        """Other information required to complete the citation that is not
        recorded elsewhere.
        """
        ...

    fn isbn(self) -> Optional[String]:
        """International Standard Book Number."""
        ...

    fn issn(self) -> Optional[String]:
        """International Standard Serial Number."""
        ...

    fn online_resource(self) -> Optional[Tuple[OnlineResource]]:
        """Online reference to the cited resource."""
        ...

    fn graphic(self) -> Optional[Tuple["BrowseGraphic"]]:
        """Citation graphic or logo for cited party."""
        ...


trait Identifier:
    """Value uniquely identifying an object within a namespace."""

    fn authority(self) -> Optional[Citation]:
        """The person or party responsible for maintenance of the namespace.

        Citation for the code namespace and optionally the person or party
        responsible for maintenance of that namespace.
        """
        ...

    fn code(self) -> String:
        """Alphanumeric value identifying an instance in the namespace.

        NOTE: Avoid characters that are not legal in URLs.

        Example:
            EPSG::4326.
        """
        ...

    fn code_space(self) -> Optional[String]:
        """Identifier or namespace in which the code is valid."""
        ...

    fn version(self) -> Optional[String]:
        """Version identifier for the namespace."""
        ...

    fn description(self) -> Optional[String]:
        """Natural language description of the meaning of the code value.

        Example:
            For code_space = EPSG, code = 4326, description = WGS-84.
        """
        ...
