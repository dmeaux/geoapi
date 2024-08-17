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

"""This is the citation module.

This module contains geographic metadata structures regarding metadata
citations derived from the ISO 19115-1:2014 international standard.
"""


struct DateTypeCode:
    alias CREATION = "creation"
    alias PUBLICATION = "publication"
    alias REVISION = "revision"
    alias EXPIRY = "expiry"
    alias LAST_UPDATE = "lastUpdate"
    alias LAST_REVISION = "lastRevision"
    alias NEXT_UPDATE = "nextUpdate"
    alias UNAVAILABLE = "unavailable"
    alias IN_FORCE = "inForce"
    alias ADOPTED = "adopted"
    alias DEPRECATED = "deprecated"
    alias SUPERSEDED = "superseded"
    alias VALIDITY_BEGINS = "validityBegins"
    alias VALIDITY_EXPIRES = "validityExpires"
    alias RELEASED = "released"
    alias DISTRIBUTION = "distribution"


struct OnLineFunctionCode:
    alias DOWNLOAD = "download"
    alias INFORMATION = "information"
    alias OFFLINE_ACCESS = "offlineAccess"
    alias ORDER = "order"
    alias SEARCH = "search"
    alias COMPLETE_METADATA = "completeMetadata"
    alias BROWSE_GRAPHIC = "browseGraphic"
    alias UPLOAD = "upload"
    alias EMAIL_SERVICE = "emailService"
    alias BROWSING = "browsing"
    alias FILE_ACCESS = "fileAccess"


struct PresentationFormCode:
    alias DOCUMENT_DIGITAL = "documentDigital"
    alias DOCUMENT_HARDCOPY = "documentHardcopy"
    alias IMAGE_DIGITAL = "imageDigital"
    alias IMAGE_HARDCOPY = "imageHardcopy"
    alias MAP_DIGITAL = "mapDigital"
    alias MAP_HARDCOPY = "mapHardcopy"
    alias MODEL_DIGITAL = "modelDigital"
    alias MODEL_HARDCOPY = "modelHardcopy"
    alias PROFILE_DIGITAL = "profileDigital"
    alias PROFILE_HARDCOPY = "profileHardcopy"
    alias TABLE_DIGITAL = "tableDigital"
    alias TABLE_HARDCOPY = "tableHardcopy"
    alias VIDEO_DIGITAL = "videoDigital"
    alias VIDEO_HARDCOPY = "videoHardcopy"
    alias AUDIO_DIGITAL = "audioDigital"
    alias AUDIO_HARDCOPY = "audioHardcopy"
    alias MULTIMEDIA_DIGITAL = "multimediaDigital"
    alias MULTIMEDIA_HARDCOPY = "multimediaHardcopy"
    alias PHYSICAL_OBJECT = "physicalObject"
    alias DIAGRAM_DIGITAL = "diagramDigital"
    alias DIAGRAM_HARDCOPY = "diagramHardcopy"


struct RoleCode:
    alias RESOURCE_PROVIDER = "resourceProvider"
    alias CUSTODIAN = "custodian"
    alias OWNER = "owner"
    alias USER = "user"
    alias DISTRIBUTOR = "distributor"
    alias ORIGINATOR = "originator"
    alias POINT_OF_CONTACT = "pointOfContact"
    alias PRINCIPAL_INVESTIGATOR = "principalInvestigator"
    alias PROCESSOR = "processor"
    alias PUBLISHER = "publisher"
    alias AUTHOR = "author"
    alias SPONSOR = "sponsor"
    alias CO_AUTHOR = "coAuthor"
    alias COLLABORATOR = "collaborator"
    alias EDITOR = "editor"
    alias MEDIATOR = "mediator"
    alias RIGHTS_HOLDER = "rightsHolder"
    alias CONTRIBUTOR = "contributor"
    alias FUNDER = "funder"
    alias STAKEHOLDER = "stakeholder"


struct TelephoneTypeCode:
    alias VOICE = "voice"
    alias FACSIMILE = "facsimile"
    alias SMS = "sms"


