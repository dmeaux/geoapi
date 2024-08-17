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

"""This is the constraints module.

This module contains geographic metadata structures regarding data constraints
derived from the ISO 19115-1:2014 international standard.
"""

from opengis.metadata.citation import Responsibility, Citation
from opengis.metadata.maintenance import Scope


struct ClassificationCode():
    alias UNCLASSIFIED = "unclassified"
    alias RESTRICTED = "restricted"
    alias CONFIDENTIAL = "confidential"
    alias SECRET = "secret"
    alias TOP_SECRET = "topSecret"
    alias SENSITIVE_BUT_UNCLASSIFIED = "sensitiveButUnclassified"
    alias FOR_OFFICIAL_USE_ONLY = "forOfficialUseOnly"
    alias PROTECTED = "protected"
    alias LIMITED_DISTRIBUTION = "limitedDistribution"


struct RestrictionCode():
    alias COPYRIGHT = "copyright"
    alias PATENT = "patent"
    alias PATENT_PENDING = "patentPending"
    alias TRADEMARK = "trademark"
    alias LICENCE = "licence"
    alias INTELLECTUAL_PROPERTY_RIGHTS = "intellectualPropertyRights"
    alias RESTRICTED = "restricted"
    alias OTHER_RESTRICTIONS = "otherRestrictions"
    alias UNRESTRICTED = "unrestricted"
    alias LICENCE_UNRESTRICTED = "licenceUnrestricted"
    alias LICENCE_END_USER = "licenceEndUser"
    alias LICENCE_DISTRIBUTOR = "licenceDistributor"
    alias PRIVATE = "private"
    alias STATUTORY = "statutory"
    alias CONFIDENTIAL = "confidential"
    alias SENSITIVE_BUT_UNCLASSIFIED = "sensitiveButUnclassified"
    alias IN_CONFIDENCE = "in-confidence"


trait Releasability():
    """State, nation or organization to which resource can be released to e.g. NATO unclassified releasable to PfP."""

    fn addressee(self) -> Sequence[Responsibility]:
        """Party responsible for the Release statement."""
        ...

    fn statement(self) -> String:
        """Release statement."""
        ...

    fn dissemination_constraints(self) -> Sequence[RestrictionCode]:
        """Component in determining releasability."""
        ...


trait Constraints():
    """Restrictions on the access and use of a resource or metadata."""

    fn use_limitation(self) -> Sequence[String]:
        """Limitation affecting the fitness for use of the resource or metadata. Example, "not to be used for navigation"."""
        ...

    fn constraint_application_scope(self) -> Scope:
        """Spatial and temporal extent of the application of the constraint restrictions."""
        ...

    fn graphic(self) -> Sequence[BrowseGraphic]:
        """Graphic /symbol indicating the constraint Eg."""
        ...

    fn reference(self) -> Sequence[Citation]:
        """Citation/URL for the limitation or constraint, e.g. copyright statement, license agreement, etc."""
        ...

    fn releasability(self) -> Releasability:
        """Information concerning the parties to whom the resource can or cannot be released and the party responsible for determining the releasibility."""
        ...

    fn responsible_party(self) -> Sequence[Responsibility]:
        """Party responsible for the resource constraints."""
        ...


trait LegalConstraints(Constraints):
    """Restrictions and legal prerequisites for accessing and using the resource or metadata."""

    fn access_constraints(self) -> Sequence[RestrictionCode]:
        """Access constraints applied to assure the protection of privacy or intellectual property, and any special restrictions or limitations on obtaining the resource or metadata."""
        ...

    fn use_constraints(self) -> Sequence[RestrictionCode]:
        """Constraints applied to assure the protection of privacy or intellectual property, and any special restrictions or limitations or warnings on using the resource or metadata."""
        ...

    fn other_constraints(self) -> Sequence[String]:
        """Other restrictions and legal prerequisites for accessing and using the resource or metadata."""
        ...


trait SecurityConstraints(Constraints):
    """Handling restrictions imposed on the resource or metadata for national security or similar security concerns."""

    fn classification(self) -> ClassificationCode:
        """Name of the handling restrictions on the resource or metadata."""
        ...

    fn user_note(self) -> String:
        """Explanation of the application of the legal constraints or other restrictions and legal prerequisites for obtaining and using the resource or metadata."""
        ...

    fn classification_system(self) -> String:
        """Name of the classification system."""
        ...

    fn handling_description(self) -> String:
        """Additional information about the restrictions on handling the resource or metadata."""
        ...
