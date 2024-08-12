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

from abc import ABC, abstractmethod
from collections.abc import Sequence
from datetime import datetime
from enum import Enum
from typing import Optional

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


class Series(ABC):
    """
    Information about the series, or aggregate resource, to which a resource
    belongs.
    """

    @property
    @abstractmethod
    def name(self) -> Optional[str]:
        """
        Name of the series, or aggregate resource, of which the resource is a
        part.
        """

    @property
    @abstractmethod
    def issue_identification(self) -> Optional[str]:
        """Information identifying the issue of the series."""

    @property
    @abstractmethod
    def page(self) -> Optional[str]:
        """
        Details on which pages of the publication the article was published.
        """


class Address(ABC):
    """Location of the responsible individual or organisation."""

    @property
    @abstractmethod
    def delivery_point(self) -> Optional[Sequence[str]]:
        """
        Address line for the location (as described in ISO 11180, Annex A).
        """

    @property
    @abstractmethod
    def city(self) -> Optional[str]:
        """City of the location."""

    @property
    @abstractmethod
    def administrative_area(self) -> Optional[str]:
        """State, province of the location."""

    @property
    @abstractmethod
    def postal_code(self) -> Optional[str]:
        """ZIP or other postal code."""

    @property
    @abstractmethod
    def country(self) -> Optional[str]:
        """Country of the physical address."""

    @property
    @abstractmethod
    def electronic_mail_address(self) -> Optional[Sequence[str]]:
        """
        Address of the electronic mailbox of the responsible organisation or
        individual.
        """


class Telephone(ABC):
    """
    Telephone numbers for contacting the responsible individual or
    organisation.
    """

    @property
    @abstractmethod
    def number(self) -> str:
        """
        Telephone number by which individuals can contact responsible
        organisation or individual.
        """

    @property
    @abstractmethod
    def number_type(self) -> Optional[TelephoneTypeCode]:
        """Type of telephone responsible organisation or individual."""


class OnlineResource(ABC):
    """
    Information about on-line sources from which the resource, specification,
    or community profile name and extended metadata elements can be obtained.
    """

    @property
    @abstractmethod
    def linkage(self) -> str:
        """
        Location (address) for on-line access using a Uniform Resource Locator/
        Uniform Resource Identifier address or similar addressing scheme such
        as http://www.statkart.no/isotc211.
        """

    @property
    @abstractmethod
    def protocol(self) -> Optional[str]:
        """Connection protocol to be used e.g. http, ftp, file."""

    @property
    @abstractmethod
    def application_profile(self) -> Optional[str]:
        """
        Name of an application profile that can be used with the online
        resource.
        """

    @property
    @abstractmethod
    def name(self) -> Optional[str]:
        """Name of the online resource."""

    @property
    @abstractmethod
    def description(self) -> Optional[str]:
        """Detailed text description of what the online resource is/does."""

    @property
    @abstractmethod
    def function(self) -> Optional[OnLineFunctionCode]:
        """Code for function performed by the online resource."""

    @property
    @abstractmethod
    def protocol_request(self) -> Optional[str]:
        """
        Request used to access the resource depending on the protocol
        (to be used mainly for POST requests)

        Protocol used by the accessed resource.

        Example POST/XML:

        <GetFeatures service = "WFS"
                     version="2.0.0"
                     outputFormat="application/gml+xml; version=3.2"
                     xmlns=http://www.opengis.net/wfs/2.0
                     xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance
                     xsi:schemaLocation="http://www.opengis.net/wfs/2.0
                        http://schemas.opengis.net/wfs/2.0.0/wfs.xsd">
        <Query typeNames="Roads" />
        </GetFeatures>
        """


class Contact(ABC):
    """
    Information required to enable contact with the responsible person and/or
    organisation.
    """

    @property
    @abstractmethod
    def phone(self) -> Optional[Sequence[Telephone]]:
        """
        Telephone numbers at which the organisation or individual may be
        contacted.
        """

    @property
    @abstractmethod
    def address(self) -> Optional[Sequence[Address]]:
        """
        Physical and email address at which the organisation or individual may
        be contacted.
        """

    @property
    @abstractmethod
    def online_resource(self) -> Optional[Sequence[OnlineResource]]:
        """
        On-line information that can be used to contact the individual or
        organisation.
        """

    @property
    @abstractmethod
    def hours_of_service(self) -> Optional[Sequence[str]]:
        """
        Time period (including time zone) when individuals can contact the
        organisation or individual.
        """

    @property
    @abstractmethod
    def contact_instructions(self) -> Optional[str]:
        """
        Supplemental instructions on how or when to contact the individual or
        organisation.
        """

    @property
    @abstractmethod
    def contact_type(self) -> Optional[str]:
        """Type of the contact."""