trait Series:
    """Information about the series, or aggregate resource, to which a resource belongs.
    """

    fn name(self) -> String:
        """Name of the series, or aggregate resource, of which the resource is a part.
        """
        ...

    fn issue_identification(self) -> String:
        """Information identifying the issue of the series."""
        ...

    fn page(self) -> String:
        """Details on which pages of the publication the article was published.
        """
        ...


trait Address:
    """Location of the responsible individual or organisation."""

    fn delivery_point(self) -> Tuple[String]:
        """Address line for the location (as described in ISO 11180, Annex A).
        """
        ...

    fn city(self) -> String:
        """City of the location."""
        ...

    fn administrative_area(self) -> String:
        """State, province of the location."""
        ...

    fn postal_code(self) -> String:
        """ZIP or other postal code."""
        ...

    fn country(self) -> String:
        """Country of the physical address."""
        ...

    fn electronic_mail_address(self) -> Tuple[String]:
        """Address of the electronic mailbox of the responsible organisation or individual.
        """
        ...


trait AddressCollectionElement(CollectionElement, Address):
    """
    Abstract collection element conforming to the Address trait.
    """

    ...


trait Telephone:
    """Telephone numbers for contacting the responsible individual or organisation.
    """

    fn number(self) -> String:
        """Telephone number by which individuals can contact responsible organisation or individual.
        """
        ...

    fn number_type(self) -> TelephoneTypeCode:
        """Type of telephone responsible organisation or individual."""
        ...


trait TelephoneCollectionElement(CollectionElement, Telephone):
    """
    Abstract collection element conforming to the Telephone trait.
    """

    ...


trait OnlineResource:
    """Information about on-line sources from which the resource, specification, or community profile name and extended metadata elements can be obtained.
    """

    fn linkage(self):
        """Location (address) for on-line access using a Uniform Resource Locator/Uniform Resource Identifier address or similar addressing scheme such as http://www.statkart.no/isotc211.
        """
        ...

    fn protocol(self) -> String:
        """Connection protocol to be used e.g. http, ftp, file."""
        ...

    fn application_profile(self) -> String:
        """Name of an application profile that can be used with the online resource.
        """
        ...

    fn name(self) -> String:
        """Name of the online resource."""
        ...

    fn description(self) -> String:
        """Detailed text description of what the online resource is/does."""
        ...

    fn function(self) -> OnLineFunctionCode:
        """Code for function performed by the online resource."""
        ...

    fn protocol_request(self) -> String:
        """Protocol used by the accessed resource."""
        ...


trait OnlineResourceCollectionElement(CollectionElement, OnlineResource):
    """
    Abstract collection element conforming to the OnlineResource trait.
    """

    ...


trait Contact:
    """Information required to enable contact with the responsible person and/or organisation.
    """

    fn phone[
        ElementType: TelephoneCollectionElement
    ](self) -> Tuple[ElementType]:
        """Telephone numbers at which the organisation or individual may be contacted.
        """
        ...

    fn address[
        ElementType: AddressCollectionElement
    ](self) -> Tuple[ElementType]:
        """Physical and email address at which the organisation or individual may be contacted.
        """
        ...

    fn online_resource[
        ElementType: OnlineResourceCollectionElement
    ](self) -> Tuple[ElementType]:
        """On-line information that can be used to contact the individual or organisation.
        """
        ...

    fn hours_of_service(self) -> Tuple[String]:
        """Time period (including time zone) when individuals can contact the organisation or individual.
        """
        ...

    fn contact_instructions(self) -> String:
        """Supplemental instructions on how or when to contact the individual or organisation.
        """
        ...

    fn contact_type(self) -> String:
        ...


trait ContactCollectionElement(CollectionElement, Contact):
    """
    Abstract collection element conforming to the Contact trait.
    """

    ...


trait Party:
    """Information about the individual and/or organisation of the party."""

    fn name(self) -> String:
        """Name of the party."""
        ...

    fn contact_info[
        ElementType: ContactCollectionElement
    ](self) -> Tuple[ElementType]:
        """Contact information for the party."""
        ...

    fn party_identifier[
        ElementType: IdentifierCollectionElement
    ](self) -> Tuple[ElementType]:
        """Identifier of the party."""
        ...


