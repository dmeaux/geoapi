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
"""This is the naming module.

This module contains geographic metadata structures regarding naming derived
from the ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class NameSpace:
    """A domain in which names are defined.

    Attributes:
        is_global (bool): Indicates whether this namespace is a "top level"
            namespace. Global, or top-level namespaces are not contained
            within another namespace. The global namespace has no parent.
        name (GenericName): The identifier of this namespace.

    """

    is_global: bool
    name: "GenericName"


@dataclass(frozen=True, slots=True)
class GenericName:
    """A sequence of identifiers rooted within the context of a
    namespace.

    Attributes:
        depth (int): Indicates the number of levels specified by this name.
            For any `LocalName`, it is always one. For a `ScopedName` it is
            some number greater than or equal to 2.
        scope (NameSpace): The scope (name space) in which this name is local.
            All names carry an association with their scope in which they are
            considered local, but the scope can be the global namespace.
        parsed_name (tuple['LocalName', ...]):  The sequence of local names
            making this generic name. The length of this sequence is the
            depth. It does not include the scope.

    """

    depth: int
    scope: NameSpace
    parsed_name: tuple["LocalName", ...]


@dataclass(frozen=True, slots=True)
class LocalName(GenericName):
    """
    Identifier within a name space for a local object. Local names are names
        which are directly accessible to and
    maintained by a `NameSpace`. Names are local to one and only one name
        space. The name space within which they are local is indicated by the
        scope.

    Attributes:
        as_str (str): A string representation of this local name.
        scope (NameSpace): The scope (name space) in which this name is local.
            All names carry an association with their scope in which they are
            considered local, but the scope can be the global namespace.
        parsed_name (tuple['LocalName', ...]): The sequence of local names.
            Since this object is itself a locale name, the parsed name is
            always a singleton containing only `self`.

    """

    as_str: str
    scope: NameSpace
    parsed_name: tuple["LocalName", ...]

    @property
    def depth(self) -> int:
        """
        The number of levels specified by this name, which is always 1 for a
        local name.
        """
        return 1


@dataclass(frozen=True, slots=True)
class ScopedName(GenericName):
    """A composite of a `LocalName` (as head) for locating another name space,
    and a `GenericName` (as tail) valid in that name space.

    Attributes:
        head (LocalName): The first element in the sequence of parsed names.
            The head element must exists in the same name space as this scoped
            name.
        tail (GenericName): Every elements in the sequence of parsed names
            except for the head.
        as_str (str): A string representation of this scoped name.

    """

    head: LocalName
    tail: GenericName
    as_str: str


@dataclass(frozen=True, slots=True)
class TypeName(LocalName):
    """A local name that references a record type."""


@dataclass(frozen=True, slots=True)
class Type:
    """Base interface of type definitions.

    Attributes:
        type_name (TypeName): The name that identifies the type.

    """

    type_name: TypeName


@dataclass(frozen=True, slots=True)
class MemberName(LocalName):
    """A name that references either an attribute slot in a record, an
    attribute, operation, or association role in an object instance or a type
    description in some schema.

    Attributes:
        attribute_type (TypeName):
            The type of data associated with the member.

    """

    attribute_type: TypeName



@dataclass(frozen=True, slots=True)
class RecordType:
    """The type definition of a record. A `RecordType` defines dynamically
    constructed data type.

    Attributes:
        type_name (TypeName): The name that identifies this record type.
        filed_type (dict[str, Type]): The dictionary of all (name, type) pairs
            in this record type.

    """

    type_name: TypeName
    field_type: dict[str, Type]


@dataclass(frozen=True, slots=True)
class Record:
    """A list of logically related fields as (name, value) pairs in a
    dictionary.

    Attributes:
        type_name (TypeName): The type definition of this record.
        filed_type (dict[str, Type]): The dictionary of all (name, type) pairs
            in this record type.

    """

    type: RecordType
    field: dict[str, Type]
