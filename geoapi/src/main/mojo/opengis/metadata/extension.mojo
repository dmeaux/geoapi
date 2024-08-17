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
"""This is the extension module.

This module contains geographic metadata structures for metadata elements that
are not contained in the ISO 19115-1:2014 international standard.
"""

from opengis.metadata.citation import Citation, OnlineResource, Responsibility


struct DatatypeCode():
    alias CLASS = "class"
    alias CODE_LIST = "codelist"
    alias ENUMERATION = "enumeration"
    alias CODE_LIST_ELEMENT = "codelistElement"
    alias ABSTRACT_struct = "abstractClass"
    alias AGGREGATE_struct = "aggregateClass"
    alias SPECIFIED_struct = "specifiedClass"
    alias DATATYPE_struct = "datatypeClass"
    alias INTERFACE_struct = "interfaceClass"
    alias UNION_struct = "unionClass"
    alias META_struct = "metaClass"
    alias TYPE_struct = "typeClass"
    alias CHARACTER_STRING = "characterString"
    alias INTEGER = "integer"
    alias ASSOCIATION = "association"


struct ObligationCode():
    alias MANDATORY = "mandatory"
    alias OPTIONAL = "optional"
    alias CONDITIONAL = "conditional"
    alias FORBIDDEN = "null"


trait ApplicationSchemaInformation():
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

    fn schema_ascii(self) -> String:
        """Full application schema given as an ASCII file."""
        ...

    fn graphics_file(self) -> OnlineResource:
        """Full application schema given as a graphics file."""
        ...

    fn software_development_file(self) -> OnlineResource:
        """Full application schema given as a software development file."""
        ...

    fn software_development_file_format(self) -> String:
        """Software dependent format used for the application schema software dependent file."""
        ...


trait ExtendedElementInformation():
    """New metadata element, not found in ISO 19115, which is required to describe geographic data."""

    fn name(self) -> String:
        """Name of the extended metadata element."""
        ...

    fn definition(self) -> String:
        """Definition of the extended element."""
        ...

    fn obligation(self) -> ObligationCode:
        """Obligation of the extended element."""
        ...

    fn condition(self) -> String:
        """Condition under which the extended element is mandatory."""
        ...

    fn data_type(self) -> DatatypeCode:
        """Code which identifies the kind of value provided in the extended element."""
        ...

    fn maximum_occurrence(self) -> Int:
        """Maximum occurrence of the extended element."""
        ...

    fn domain_value(self) -> String:
        """Valid values that can be assigned to the extended element."""
        ...

    fn parent_entity(self) -> Sequence[String]:
        """Name of the metadata entity(s) under which this extended metadata element may appear. The name(s) may be standard metadata element(s) or other extended metadata element(s)."""
        ...

    fn rule(self) -> String:
        """Specifies how the extended element relates to other existing elements and entities."""
        ...

    fn rationale(self) -> String:
        """Reason for creating the extended element."""
        ...

    fn source(self) -> Sequence[Responsibility]:
        """Name of the person or organisation creating the extended element."""
        ...


trait MetadataExtensionInformation():
    """Information describing metadata extensions."""

    fn extension_on_line_resource(self) -> OnlineResource:
        """Information about on-line sources containing the community profile name and the extended metadata elements. Information for all new metadata elements."""
        ...

    fn extended_element_information(self) -> Sequence[ExtendedElementInformation]:
        ...