trait PartyCollectionElement(CollectionElement, Party):
    """
    Abstract collection element conforming to the Party trait.
    """

    ...


trait Responsibility:
    """Information about the party and their role."""

    fn role(self) -> RoleCode:
        """Function performed by the responsible party."""
        ...

    fn extent[ElementType: ExtentCollectionElement](self) -> Tuple[ElementType]:
        """Spatial or temporal extent of the role."""
        ...

    fn party[ElementType: PartyCollectionElement](self) -> Tuple[ElementType]:
        ...


trait ResponsibilityCollectionElement(CollectionElement, Responsibility):
    """
    Abstract collection element conforming to the Responsibility trait.
    """

    ...


trait Individual(Party):
    """Information about the party if the party is an individual."""

    fn position_name(self) -> String:
        """Position of the individual in an organisation."""
        ...


trait IndividualCollectionElement(CollectionElement, Individual):
    """
    Abstract collection element conforming to the Individual trait.
    """

    ...


trait Organisation(Party):
    """Information about the party if the party is an organisation."""

    fn logo(self) -> Sequence[BrowseGraphic]:
        """Graphic identifying organization."""
        ...

    fn individual[
        ElementType: IndividualCollectionElement
    ](self) -> Tuple[ElementType]:
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

    fn alternate_title(self) -> Tuple[String]:
        """Short name or other language name by which the cited information is known. Example: DCW as an alternative title for Digital Chart of the World.
        """
        ...

    fn date(self) -> Tuple[datetime]:
        """Reference date for the cited resource."""
        ...

    fn edition(self) -> String:
        """Version of the cited resource."""
        ...

    fn edition_date(self) -> datetime:
        """Date of the edition."""
        ...

    fn identifier[
        ElementType: IdentifierCollectionElement
    ](self) -> Tuple[ElementType]:
        """Value uniquely identifying an object within a namespace."""
        ...

    fn cited_responsible_party[
        ElementType: RepresentableCollectionElement
    ](self) -> Tuple[ElementType]:
        """Name and position information for an individual or organisation that is responsible for the resource.
        """
        ...

    fn presentation_form[
        ElementType: PresentationFormCode
    ](self) -> Tuple[ElementType]:
        """Mode in which the resource is represented."""
        ...

    fn series(self) -> Series:
        """Information about the series, or aggregate resource, of which the resource is a part.
        """
        ...

    fn other_citation_details(self) -> Tuple[String]:
        """Other information required to complete the citation that is not recorded elsewhere.
        """
        ...

    fn ISBN(self) -> String:
        """International Standard Book Number."""
        ...

    fn ISSN(self) -> String:
        """International Standard Serial Number."""
        ...

    fn online_resource[
        ElementType: OnlineResourceCollectionElement
    ](self) -> Tuple[ElementType]:
        """Online reference to the cited resource."""
        ...

    fn graphic(self) -> Sequence[BrowseGraphic]:
        """Citation graphic or logo for cited party."""
        ...


trait CitationCollectionElement(CollectionElement, Citation):
    """
    Abstract collection element conforming to the Citation trait.
    """

    ...


trait Identifier:
    """Value uniquely identifying an object within a namespace."""

    fn authority(self) -> Citation:
        """Citation for the code namespace and optionally the person or party responsible for maintenance of that namespace.
        """
        ...

    fn code(self) -> String:
        """Alphanumeric value identifying an instance in the namespace e.g. EPSG::4326.
        """
        ...

    fn code_space(self) -> String:
        """Identifier or namespace in which the code is valid."""
        ...

    fn version(self) -> String:
        """Version identifier for the namespace."""
        ...

    fn description(self) -> String:
        """Natural language description of the meaning of the code value E.G for codeSpace = EPSG, code = 4326: description = WGS-84" to "for codeSpace = EPSG, code = EPSG::4326: description = WGS-84.
        """
        ...


trait IdentifierCollectionElement(CollectionElement, Identifier):
    """
    Abstract collection element conforming to the Identifier trait.
    """

    ...
