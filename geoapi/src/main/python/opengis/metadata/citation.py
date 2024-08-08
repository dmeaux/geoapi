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
"""This is the citation module.

This module contains geographic metadata structures regarding metadata
citations derived from the ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass
from datetime import datetime
from enum import Enum

from opengis.metadata.extent import Extent
from opengis.metadata.identification import BrowseGraphic


class DateTypeCode(Enum):
    """Datatype of element or entity."""

    CREATION = "creation"
    PUBLICATION = "publication"
    REVISION = "revision"
    EXPIRY = "expiry"
    LAST_UPDATE = "lastUpdate"
    LAST_REVISION = "lastRevision"
    NEXT_UPDATE = "nextUpdate"
    UNAVAILABLE = "unavailable"
    IN_FORCE = "inForce"
    ADOPTED = "adopted"
    DEPRECATED = "deprecated"
    SUPERSEDED = "superseded"
    VALIDITY_BEGINS = "validityBegins"
    VALIDITY_EXPIRES = "validityExpires"
    RELEASED = "released"
    DISTRIBUTION = "distribution"


class OnLineFunctionCode(Enum):
    """Function performed by the resource."""

    DOWNLOAD = "download"
    INFORMATION = "information"
    OFFLINE_ACCESS = "offlineAccess"
    ORDER = "order"
    SEARCH = "search"
    COMPLETE_METADATA = "completeMetadata"
    BROWSE_GRAPHIC = "browseGraphic"
    UPLOAD = "upload"
    EMAIL_SERVICE = "emailService"
    BROWSING = "browsing"
    FILE_ACCESS = "fileAccess"


class PresentationFormCode(Enum):
    """Mode in which the data are represented."""

    DOCUMENT_DIGITAL = "documentDigital"
    DOCUMENT_HARDCOPY = "documentHardcopy"
    IMAGE_DIGITAL = "imageDigital"
    IMAGE_HARDCOPY = "imageHardcopy"
    MAP_DIGITAL = "mapDigital"
    MAP_HARDCOPY = "mapHardcopy"
    MODEL_DIGITAL = "modelDigital"
    MODEL_HARDCOPY = "modelHardcopy"
    PROFILE_DIGITAL = "profileDigital"
    PROFILE_HARDCOPY = "profileHardcopy"
    TABLE_DIGITAL = "tableDigital"
    TABLE_HARDCOPY = "tableHardcopy"
    VIDEO_DIGITAL = "videoDigital"
    VIDEO_HARDCOPY = "videoHardcopy"
    AUDIO_DIGITAL = "audioDigital"
    AUDIO_HARDCOPY = "audioHardcopy"
    MULTIMEDIA_DIGITAL = "multimediaDigital"
    MULTIMEDIA_HARDCOPY = "multimediaHardcopy"
    PHYSICAL_OBJECT = "physicalObject"
    DIAGRAM_DIGITAL = "diagramDigital"
    DIAGRAM_HARDCOPY = "diagramHardcopy"


class RoleCode(Enum):
    """Function performed by the responsible party."""

    RESOURCE_PROVIDER = "resourceProvider"
    CUSTODIAN = "custodian"
    OWNER = "owner"
    USER = "user"
    DISTRIBUTOR = "distributor"
    ORIGINATOR = "originator"
    POINT_OF_CONTACT = "pointOfContact"
    PRINCIPAL_INVESTIGATOR = "principalInvestigator"
    PROCESSOR = "processor"
    PUBLISHER = "publisher"
    AUTHOR = "author"
    SPONSOR = "sponsor"
    CO_AUTHOR = "coAuthor"
    COLLABORATOR = "collaborator"
    EDITOR = "editor"
    MEDIATOR = "mediator"
    RIGHTS_HOLDER = "rightsHolder"
    CONTRIBUTOR = "contributor"
    FUNDER = "funder"
    STAKEHOLDER = "stakeholder"


class TelephoneTypeCode(Enum):
    """Type of telephone."""

    VOICE = "voice"
    FACSIMILE = "facsimile"
    SMS = "sms"


@dataclass(frozen=True, slots=True)
class Series:
    """Information about the series, or aggregate resource, to which a
    resource belongs.

    Attributes:
        name (str): Name of the series, or aggregate resource, of which the
            resource is a part.
        issue_identification (str): Information identifying the issue of the
            series.
        page (str): Details on which pages of the publication the article was
            published.

    """

    name: str
    issue_identification: str
    page: str


@dataclass(frozen=True, slots=True)
class Address:
    """Location of the responsible individual or organisation.

    Attributes:
        delivery_point (tuple[str, ...]): Address line for the location (as
            described in ISO 11180, Annex A).
        city (str): City of the location.
        administrative_area (str): State, province of the location.
        postal_code (str): ZIP or other postal code.
        country (str): Country of the physical address.
        electronic_mail_address (tuple[str, ...]): Address of the electronic
            mailbox of the responsible organisation or individual.

    """

    delivery_point: tuple[str, ...]
    city: str
    administrative_area: str
    postal_code: str
    country: str
    electronic_mail_address: tuple[str, ...]


@dataclass(frozen=True, slots=True)
class Telephone:
    """Telephone numbers for contacting the responsible individual or
    organisation.

    Attributes:
        number (str): Telephone number by which individuals can contact
            responsible organisation or individual.
        number_type (TelephoneTypeCode): Type of telephone responsible
            organisation or individual.

    """

    number: str
    number_type: TelephoneTypeCode


@dataclass(frozen=True, slots=True)
class OnlineResource:
    """Information about on-line sources from which the resource,
    specification, or community profile name and extended metadata
    elements can be obtained.

    Attributes:
        linkage (str): Location (address) for on-line access using a Uniform
            Resource Locator/Uniform Resource Identifier address or similar
            addressing scheme such as http://www.statkart.no/isotc211.
        protocol (str): Connection protocol to be used e.g. http, ftp, file.
        application_profile (str): Name of an application profile that can be
            used with the online resource.
        name (str):Name of the online resource.
        description (str): Detailed text description of what the online
            resource is/does.
        function (OnLineFunctionCode):  Code for function performed by the
            online resource.
        protocol_request (str): Protocol used by the accessed resource.

    """

    linkage: str
    application_profile: str
    name: str
    description: str
    function: OnLineFunctionCode
    protocol_request: str


@dataclass(frozen=True, slots=True)
class Contact:
    """Information required to enable contact with the responsible
    person and/or organisation.

    Attributes:
        phone (tuple[Telephone, ...]): Telephone numbers at which the
            organisation or individual may be contacted.
        address (tuple[Address, ...]):  Physical and email address at which
            the organisation or individual may be contacted.
        online_resource (tuple[OnlineResource, ...]): On-line information that
            can be used to contact the individual or organisation.
        hours_of_service (tuple[str, ...]):  Time period (including time zone)
            when individuals can contact the organisation or individual.
        contact_instructions (str): Supplemental instructions on how or when
            to contact the individual or organisation.
        contact_type (str): Type of the contact.

    """

    phone: tuple[Telephone, ...]
    address: tuple[Address, ...]
    online_resource: tuple[OnlineResource, ...]
    hours_of_service: tuple[str, ...]
    contact_instructions: str
    contact_type: str


@dataclass(frozen=True, slots=True)
class Party:
    """Information about the individual and/or organisation of the party.

    Attributes:
        name (str): Name of the party.
        contact_info (tuple[Contact, ...]): Contact information for the party.
        party_identifier (tuple[Identifier, ...]): Identifier of the party.

    """

    name: str
    contact_info: tuple[Contact, ...]
    party_identifier: tuple["Identifier", ...]


@dataclass(frozen=True, slots=True)
class Responsibility:
    """Information about the party and their role.

    Attributes:
        role (RoleCode): Function performed by the responsible party.
        extent (tuple[Extent, ...]): Spatial or temporal extent of the role.
        party (tuple[Party, ...]): Information about the Party.

    """

    role: RoleCode
    extent: tuple[Extent, ...]
    party: tuple[Party, ...]


@dataclass(frozen=True, slots=True)
class Individual(Party):
    """Information about the party if the party is an individual.

    Attributes:
        position_name (str): Position of the individual in an organisation.

    """

    position_name: str


@dataclass(frozen=True, slots=True)
class Organisation(Party):
    """Information about the party if the party is an organisation.

    Attributes:
        logo (tuple[BrowseGraphic, ...]): Graphic identifying organization.
        individual (tuple[Individual, ...]): Individuals belonging to the
            Organisation.

    """

    logo: tuple[BrowseGraphic, ...]
    individual: tuple[Individual, ...]


@dataclass(frozen=True, slots=True)
class Date:
    """Reference date and event used to describe it.

    Attributes:
        date (datetime): Reference date for the cited resource.
        date_type (DateTypeCode): Event used for reference date.

    """

    date: datetime
    date_type: DateTypeCode


@dataclass(frozen=True, slots=True)
class Citation:
    """Standardized resource reference.

    Attributes:
        title (str): Name by which the cited resource is known.
        alternate_title (tuple[str, ...]): Short name or other language name
            by which the cited information is known. Example: DCW as an
            alternative title for Digital Chart of the World.
        date (tuple[Date, ...]): Reference date for the cited resource.
        edition (str): Version of the cited resource.
        edition_date (datetime): Date of the edition.
        identifier (tuple[Identifier, ...]): Value uniquely identifying an
            object within a namespace.
        cited_responsible_party (tuple[Responsibility, ...]): Name and
            position information for an individual or organisation that
            is responsible for the resource.
        presentation_form (tuple[PresentationFormCode, ...]): Mode in which
            the resource is represented.
        series (Series): Information about the series, or aggregate resource,
            of which the resource is a part.
        other_citation_details (tuple[str, ...]): Other information required
            to complete the citation that is not recorded elsewhere.
        ISBN (str): International Standard Book Number.
        ISSN (str): International Standard Serial Number.
        online_resource (tuple[OnlineResource, ...]): Online reference to the
            cited resource.
        graphic (tuple[BrowseGraphic, ...]): Citation graphic or logo for
            cited party.

    """

    title: str
    alternate_title: tuple[str, ...]
    date: tuple[Date, ...]
    edition: str
    edition_date: datetime
    identifier: tuple["Identifier", ...]
    cited_responsible_party: tuple[Responsibility, ...]
    presentation_form: tuple[PresentationFormCode, ...]
    series: Series
    other_citation_details: tuple[str, ...]
    ISBN: str
    ISSN: str
    online_resource: tuple[OnlineResource, ...]
    graphic: tuple[BrowseGraphic, ...]


@dataclass(frozen=True, slots=True)
class Identifier:
    """Value uniquely identifying an object within a namespace.

    Attributes:
        authority (Citation): Citation for the code namespace and optionally
            the person or party responsible for maintenance of that namespace.
        code (str): Alphanumeric value identifying an instance in the
            namespace e.g., EPSG::4326.
        code_space (str): Identifier or namespace in which the code is valid.
        version (str): Version identifier for the namespace.
        description (str): Natural language description of the meaning of the
            code value, e.g., for codeSpace = EPSG, code = 4326: description =
            WGS-84.

    """

    authority: Citation
    code: str
    code_space: str
    version: str
    description: str