class Party(ABC):
    """Information about the individual and/or organisation of the party."""

    @property
    @abstractmethod
    def name(self) -> Optional[str]:
        """
        Name of the party.

        MANDATORY: if `logo` and `position_name`are `None`.
        """

    @property
    @abstractmethod
    def contact_info(self) -> Sequence[Contact]:
        """Contact information for the party."""

    @property
    @abstractmethod
    def party_identifier(self) -> Sequence['Identifier']:
        """Identifier of the party."""


class Responsibility(ABC):
    """Information about the party and their role."""

    @property
    @abstractmethod
    def role(self) -> RoleCode:
        """Function performed by the responsible party."""

    @property
    @abstractmethod
    def extent(self) -> Optional[Sequence[Extent]]:
        """Spatial or temporal extent of the role."""

    @property
    @abstractmethod
    def party(self) -> Sequence[Party]:
        """Information about the Party."""


class Individual(Party):
    """Information about the party if the party is an individual."""

    @property
    @abstractmethod
    def position_name(self) -> Optional[str]:
        """
        Position of the individual in an organisation.

        MANDATORY: if `name` and `logo` are `None`.
        """


class Organisation(Party):
    """Information about the party if the party is an organisation."""

    @property
    @abstractmethod
    def logo(self) -> Sequence[BrowseGraphic]:
        """
        Graphic identifying organisation.

        MANDATORY: if `name` and `position_name`are `None`.
        """

    @property
    @abstractmethod
    def individual(self) -> Sequence[Individual]:
        """Individuals belonging to the Organisation."""


class Date(ABC):
    """Reference date and event used to describe it."""

    @property
    @abstractmethod
    def date(self) -> datetime:
        """Reference date for the cited resource."""

    @property
    @abstractmethod
    def date_type(self) -> DateTypeCode:
        """Event used for reference date."""


class Citation(ABC):
    """Standardized resource reference."""

    @property
    @abstractmethod
    def title(self) -> str:
        """Name by which the cited resource is known."""

    @property
    @abstractmethod
    def alternate_title(self) -> Optional[Sequence[str]]:
        """
        Short name or other language name by which the cited information is
        known.

        Example: 'DCW' as an alternative title for Digital Chart of the
        World.
        """

    @property
    @abstractmethod
    def date(self) -> Optional[Sequence[Date]]:
        """Reference date for the cited resource."""

    @property
    @abstractmethod
    def edition(self) -> Optional[str]:
        """Version of the cited resource."""

    @property
    @abstractmethod
    def edition_date(self) -> Optional[datetime]:
        """Date of the edition."""

    @property
    @abstractmethod
    def identifier(self) -> Optional[Sequence['Identifier']]:
        """Value uniquely identifying an object within a namespace."""

    @property
    @abstractmethod
    def cited_responsible_party(self) -> Optional[Sequence[Responsibility]]:
        """
        Name and position information for an individual or organisation that
        is responsible for the resource.
        """

    @property
    @abstractmethod
    def presentation_form(self) -> Optional[Sequence[PresentationFormCode]]:
        """Mode in which the resource is represented."""

    @property
    @abstractmethod
    def series(self) -> Optional[Series]:
        """
        Information about the series, or aggregate resource, of which the
        resource is a part.
        """

    @property
    @abstractmethod
    def other_citation_details(self) -> Optional[Sequence[str]]:
        """
        Other information required to complete the citation that is not
        recorded elsewhere.
        """

    @property
    @abstractmethod
    def isbn(self) -> Optional[str]:
        """International Standard Book Number."""

    @property
    @abstractmethod
    def issn(self) -> Optional[str]:
        """International Standard Serial Number."""

    @property
    @abstractmethod
    def online_resource(self) -> Optional[Sequence[OnlineResource]]:
        """Online reference to the cited resource."""

    @property
    @abstractmethod
    def graphic(self) -> Optional[Sequence['BrowseGraphic']]:
        """Citation graphic or logo for cited party."""


class Identifier(ABC):
    """Value uniquely identifying an object within a namespace."""

    @property
    @abstractmethod
    def authority(self) -> Optional[Citation]:
        """
        The person or party responsible for maintenance of the namespace.

        Citation for the code namespace and optionally the person or party
        responsible for maintenance of that namespace.
        """

    @property
    @abstractmethod
    def code(self) -> str:
        """
        Alphanumeric value identifying an instance in the namespace.

        NOTE: Avoid characters that are not legal in URLs.

        Example: EPSG::4326.
        """

    @property
    @abstractmethod
    def code_space(self) -> Optional[str]:
        """Identifier or namespace in which the code is valid."""

    @property
    @abstractmethod
    def version(self) -> Optional[str]:
        """Version identifier for the namespace."""

    @property
    @abstractmethod
    def description(self) -> Optional[str]:
        """
        Natural language description of the meaning of the code value.

        Example: for code_space = EPSG, code = 4326, description = WGS-84.
        """
