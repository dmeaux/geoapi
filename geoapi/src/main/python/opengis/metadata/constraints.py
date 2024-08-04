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

from dataclasses import dataclass
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


@dataclass(frozen=True, slots=True)
class Releasability:
    """State, nation or organization to which resource can be released to e.g.,
    NATO unclassified releasable to PfP.

    Attributes:
        addressee (tuple[Responsibility, ...]): Party responsible for the
            Release statement.
        statement (str): Release statement.
        dissemination_constraints (tuple[RestrictionCode, ...]): Component in
            determining releasability.

    """

    addressee: tuple[Responsibility]
    statement: str
    dissemination_constraints: tuple[RestrictionCode]


@dataclass(frozen=True, slots=True)
class Constraints:
    """Restrictions on the access and use of a resource or metadata.

    Attributes:
        use_limitation (tuple[str, ...]): Limitation affecting the fitness for
            use of the resource or metadata. Example, "not to be used for
            navigation".
        constraint_application_scope (Scope): Spatial and temporal extent of
            the application of the constraint restrictions.
        graphic (tuple[BrowseGraphic, ...]): Graphic or symbol indicating
            the constraint.
        reference (tuple[Citation, ...]): Citation/URL for the limitation or
            constraint, e.g. copyright statement, license agreement, etc.
        releasability (Releasability): Information concerning the parties to
            whom the resource can or cannot be released and the party
            responsible for determining the releasibility.
        responsible_party tuple[Responsibility, ...]: Party responsible for
            the resource constraints.

    """

    use_limitation: tuple[str, ...]
    constraint_application_scope: Scope
    graphic: tuple[BrowseGraphic, ...]
    reference: tuple[Citation, ...]
    releasability: Releasability
    responsible_party: tuple[Responsibility, ...]


@dataclass(frozen=True, slots=True)
class LegalConstraints:
    """Restrictions and legal prerequisites for accessing and using the
    resource or metadata.

    Attributes:
        use_limitation (tuple[str, ...]): Limitation affecting the fitness for
            use of the resource or metadata. Example, "not to be used for
            navigation".
        constraint_application_scope (Scope): Spatial and temporal extent of
            the application of the constraint restrictions.
        graphic (tuple[BrowseGraphic, ...]): Graphic or symbol indicating
            the constraint.
        reference (tuple[Citation, ...]): Citation/URL for the limitation or
            constraint, e.g. copyright statement, license agreement, etc.
        releasability (Releasability): Information concerning the parties to
            whom the resource can or cannot be released and the party
            responsible for determining the releasibility.
        responsible_party tuple[Responsibility, ...]: Party responsible for
            the resource constraints.
        access_constraints (tuple[RestrictionCode, ...]): Access constraints
            applied to assure the protection of privacy or intellectual
            property, and any special restrictions or limitations on obtaining
            the resource or metadata.
        use_constraints (tuple[RestrictionCode, ...]): Constraints applied to
            assure the protection of privacy or intellectual property, and any
            special restrictions or limitations or warnings on using the
            resource or metadata.
        other_constraints (tuple[str, ...]): Other restrictions and legal
            prerequisites for accessing and using the resource or metadata.

    """

    use_limitation: tuple[str, ...]
    constraint_application_scope: Scope
    graphic: tuple[BrowseGraphic, ...]
    reference: tuple[Citation, ...]
    releasability: Releasability
    responsible_party: tuple[Responsibility, ...]
    access_constraints: tuple[RestrictionCode, ...]
    use_constraints: tuple[RestrictionCode, ...]
    other_constraints: tuple[str, ...]


@dataclass(frozen=True, slots=True)
class SecurityConstraints:
    """Handling restrictions imposed on the resource or metadata for national
    security or similar security concerns.

    Attributes:
        use_limitation (tuple[str, ...]): Limitation affecting the fitness for
            use of the resource or metadata. Example, "not to be used for
            navigation".
        constraint_application_scope (Scope): Spatial and temporal extent of
            the application of the constraint restrictions.
        graphic (tuple[BrowseGraphic, ...]): Graphic or symbol indicating the
            constraint.
        reference (tuple[Citation, ...]): Citation/URL for the limitation or
            constraint, e.g. copyright statement, license agreement, etc.
        releasability (Releasability): Information concerning the parties to
            whom the resource can or cannot be released and the party
            responsible for determining the releasibility.
        responsible_party tuple[Responsibility, ...]: Party responsible for
            the resource constraints.
        classification (ClassificationCode): Name of the handling restrictions
            on the resource or metadata.
        user_note (str): Explanation of the application of the legal
            constraints or other restrictions and legal prerequisites for
            obtaining and using the resource or metadata.
        classification_system (str): Name of the classification system.
        handling_description (str): Additional information about the
            restrictions on handling the resource or metadata.

    """

    use_limitation: tuple[str, ...]
    constraint_application_scope: Scope
    graphic: tuple["BrowseGraphic", ...]
    reference: tuple[Citation, ...]
    releasability: Releasability
    responsible_party: tuple[Responsibility, ...]
    classification: ClassificationCode
    user_note: str
    classification_system: str
    handling_description: str
