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

"""This is the `constraints` module.

This module contains geographic metadata structures regarding data constraints
derived from the ISO 19115-1:2014 international standard.
"""

from collections import Optional, KeyElement

from opengis.metadata.citation import Responsibility, Citation
from opengis.metadata.maintenance import Scope


@value
struct ClassificationCode(
    CollectionElement,
    KeyElement,
    Representable,
    Stringable,
    Writable,
):
    """Name of the handling restrictions on the resource."""

    alias type = String
    var value: Self.type
    """The underlying storage value for the ClassificationCode value."""

    alias UNCLASSIFIED = ClassificationCode("unclassified")
    """Available for general disclosure."""

    alias RESTRICTED = ClassificationCode("restricted")
    """Not for general disclosure."""

    alias CONFIDENTIAL = ClassificationCode("confidential")
    """Available for someone who can be entrusted with information."""

    alias SECRET = ClassificationCode("secret")
    """Kept or meant to be kept private, unknown, or hidden from all but a select
    group of people.
    """

    alias TOP_SECRET = ClassificationCode("topSecret")
    """Of the highest secrecy."""

    alias SENSITIVE_BUT_UNCLASSIFIED = ClassificationCode("sensitiveButUnclassified")
    """Although unclassified, requries strict controls over its distribution.
    """

    alias FOR_OFFICIAL_USE_ONLY = ClassificationCode("forOfficialUseOnly")
    """Unclassified information that is to be used only for official purposes
    determined by the designating body.
    """

    alias PROTECTED = ClassificationCode("protected")
    """Compromise of the information could cause damage."""

    alias LIMITED_DISTRIBUTION = ClassificationCode("limitedDistribution")
    """Destination limited by designating body."""

    @always_inline
    fn __init__(out self, *, other: Self):
        """Copy this ClassificationCode.

        Args:
            other: The ClassificationCode to copy.
        """
        self = other

    @staticmethod
    fn _from_str(str: String) -> ClassificationCode:
        """Construct a ClassificationCode from a string.

        Args:
            str: The name of the ClassificationCode.
        """
        if str.startswith(String("ClassificationCode.")):
            return Self._from_str(str.removeprefix("ClassificationCode."))
        elif str == String("unclassified"):
            return ClassificationCode.UNCLASSIFIED
        elif str == String("restricted"):
            return ClassificationCode.RESTRICTED
        elif str == String("confidential"):
            return ClassificationCode.CONFIDENTIAL
        elif str == String("secret"):
            return ClassificationCode.SECRET
        elif str == String("topSecret"):
            return ClassificationCode.TOP_SECRET
        elif str == String("sensitiveButUnclassified"):
            return ClassificationCode.SENSITIVE_BUT_UNCLASSIFIED
        elif str == String("forOfficialUseOnly"):
            return ClassificationCode.FOR_OFFICIAL_USE_ONLY
        elif str == String("protected"):
            return ClassificationCode.PROTECTED
        elif str == String("limitedDistribution"):
            return ClassificationCode.LIMITED_DISTRIBUTION

    @no_inline
    fn __str__(self) -> String:
        """Gets the name of the ClassificationCode.

        Returns:
            The name of the ClassificationCode.
        """

        return String.write(self.value)

    @no_inline
    fn write_to[W: Writer](self, mut writer: W):
        """
        Formats this ClassificationCode to the provided Writer.

        Parameters:
            W: A type conforming to the Writable trait.

        Args:
            writer: The object to write to.
        """

        return writer.write(self.value)

    @always_inline("nodebug")
    fn __repr__(self) -> String:
        """Gets the representation of the ClassificationCode e.g. `"ClassificationCode.unclassified"`.

        Returns:
            The representation of the ClassificationCode.
        """
        return String.write("ClassificationCode.", self)

    @always_inline("nodebug")
    fn __is__(self, rhs: ClassificationCode) -> Bool:
        """Compares one ClassificationCode to another for equality.

        Args:
            rhs: The ClassificationCode to compare against.

        Returns:
            True if the ClassificationCodes are the same and False otherwise.
        """
        return self == rhs

    @always_inline("nodebug")
    fn __isnot__(self, rhs: ClassificationCode) -> Bool:
        """Compares one ClassificationCode to another for inequality.

        Args:
            rhs: The ClassificationCode to compare against.

        Returns:
            True if the ClassificationCodes are the same and False otherwise.
        """
        return self != rhs

    @always_inline("nodebug")
    fn __eq__(self, rhs: ClassificationCode) -> Bool:
        """Compares one ClassificationCode to another for equality.

        Args:
            rhs: The ClassificationCode to compare against.

        Returns:
            True if the ClassificationCodes are the same and False otherwise.
        """
        return self.value == rhs.value

    @always_inline("nodebug")
    fn __ne__(self, rhs: ClassificationCode) -> Bool:
        """Compares one ClassificationCode to another for inequality.

        Args:
            rhs: The ClassificationCode to compare against.

        Returns:
            False if the ClassificationCodes are the same and True otherwise.
        """
        return self.value != rhs.value

    fn __hash__(self) -> UInt:
        """Return a 64-bit hash for this `ClassificationCode` value.

        Returns:
            A 64-bit integer hash of this `ClassificationCode` value.
        """
        return hash(self.value)


