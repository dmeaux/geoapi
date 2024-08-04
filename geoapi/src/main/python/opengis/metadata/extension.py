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
"""This is the extension module.

This module contains geographic metadata structures for metadata elements that
are not contained in the ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass
from enum import Enum

from opengis.metadata.citation import Citation, OnlineResource, Responsibility


class DatatypeCode(Enum):
    """Datatype of element or entity."""

    CLASS = "class"
    CODE_LIST = "codelist"
    ENUMERATION = "enumeration"
    CODE_LIST_ELEMENT = "codelistElement"
    ABSTRACT_CLASS = "abstractClass"
    AGGREGATE_CLASS = "aggregateClass"
    SPECIFIED_CLASS = "specifiedClass"
    DATATYPE_CLASS = "datatypeClass"
    INTERFACE_CLASS = "interfaceClass"
    UNION_CLASS = "unionClass"
    META_CLASS = "metaClass"
    TYPE_CLASS = "typeClass"
    CHARACTER_STRING = "characterString"
    INTEGER = "integer"
    ASSOCIATION = "association"


class ObligationCode(Enum):
    """Obligation of the element or entity."""

    MANDATORY = "mandatory"
    OPTIONAL = "optional"
    CONDITIONAL = "conditional"
    FORBIDDEN = "null"


@dataclass(frozen=True, slots=True)
class ApplicationSchemaInformation:
    """Information about the application schema used to build the dataset.

    Attributes:
        name (Citation): Name of the application schema used.
        schema_language (str): Identification of the schema language used.
        constraint_language (str): Formal language used in Application Schema.
        schema_ascii (str): Full application schema given as an ASCII file.
        graphics_file (OnlineResource): Full application schema given as a
            graphics file.
        software_development_file (OnlineResource): Full application schema
            given as a software development file.
        software_development_file_format (str): Software dependent format used
            for the application schema software dependent file.

    """

    name: Citation
    schema_language: str
    constraint_language: str
    schema_ascii: str
    graphics_file: OnlineResource
    software_development_file: OnlineResource
    software_development_file_format: str


@dataclass(frozen=True, slots=True)
class ExtendedElementInformation:
    """New metadata element, not found in ISO 19115, which is required to
    describe geographic data.

    Attributes:
        name (str): Name of the extended metadata element.
        definition (str): Definition of the extended element.
        obligation (ObligationCode): Obligation of the extended element.
        condition (str): Condition under which the extended element is
            mandatory.
        data_type (DatatypeCode): Code which identifies the kind of value
            provided in the extended element.
        maximum_occurrence (str): Maximum occurrence of the extended element.
        domain_value (str): Valid values that can be assigned to the extended
            element.
        parent_entity (tuple[str, ...]): Name of the metadata entity(s) under
            which this extended metadata element may appear. The name(s) may
            be standard metadata element(s) or other extended metadata
            element(s).
        rule (str): Specifies how the extended element relates to other
            existing elements and entities.
        rationale (str): Reason for creating the extended element.
        source (tuple[Responsibility, ...]): Name of the person or
            organisation creating the extended element.

    """

    name: str
    definition: str
    obligation: ObligationCode
    condition: str
    data_type: DatatypeCode
    maximum_occurrence: str
    domain_value: str
    parent_entity: tuple[str, ...]
    rule: str
    rationale: str
    source: tuple[Responsibility, ...]


@dataclass(frozen=True, slots=True)
class MetadataExtensionInformation:
    """Information describing metadata extensions.

    Attributes:
        extension_on_line_resource (OnlineResource):Information about on-line
            sources containing the community profile name and the extended
            metadata elements. Information for all new metadata elements.
        extended_element_information (tuple[ExtendedElementInformation, ...]): 

    """

    extension_on_line_resource: OnlineResource
    extended_element_information: tuple[ExtendedElementInformation, ...]
