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
"""This is the primitive module.

This module contains primitive geometry data structures derived from
the ISO 19107 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from abc import ABC, abstractmethod

from opengis.referencing.crs import CoordinateReferenceSystem


class DirectPosition(ABC):
    """
    Holds the coordinates for a position within some coordinate
    reference system.
    """

    @property
    @abstractmethod
    def coordinate_reference_system(self) -> CoordinateReferenceSystem:
        """
        The coordinate reference system in which the coordinate tuple is given.
        """

    @property
    @abstractmethod
    def dimension(self) -> int:
        """The length of coordinate sequence (the number of entries)."""