struct RestrictionCode:
    """Limitation(s) placed upon the access or use of the data."""

    alias COPYRIGHT = "copyright"
    """Exclusive right tot he publication, production, or sale of the rights to a
    literary, dramatic, musical, or artistic work, or to the use of a
    commercial print or label, granted by law for a specified period of time
    to an author, composer, artist, distributor.
    """

    alias PATENT = "patent"
    """Government has granted exclusive right to make, sell, use or license an
    invention or discovery.
    """

    alias PATENT_PENDING = "patentPending"
    """Produced or sold information awaiting a patent."""

    alias TRADEMARK = "trademark"
    """A name, symbol, or other device identifying a product, officially
    registered and legally restricted to the use of the owner or manufacturer.
    """

    alias LICENCE = "licence"
    """Formal permission to do something."""

    alias INTELLECTUAL_PROPERTY_RIGHTS = "intellectualPropertyRights"
    """Rights to financial benefit from and control of distribution of
    non-tangible property that is a result of creativity.
    """

    alias RESTRICTED = "restricted"
    """Withheld from general circulation or disclosure."""

    alias OTHER_RESTRICTIONS = "otherRestrictions"
    """Limitation not listed."""

    alias UNRESTRICTED = "unrestricted"
    """No constraints exist."""

    alias LICENCE_UNRESTRICTED = "licenceUnrestricted"
    """Formal permission not required to use resource."""

    alias LICENCE_END_USER = "licenceEndUser"
    """Fromal permission required for a person pr an entity to use the resource
    and that may differ from the person that orders or purchases it.
    """

    alias LICENCE_DISTRIBUTOR = "licenceDistributor"
    """Formal permission required for a person or entity to commercialize or
    distribute the resource.
    """

    alias PRIVATE = "private"
    """Protects rights of individual or organisations from observation,
    intrusion, or attention of others.
    """

    alias STATUTORY = "statutory"
    """Prescribed by law."""

    alias CONFIDENTIAL = "confidential"
    """Not available to the public.

    alias NOTE: Contains information that could be prejudicial to a commercial,
    industrial, or national interest.
    """

    alias SENSITIVE_BUT_UNCLASSIFIED = "sensitiveButUnclassified"
    """Although unclassified, requires strict controls over its distribution.
    """

    alias IN_CONFIDENCE = "in-confidence"
    "With trust."


trait Releasability:
    """State, nation or organisation to which resource can be released,
    e.g., NATO unclassified releasable to PfP."""

    fn addressee(self) -> Optional[Tuple[Responsibility]]:
        """Party to which the release statement applies.

        MANDATORY:
            If `statement` is `None`.
        """
        ...

    fn statement(self) -> Optional[String]:
        """Release statement.

        MANDATORY:
            If `addressee` is `None`.
        """
        ...

    fn dissemination_constraints(self) -> Optional[Tuple[RestrictionCode]]:
        """Component in determining releasability."""
        ...


trait Constraints:
    """Restrictions on the access and use of a resource or metadata."""

    fn use_limitation(self) -> Optional[Tuple[String]]:
        """Limitation affecting the fitness for use of the resource or metadata.
        For example, "not to be used for navigation".
        """
        ...

    fn constraint_application_scope(self) -> Optional[Scope]:
        """Spatial and temporal extent of the application of the constraint
        restrictions.
        """
        ...

    fn graphic(self) -> Optional[Tuple[BrowseGraphic]]:
        """Graphic /symbol indicating the constraint Eg."""
        ...

    fn reference(self) -> Optional[Tuple[Citation]]:
        """Citation/URL for the limitation or constraint,
        e.g., copyright statement, license agreement, etc.
        """
        ...

    fn releasability(self) -> Optional[Releasability]:
        """Information concerning the parties to whom the resource can or cannot
        be released and the party responsible for determining the
        releasibility.
        """
        ...

    fn responsible_party(self) -> Optional[Tuple[Responsibility]]:
        """Party responsible for the resource constraints."""
        ...


trait LegalConstraints(Constraints):
    """Restrictions and legal prerequisites for accessing and using the resource
    or metadata."""

    fn access_constraints(self) -> Optional[Tuple[RestrictionCode]]:
        """Access constraints applied to assure the protection of privacy or
        intellectual property, and any special restrictions or limitations on
        obtaining the resource or metadata.

        MANDATORY:
            If `use_constraints`, `other_constrints`, `use_limitations`,
            or `releasability` are `None`.
        """
        ...

    fn use_constraints(self) -> Optional[Tuple[RestrictionCode]]:
        """Constraints applied to assure the protection of privacy or
        intellectual property, and any special restrictions or limitations or
        warnings on using the resource or metadata.

        MANDATORY:
            If `access_constraints`, `other_constrints`,
            `use_limitations`, or `releasability` are `None`.
        """
        ...

    fn other_constraints(self) -> Optional[Tuple[String]]:
        """Other restrictions and legal prerequisites for accessing and using the
        resource or metadata.

        MANDATORY:
            If `access_constraints`, `use_constrints`,
            `use_limitations`, or `releasability` are `None`.
        """
        ...


trait SecurityConstraints(Constraints):
    """Handling restrictions imposed on the resource or metadata for national
    security or similar security concerns."""

    fn classification(self) -> ClassificationCode:
        """Name of the handling restrictions on the resource or metadata."""
        ...

    fn user_note(self) -> Optional[String]:
        """Explanation of the application of the legal constraints or other
        restrictions and legal prerequisites for obtaining and using the
        resource or metadata.
        """
        ...

    fn classification_system(self) -> Optional[String]:
        """Name of the classification system."""
        ...

    fn handling_description(self) -> Optional[String]:
        """Additional information about the restrictions on handling the resource
        or metadata.
        """
        ...
