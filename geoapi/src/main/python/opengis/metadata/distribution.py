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
"""This is the `distribution` module.

This module contains geographic metadata structures regarding data
distribution derived from the ISO 19115-1:2014 international standard.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from collections.abc import Sequence
from datetime import datetime, timedelta
from enum import Enum

import opengis.metadata.citation as meta_citation
import opengis.metadata.naming as meta_naming

__author__ = "OGC Topic 11 (for abstract model and documentation), " +\
    "Martin Desruisseaux (Geomatys), David Meaux (Geomatys)"


class MediumFormatCode(Enum):
    """Method used to write to the medium."""

    CPIO = "cpio"
    """Copy In / Out (UNIX file format and command)."""

    TAR = "tar"
    """Tape Archive."""

    HIGH_SIERRA = "highSierra"
    """High sierra file system."""

    ISO_9660 = "iso9660"
    """Information processing - volume and file structure of CD-ROM."""

    ISO_9660_ROCK_RIDGE = "iso9660RockRidge"
    """Rock ridge interchange protocol (UNIX)."""

    ISO_9660_APPLE_HFS = "iso9660AppleHFS"
    """Hierarchical file system (Macintosh)."""

    UDF = "udf"
    """Universal disk format."""


class Medium(ABC):
    """Information about the media on which the resource can be distributed."""

    @property
    @abstractmethod
    def name(self) -> meta_citation.Citation | None:
        """Name of the medium on which the resource can be received."""

    @property
    @abstractmethod
    def density(self) -> float | None:
        """
        Density at which the data is recorded.

        Domain: > 0.0
        """

    @property
    @abstractmethod
    def density_units(self) -> str | None:
        """Units of measure for the recording density."""

    @property
    @abstractmethod
    def volumes(self) -> int | None:
        """
        Number of items in the media identified.

        Domain: > 0
        """

    @property
    @abstractmethod
    def medium_format(self) -> Sequence[MediumFormatCode] | None:
        """Method used to write to the medium."""

    @property
    @abstractmethod
    def medium_note(self) -> str | None:
        """
        Description of other limitations or requirements for using the medium.
        """

    @property
    @abstractmethod
    def identifier(self) -> meta_citation.Identifier | None:
        """Unique identifier for an instance of the `Medium`."""


class Format(ABC):
    """
    Description of the computer language construct that specifies the
    representation of data objects in a record, file, message, storage device
    or transmission channel.
    """

    @property
    @abstractmethod
    def format_specification_citation(self) -> meta_citation.Citation:
        """Citation/URL of the specification for the format."""

    @property
    @abstractmethod
    def amendment_number(self) -> str | None:
        """Amendment number of the format version."""

    @property
    @abstractmethod
    def file_decompression_technique(self) -> str | None:
        """
        Recommendations of algorithms or processes that can be applied to read
        or expand resources to which compression techniques have been applied.
        """

    @property
    @abstractmethod
    def medium(self) -> Sequence[Medium] | None:
        """Medium used by the format."""

    @property
    @abstractmethod
    def format_distributor(self) -> Sequence[Distributor] | None:
        """Provides information about the distributor of the format."""


class DataFile(ABC):
    """Description of a transfer data file."""

    @property
    @abstractmethod
    def file_name(self) -> str:
        """Name of the file that contains the data."""

    @property
    @abstractmethod
    def file_description(self) -> str:
        """Text description of the data."""

    @property
    @abstractmethod
    def file_type(self) -> str:
        """Format in which the data is encoded."""

    @property
    @abstractmethod
    def feature_types(self) -> Sequence[meta_naming.GenericName]:
        """
        Provides the list of feature types concerned by the transfer data file.
        """


class StandardOrderProcess(ABC):
    """
    Common ways in which the resource may be obtained or received, and related
    instructions and fee information.
    """

    @property
    @abstractmethod
    def fees(self) -> str | None:
        """
        Fees and terms for retrieving the resource. Include monetary units
        (as specified in ISO 4217).
        """

    @property
    @abstractmethod
    def planned_available_date_time(self) -> datetime | None:
        """Date and time when the resource will be available."""

    @property
    @abstractmethod
    def ordering_instructions(self) -> str | None:
        """
        General instructions, terms and services provided by the distributor.
        """

    @property
    @abstractmethod
    def turnaround(self) -> str | None:
        """Typical turnaround time for the filling of an order."""

    @property
    @abstractmethod
    def order_options_type(self) -> meta_naming.RecordType | None:
        """Description of the order options record."""

    @property
    @abstractmethod
    def order_options(self) -> meta_naming.Record | None:
        """Request/purchase choices."""


class Distributor(ABC):
    """Information about the distributor."""

    @property
    @abstractmethod
    def distributor_contact(self) -> meta_citation.Responsibility:
        """
        Party from whom the resource may be obtained. This list need not be
        exhaustive.
        """

    @property
    @abstractmethod
    def distribution_order_process(self) -> Sequence[
        StandardOrderProcess
    ] | None:
        """
        Provides information abouthowthe resource may be obtained and related
        instructions and fee information.
        """

    @property
    @abstractmethod
    def distributor_format(self) -> Sequence[Format] | None:
        """Provides information about the format used by the distributor."""

    @property
    @abstractmethod
    def distributor_transfer_options(self) -> Sequence[
        DigitalTransferOptions
    ] | None:
        """
        Provides information about the technical means and media used by
        the distributor.
        """


class Distribution(ABC):
    """
    Information about the distributor of and options for obtaining the
    resource.
    """

    @property
    @abstractmethod
    def description(self) -> str | None:
        """Brief description of a set of distribution options."""

    @property
    @abstractmethod
    def distribution_format(self) -> Sequence[Format] | None:
        """
        Provides the description of the format of the data to be distributed.
        """

    @property
    @abstractmethod
    def distributor(self) -> Sequence[Distributor] | None:
        """Provides information about the distributor."""

    @property
    @abstractmethod
    def transfer_options(self) -> Sequence[DigitalTransferOptions] | None:
        """
        Provides information about technical means and media by which a
        resource is obtained from the distributor.
        """


class DigitalTransferOptions(ABC):
    """
    Technical means and media by which a resource is obtained from the
    distributor.
    """

    @property
    @abstractmethod
    def units_of_distribution(self) -> str | None:
        """
        Tiles, layers, geographic areas, etc., in which data is available.

        NOTE: units_of_distribution applies to both onLine and offLine
        distributions.
        """

    @property
    @abstractmethod
    def transfer_size(self) -> float | None:
        """
        Estimated size of a unit in the specified transfer format, expressed
        in megabytes.

        NOTE: The transfer size is > 0.0.

        Domain: > 0.0
        """

    @property
    @abstractmethod
    def on_line(self) -> Sequence[meta_citation.OnlineResource] | None:
        """
        Information about online sources from which the resource can be
        obtained.
        """

    @property
    @abstractmethod
    def off_line(self) -> Sequence[Medium] | None:
        """
        Information about offline media on which the resource can be obtained.
        """

    @property
    @abstractmethod
    def transfer_frequency(self) -> timedelta | None:
        """Rate of occurrence of distribution."""

    @property
    @abstractmethod
    def distribution_format(self) -> Sequence[Format] | None:
        """Format of distribution."""
