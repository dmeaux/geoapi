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

from abc import ABC, abstractmethod
from collections.abc import Sequence
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


class ApplicationSchemaInformation(ABC):
    """Information about the application schema used to build the dataset."""

    @property
    @abstractmethod
    def name(self) -> Citation:
        """Name of the application schema used."""

    @property
    @abstractmethod
    def schema_language(self) -> str:
        """Identification of the schema language used."""

    @property
    @abstractmethod
    def constraint_language(self) -> str:
        """Formal language used in Application Schema."""

    @property
    @abstractmethod
    def schema_ascii(self) -> str:
        """Full application schema given as an ASCII file."""

    @property
    @abstractmethod
    def graphics_file(self) -> OnlineResource:
        """Full application schema given as a graphics file."""

    @property
    @abstractmethod
    def software_development_file(self) -> OnlineResource:
        """Full application schema given as a software development file."""

    @property
    @abstractmethod
    def software_development_file_format(self) -> str:
        """
        Software dependent format used for the application schema software
        dependent file.
        """


class ExtendedElementInformation(ABC):
    """
    New metadata element, not found in ISO 19115, which is required to
    describe geographic data.
    """

    @property
    @abstractmethod
    def name(self) -> str:
        """Name of the extended metadata element."""

    @property
    @abstractmethod
    def definition(self) -> str:
        """Definition of the extended element."""

    @property
    @abstractmethod
    def obligation(self) -> ObligationCode:
        """Obligation of the extended element."""

    @property
    @abstractmethod
    def condition(self) -> str:
        """Condition under which the extended element is mandatory."""

    @property
    @abstractmethod
    def data_type(self) -> DatatypeCode:
        """
        Code which identifies the kind of value provided in the extended
        element.
        """

    @property
    @abstractmethod
    def maximum_occurrence(self) -> int:
        """Maximum occurrence of the extended element."""

    @property
    @abstractmethod
    def domain_value(self) -> str:
        """Valid values that can be assigned to the extended element."""

    @property
    @abstractmethod
    def parent_entity(self) -> Sequence[str]:
        """
        Name of the metadata entity(s) under which this extended metadata
        element may appear. The name(s) may be standard metadata element(s) or
        other extended metadata element(s).
        """

    @property
    @abstractmethod
    def rule(self) -> str:
        """
        Specifies how the extended element relates to other existing elements
        and entities.
        """

    @property
    @abstractmethod
    def rationale(self) -> str:
        """Reason for creating the extended element."""

    @property
    @abstractmethod
    def source(self) -> Sequence[Responsibility]:
        """Name of the person or organisation creating the extended element."""


class MetadataExtensionInformation(ABC):
    """Information describing metadata extensions."""

    @property
    @abstractmethod
    def extension_on_line_resource(self) -> OnlineResource:
        """
        Information about on-line sources containing the community profile
        name and the extended metadata elements. Information for all new
        metadata elements.
        """

    @property
    @abstractmethod
    def extended_element_information(self) -> Sequence[
        ExtendedElementInformation
    ]:
        """"""
