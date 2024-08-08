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
"""This is the constraints module.

This module contains geographic metadata structures regarding data constraints
derived from the ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from abc import ABC, abstractmethod
from collections.abc import Sequence
from enum import Enum

from opengis.metadata.citation import (
    Citation,
    Responsibility,
)
from opengis.metadata.identification import BrowseGraphic
from opengis.metadata.maintenance import Scope


class ClassificationCode(Enum):
    """Name of the handling restrictions on the resource."""

    UNCLASSIFIED = "unclassified"
    RESTRICTED = "restricted"
    CONFIDENTIAL = "confidential"
    SECRET = "secret"
    TOP_SECRET = "topSecret"
    SENSITIVE_BUT_UNCLASSIFIED = "sensitiveButUnclassified"
    FOR_OFFICIAL_USE_ONLY = "forOfficialUseOnly"
    PROTECTED = "protected"
    LIMITED_DISTRIBUTION = "limitedDistribution"


class RestrictionCode(Enum):
    """Limitation(s) placed upon the access or use of the data."""

    COPYRIGHT = "copyright"
    PATENT = "patent"
    PATENT_PENDING = "patentPending"
    TRADEMARK = "trademark"
    LICENCE = "licence"
    INTELLECTUAL_PROPERTY_RIGHTS = "intellectualPropertyRights"
    RESTRICTED = "restricted"
    OTHER_RESTRICTIONS = "otherRestrictions"
    UNRESTRICTED = "unrestricted"
    LICENCE_UNRESTRICTED = "licenceUnrestricted"
    LICENCE_END_USER = "licenceEndUser"
    LICENCE_DISTRIBUTOR = "licenceDistributor"
    PRIVATE = "private"
    STATUTORY = "statutory"
    CONFIDENTIAL = "confidential"
    SENSITIVE_BUT_UNCLASSIFIED = "sensitiveButUnclassified"
    IN_CONFIDENCE = "in-confidence"


class Releasability(ABC):
    """
    State, nation or organization to which resource can be released,
    e.g., NATO unclassified releasable to PfP.
    """

    @property
    @abstractmethod
    def addressee(self) -> Sequence[Responsibility]:
        """Party responsible for the Release statement."""

    @property
    @abstractmethod
    def statement(self) -> str:
        """Release statement."""

    @property
    @abstractmethod
    def dissemination_constraints(self) -> Sequence[RestrictionCode]:
        """Component in determining releasability."""


class Constraints(ABC):
    """Restrictions on the access and use of a resource or metadata."""

    @property
    @abstractmethod
    def use_limitation(self) -> Sequence[str]:
        """
        Limitation affecting the fitness for use of the resource or metadata.
        For example, "not to be used for navigation".
        """

    @property
    @abstractmethod
    def constraint_application_scope(self) -> Scope:
        """
        Spatial and temporal extent of the application of the constraint
        restrictions.
        """

    @property
    @abstractmethod
    def graphic(self) -> Sequence[BrowseGraphic]:
        """Graphic /symbol indicating the constraint Eg."""

    @property
    @abstractmethod
    def reference(self) -> Sequence[Citation]:
        """
        Citation/URL for the limitation or constraint,
        e.g., copyright statement, license agreement, etc.
        """

    @property
    @abstractmethod
    def releasability(self) -> Releasability:
        """
        Information concerning the parties to whom the resource can or cannot
        be released and the party responsible for determining the
        releasibility.
        """

    @property
    @abstractmethod
    def responsible_party(self) -> Sequence[Responsibility]:
        """Party responsible for the resource constraints."""


class LegalConstraints(Constraints):
    """
    Restrictions and legal prerequisites for accessing and using the resource
    or metadata.
    """

    @property
    @abstractmethod
    def access_constraints(self) -> Sequence[RestrictionCode]:
        """
        Access constraints applied to assure the protection of privacy or
        intellectual property, and any special restrictions or limitations on
        obtaining the resource or metadata.
        """

    @property
    @abstractmethod
    def use_constraints(self) -> Sequence[RestrictionCode]:
        """
        Constraints applied to assure the protection of privacy or
        intellectual property, and any special restrictions or limitations or
        warnings on using the resource or metadata.
        """

    @property
    @abstractmethod
    def other_constraints(self) -> Sequence[str]:
        """
        Other restrictions and legal prerequisites for accessing and using the
        resource or metadata.
        """


class SecurityConstraints(Constraints):
    """
    Handling restrictions imposed on the resource or metadata for national
    security or similar security concerns.
    """

    @property
    @abstractmethod
    def classification(self) -> ClassificationCode:
        """Name of the handling restrictions on the resource or metadata."""

    @property
    @abstractmethod
    def user_note(self) -> str:
        """
        Explanation of the application of the legal constraints or other
        restrictions and legal prerequisites for obtaining and using the
        resource or metadata.
        """

    @property
    @abstractmethod
    def classification_system(self) -> str:
        """Name of the classification system."""

    @property
    @abstractmethod
    def handling_description(self) -> str:
        """
        Additional information about the restrictions on handling the resource
        or metadata.
        """
