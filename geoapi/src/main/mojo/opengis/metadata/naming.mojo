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

"""This is the naming module.

This module contains geographic metadata structures regarding naming derived
from the ISO 19115-1:2014 international standard.
"""


trait NameSpace:
    """A domain in which names are defined."""

    fn is_global(self):
        """Indicates whether this namespace is a "top level" namespace. Global, or top-level namespaces are not contained within another namespace. The global namespace has no parent.
        """
        ...

    fn name(self) -> GenericName:
        """The identifier of this namespace."""
        ...


trait GenericName:
    """A sequence of identifiers rooted within the context of a namespace."""

    fn depth(self) -> Int:
        """Indicates the number of levels specified by this name. For any `LocalName`, it is always one. For a `ScopedName` it is some number greater than or equal to 2.
        """
        ...

    # The following function creates a recursive definition
    # fn parsed_name[ElementType: LocalNameCollectionElement](self) -> Tuple[ElementType]:
    #     """The sequence of local names making this generic name. The length of this sequence is the depth. It does not include the scope."""
    #     ...

    fn scope(self) -> NameSpace:
        """The scope (name space) in which this name is local. All names carry an association with their scope in which they are considered local, but the scope can be the global namespace.
        """
        ...

    fn fully_qualified_name(self) -> GenericName:
        ...


trait LocalName(GenericName, Stringable):
    """
    Identifier within a name space for a local object.
    Local names are names which are directly accessible to and maintained by a `NameSpace`.
    Names are local to one and only one name space.
    The name space within which they are local is indicated by the scope.
    """

    fn __str__(self) -> String:
        """A string representation of this local name."""
        ...


trait LocalNameCollectionElement(CollectionElement, LocalName):
    """
    Abstract collection element conforming to the LocalName trait.
    """

    ...


trait ScopedName(GenericName, Stringable):
    """A composite of a `LocalName` (as head) for locating another name space, and a `GenericName` (as tail) valid in that name space.
    """

    fn head(self) -> LocalName:
        """The first element in the sequence of parsed names. The head element must exists in the same name space as this scoped name.
        """
        ...

    fn tail(self) -> GenericName:
        """Every elements in the sequence of parsed names except for the head.
        """
        ...

    fn __str__(self) -> String:
        """A string representation of this scoped name."""
        ...


trait TypeName(LocalName):
    """A local name that references a record type."""

    fn __str__(self) -> String:
        """A string representation of this type name."""
        ...


trait Type:
    """Base interface of type definitions."""

    fn type_name(self) -> TypeName:
        """The name that identifies this type."""
        ...


trait MemberName(LocalName):
    """A name that references either an attribute slot in a record, an attribute, operation, or association role in an object instance or a type description in some schema.
    """

    fn attribute_type(self) -> TypeName:
        """The type of the data associated with the member."""
        ...

    fn __str__(self) -> String:
        """A string representation of this member name."""
        ...


trait RecordType(Type):
    """The type definition of a record. A `RecordType` defines dynamically constructed data type.
    """

    fn type_name(self) -> TypeName:
        """The name that identifies this record type."""
        ...

    fn field_type(self):
        """The dictionary of all (name, type) pairs in this record type."""
        ...


trait Record:
    """A list of logically related fields as (name, value) pairs in a dictionary.
    """

    fn type(self) -> RecordType:
        """The type definition of this record."""
        ...

    fn field(self):
        """The dictionary of all (name, value) pairs in this record."""
        ...
