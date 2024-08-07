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
"""This is the distribution module.

This module contains geographic metadata structures regarding data
distribution derived from the ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from abc import ABC, abstractmethod
from collections.abc import Sequence
from datetime import datetime
from enum import Enum

from opengis.metadata.citation import (
    Citation,
    Identifier,
    OnlineResource,
    Responsibility,
)
from opengis.metadata.naming import GenericName, Record, RecordType


class MediumFormatCode(Enum):
    """Method used to write to the medium."""

    CPIO = "cpio"
    TAR = "tar"
    HIGH_SIERRA = "highSierra"
    ISO_9660 = "iso9660"
    ISO_9660_ROCK_RIDGE = "iso9660RockRidge"
    ISO_9660_APPLE_HFS = "iso9660AppleHFS"
    UDF = "udf"


class Medium(ABC):
    """Information about the media on which the resource can be distributed."""

    @property
    @abstractmethod
    def name(self) -> Citation:
        """Name of the medium on which the resource can be received."""

    @property
    @abstractmethod
    def density(self) -> float:
        """Density at which the data is recorded."""

    @property
    @abstractmethod
    def density_units(self):
        """Units of measure for the recording density."""

    @property
    @abstractmethod
    def volumes(self) -> int:
        """Number of items in the media identified."""

    @property
    @abstractmethod
    def medium_format(self) -> Sequence[MediumFormatCode]:
        """Method used to write to the medium."""

    @property
    @abstractmethod
    def medium_note(self) -> str:
        """
        Description of other limitations or requirements for using the medium.
        """

    @property
    @abstractmethod
    def identifier(self) -> Identifier:
        """"""


class Format(ABC):
    """
    Description of the computer language construct that specifies the
    representation of data objects in a record, file, message, storage device
    or transmission channel.
    """

    @property
    @abstractmethod
    def format_specification_citation(self) -> Citation:
        """Citation/URL of the specification for the format."""

    @property
    @abstractmethod
    def amendment_number(self) -> str:
        """Amendment number of the format version."""

    @property
    @abstractmethod
    def file_decompression_technique(self) -> str:
        """
        Recommendations of algorithms or processes that can be applied to read
        or expand resources to which compression techniques have been applied.
        """

    @property
    @abstractmethod
    def medium(self) -> Sequence[Medium]:
        """Medium used by the format."""

    @property
    @abstractmethod
    def format_distributor(self) -> Sequence['Distributor']:
        """"""


class DataFile(ABC):
    """Description of a transfer data file."""

    @property
    @abstractmethod
    def file_name(self):
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
    def feature_types(self) -> Sequence[GenericName]:
        """
        Provides the list of feature types concerned by the transfer data file.
        """


class DigitalTransferOptions(ABC):
    """
    Technical means and media by which a resource is obtained from the
    distributor.
    """

    @property
    @abstractmethod
    def units_of_distribution(self) -> str:
        """
        Tiles, layers, geographic areas, etc., in which data is available.
        NOTE: units_of_distribution applies to both onLine and offLine
        distributions.
        """

    @property
    @abstractmethod
    def transfer_size(self) -> float:
        """
        Estimated size of a unit in the specified transfer format, expressed
        in megabytes. The transfer size is > 0.0.
        """

    @property
    @abstractmethod
    def on_line(self) -> Sequence[OnlineResource]:
        """
        Information about online sources from which the resource can be
        obtained.
        """

    @property
    @abstractmethod
    def off_line(self) -> Sequence[Medium]:
        """
        Information about offline media on which the resource can be obtained.
        """

    @property
    @abstractmethod
    def transfer_frequency(self):
        """Rate of occurrence of distribution."""

    @property
    @abstractmethod
    def distribution_format(self) -> Sequence[Format]:
        """Format of distribution."""


class StandardOrderProcess(ABC):
    """
    Common ways in which the resource may be obtained or received, and related
    instructions and fee information.
    """

    @property
    @abstractmethod
    def fees(self) -> str:
        """
        Fees and terms for retrieving the resource. Include monetary units
        (as specified in ISO 4217).
        """

    @property
    @abstractmethod
    def planned_available_date_time(self) -> datetime:
        """Date and time when the resource will be available."""

    @property
    @abstractmethod
    def ordering_instructions(self) -> str:
        """
        General instructions, terms and services provided by the distributor.
        """

    @property
    @abstractmethod
    def turnaround(self) -> str:
        """Typical turnaround time for the filling of an order."""

    @property
    @abstractmethod
    def order_options_type(self) -> RecordType:
        """Description of the order options record."""

    @property
    @abstractmethod
    def order_options(self) -> Record:
        """Request/purchase choices."""


class Distributor(ABC):
    """Information about the distributor."""

    @property
    @abstractmethod
    def distributor_contact(self) -> Responsibility:
        """
        Party from whom the resource may be obtained. This list need not be
        exhaustive.
        """

    @property
    @abstractmethod
    def distribution_order_process(self) -> Sequence[StandardOrderProcess]:
        """"""

    @property
    @abstractmethod
    def distributor_format(self) -> Sequence[Format]:
        """"""

    @property
    @abstractmethod
    def distributor_transfer_options(self) -> Sequence[DigitalTransferOptions]:
        """"""


class Distribution(ABC):
    """
    Information about the distributor of and options for obtaining the
    resource.
    """

    @property
    @abstractmethod
    def description(self) -> str:
        """"""

    @property
    @abstractmethod
    def distribution_format(self) -> Sequence[Format]:
        """"""

    @property
    @abstractmethod
    def distributor(self) -> Sequence[Distributor]:
        """"""

    @property
    @abstractmethod
    def transfer_options(self) -> Sequence[DigitalTransferOptions]:
        """"""
