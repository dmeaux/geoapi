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

"""This is the `extension` module.

This module contains geographic metadata structures for metadata elements that
are not contained in the ISO 19115-1:2014 international standard.
"""

from collections import Optional

from opengis.metadata.citation import Citation, OnlineResource, Responsibility


struct DatatypeCode:
    """Datatype of element or entity."""

    alias CLASS = "class"
    """Descriptor of a set of objects that share the same attributes, operations,
    methods, relationships, and behaviour.
    """

    alias CODE_LIST = "codelist"
    """Flexible enumeration useful for expressing a long list of values, can be
    extended.
    """

    alias ENUMERATION = "enumeration"
    """Data type whose instances form a list of named literal values, not
    extendable.
    """

    alias CODE_LIST_ELEMENT = "codelistElement"
    """Permissible value for a codelist or enumeration."""

    alias ABSTRACT_trait = "abstractClass"
    """trait that cannot be directly instantiated"""

    alias AGGREGATE_trait = "aggregateClass"
    """trait that is composed of classes it is connected to by an aggregate
    relationship.
    """

    alias SPECIFIED_trait = "specifiedClass"
    """Subtrait that may be substituted for its superclass."""

    alias DATATYPE_trait = "datatypeClass"
    """trait  with few or no operations whose primary purpose is to hold the
    abstract state of another trait for transmittal, storage, encoding, or
    persistent storage.
    """

    alias INTERFACE_trait = "interfaceClass"
    """Named set of operations that characterize the bahaviour of an element.
    """

    alias UNION_trait = "unionClass"
    """trait describing a selection of one of the specified types."""

    alias META_trait = "metaClass"
    """trait whose instances are classes."""

    alias TYPE_trait = "typeClass"
    """trait used for specification of a domain of instances (objects), together
    with the operations applicable to the objects. A type may have attributes
    and associations.
    """

    alias CHARACTER_STRING = "characterString"
    """Textual infromation."""

    alias INTEGER = "integer"
    """Numerical field."""

    alias ASSOCIATION = "association"
    """Semantic relationship between two classes that involves connections among
    their instances.
    """


struct ObligationCode:
    """Obligation of the element or entity."""

    alias MANDATORY = "mandatory"
    """Element is always required."""

    alias OPTIONAL = "optional"
    """Element is not required."""

    alias CONDITIONAL = "conditional"
    """element is required when a specific condition is met."""

    alias FORBIDDEN = None
    """
    The element should always be `None`. This obligation code is used only
    when a sub-trait overrides an association and force it to a `None`
    value. An example is
    `opengis.referencing.datum.TemporalDatum.anchor_point`.
    """


trait ApplicationSchemaInformation:
    """Information about the application schema used to build the dataset."""

    fn name(self) -> Citation:
        """Name of the application schema used."""
        ...

    fn schema_language(self) -> String:
        """Identification of the schema language used."""
        ...

    fn constraint_language(self) -> String:
        """Formal language used in Application Schema."""
        ...

    fn schema_ascii(self) -> Optional[String]:
        """Full application schema given as an ASCII file."""
        ...

    fn graphics_file(self) -> Optional[OnlineResource]:
        """Full application schema given as a graphics file."""
        ...

    fn software_development_file(self) -> Optional[OnlineResource]:
        """Full application schema given as a software development file."""
        ...

    fn software_development_file_format(self) -> Optional[String]:
        """Software dependent format used for the application schema software
        dependent file.
        """
        ...


trait ExtendedElementInformation:
    """New metadata element, not found in ISO 19115, which is required to
    describe geographic data."""

    fn name(self) -> Optional[String]:
        """Name of the extended metadata element.

        MANDATORY:
            If `data_type` != CODE_LIST and `datatype` != ENUMERATION
            and `data_type` != CODE_LIST_ELEMENT.
        """
        ...

    fn definition(self) -> String:
        """Definition of the extended element."""
        ...

    fn obligation(self) -> Optional[ObligationCode]:
        """Obligation of the extended element.

        MANDATORY:
            If `data_type` != CODE_LIST and `datatype` != ENUMERATION
            and `data_type` != CODE_LIST_ELEMENT.
        """
        ...

    fn condition(self) -> Optional[String]:
        """Condition under which the extended element is mandatory.

        MANDATORY:
            If `obligation` == .
        """
        ...

    fn data_type(self) -> DatatypeCode:
        """Code which identifies the kind of value provided in the extended
        element.
        """
        ...

    fn maximum_occurrence(self) -> Optional[Int]:
        """Maximum occurrence of the extended element.

        MANDATORY:
            If `data_type` != CODE_LIST and `datatype` != ENUMERATION
            and `data_type` != CODE_LIST_ELEMENT.
        """
        ...

    fn domain_value(self) -> Optional[String]:
        """Valid values that can be assigned to the extended element.

        MANDATORY:
            If `data_type` != CODE_LIST and `datatype` != ENUMERATION
            and `data_type` != CODE_LIST_ELEMENT.
        """
        ...

    fn parent_entity(self) -> Tuple[String]:
        """Name of the metadata entity(s) under which this extended metadata
        element may appear. The name(s) may be standard metadata element(s) or
        other extended metadata element(s).
        """
        ...

    fn rule(self) -> String:
        """Specifies how the extended element relates to other existing elements
        and entities.
        """
        ...

    fn rationale(self) -> Optional[String]:
        """Reason for creating the extended element."""
        ...

    fn source(self) -> Tuple[Responsibility]:
        """Name of the person or organisation creating the extended element."""
        ...

    fn concept_name(self) -> Optional[String]:
        """The name of the item.

        MANDATORY:
            If `data_type` != CODE_LIST and `datatype` != ENUMERATION
            and `data_type` != CODE_LIST_ELEMENT.
        """
        ...

    fn code(self) -> Optional[String]:
        """Language neutral identifier.

        MANDATORY:
            If `data_type` != CODE_LIST and `datatype` != ENUMERATION
            and `data_type` != CODE_LIST_ELEMENT.
        """
        ...


trait MetadataExtensionInformation:
    """Information describing metadata extensions."""

    fn extension_on_line_resource(self) -> Optional[OnlineResource]:
        """Information about on-line sources containing the community profile
        name and the extended metadata elements and information for all new
        metadata elements about on-line sources containing the community
        profile name, the extended metadata elements and information about all
        new metadata elements.
        """
        ...

    fn extended_element_information(self) -> Tuple[ExtendedElementInformation]:
        """Provides information about a new metadata element, not found
        in ISO 19115, which is required to describe the resource.
        """
        ...
