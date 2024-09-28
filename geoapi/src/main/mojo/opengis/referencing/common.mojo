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

# author: OGC Topic 2 (for abstract model and documentation), David Meaux

"""This is the `common` module.

This module contains geographic metadata structures derived from the
Common Classes package in the ISO 19111:2019 international standard.
"""

from collections import Optional

from opengis.metadata.citation import Identifier
from opengis.metadata.extent import Extent
from opengis.metadata.naming import GenericName


trait ObjectDomain:
    """The scope and validity of a CRS-related object."""

    fn scope(self) -> String:
        """Description of usage, or limitations of usage, for which this object
        is valid. If unknown, enter "not known".
        """
        ...

    fn domain_of_validity(self) -> Extent:
        """The spatial and temporal extent in which this object is valid."""
        ...


trait IdentifiedObject:
    """Identifications of a CRS-related object."""

    fn name(self) -> Identifier:
        """The primary name by which this object is identified."""
        ...

    fn identifier(self) -> Optional[Tuple[Identifier]]:
        """An identifier which references elsewhere the object's defining
        information; alternatively an identifier by which this object can be
        referenced.
        """
        ...

    fn identified_object_alias(self) -> Optional[Tuple[GenericName]]:
        """An alternative name by which this object is identified."""
        ...

    fn remarks(self) -> Optional[Tuple[String]]:
        """Comments on or information about this object, including data source
        information.
        """
        ...

    fn domain(self) -> Optional[Tuple[ObjectDomain]]:
        """The scope and validity of the object."""
        ...

    fn to_wkt(self) -> String:
        """Returns a Well-Known Text (WKT) for this object."""
        ...
