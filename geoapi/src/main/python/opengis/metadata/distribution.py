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

from dataclasses import dataclass
from datetime import datetime
from enum import Enum

from opengis.metadata.citation import (
    Citation, Identifier, OnlineResource, Responsibility
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


@dataclass(frozen=True, slots=True)
class Medium:
    """Information about the media on which the resource can be distributed.

    Attributes:
        name (Citation): Name of the medium on which the resource can be
            received.
        density (float): Density at which the data is recorded.
        density_units (str): Units of measure for the recording density.
        volumes (int): Number of items in the media identified.
        medium_format (tuple[MediumFormatCode, ...]): Method used to write to
            the medium.
        medium_note (str): Description of other limitations or requirements
            for using the medium.
        identifier (Identifier):

    """

    name: Citation
    density: float
    density_units: str
    volumes: int
    medium_format: tuple[MediumFormatCode, ...]
    medium_note: str
    identifier: Identifier


@dataclass(frozen=True, slots=True)
class Format:
    """Description of the computer language construct that specifies the
    representation of data objects in a record, file, message, storage device
    or transmission channel.

    Attrubutes:
        format_specification_citation (Citation): Citation/URL of the
            specification for the format.
        amendment_number (str): Amendment number of the format version.
        file_decompression_technique (str): Recommendations of algorithms or
            processes that can be applied to read or expand resources to which
            compression techniques have been applied.
        medium (tuple[Medium, ...]): Medium used by the format.
        format_distributor (tuple[Distributor, ...]): 

    """

    format_specification_citation: Citation
    amendment_number: str
    file_decompression_technique: str
    medium: tuple[Medium, ...]
    format_distributor: tuple["Distributor", ...]


@dataclass(frozen=True, slots=True)
class DataFile:
    """Description of a transfer data file.

    Attributes:
        file_name (str): Name of the file that contains the data.
        file_description (str): Text description of the data.
        file_type (str): Format in which the data is encoded.
        feature_types (tuple[GenericName, ...]): Provides the list of feature
            types concerned by the transfer data file.

    """

    file_name: str
    file_description: str
    file_type: str
    feature_types: tuple[GenericName, ...]


@dataclass(frozen=True, slots=True)
class DigitalTransferOptions:
    """Technical means and media by which a resource is obtained from the
    distributor.

    Attributes:
        units_of_distribution (str): Tiles, layers, geographic areas, etc., in
            which data is available. NOTE: units_of_distribution applies to
            both onLine and offLine distributions.
        transfer_size (float): Estimated size of a unit in the specified
            transfer format, expressed in megabytes. The transfer size
            is > 0.0.
        on_line (tuple[OnlineResource, ...]): Information about online sources
            from which the resource can be obtained.
        off_line (tuple[Medium, ...]): Information about offline media on
            which the resource can be obtained.
        transfer_frequency (str): Rate of occurrence of distribution.
        distribution_format (tuple[Format, ...]): Format(s) of distribution.

    """

    units_of_distribution: str
    transfer_size: float
    on_line: tuple[OnlineResource, ...]
    off_line: tuple[Medium, ...]
    transfer_frequency: TM_PeriodDuration
    distribution_format: tuple[Format, ...]


@dataclass(frozen=True, slots=True)
class StandardOrderProcess:
    """Common ways in which the resource may be obtained or received, and
    related instructions and fee information.

    Attributes:
        fees (str): Fees and terms for retrieving the resource. Include
            monetary units (as specified in ISO 4217).
        planned_available_date_time (datetime): Date and time when the
            resource will be available.
        ordering_instructions (str): General instructions, terms and services
            provided by the distributor.
        turnaround (str): Typical turnaround time for the filling of an order.
        order_options_type (RecordType): Description of the order options
            record.
        order_options (Record): Request/purchase choices.

    """

    fees: str
    planned_available_date_time: datetime
    ordering_instructions: str
    turnaround: str
    order_options_type: RecordType
    order_options: Record


@dataclass(frozen=True, slots=True)
class Distributor:
    """Information about the distributor.

    Attributes:
        distributor_contact (Responsibility): Party from whom the resource may
            be obtained. This list need not be exhaustive.
        distribution_order_process (tuple[StandardOrderProcess, ...]): 
        distributor_format (tuple[Format, ...]): 
        distributor_transfer_options (tuple[DigitalTransferOptions, ...]): 

    """

    distributor_contact: Responsibility
    distribution_order_process: tuple[StandardOrderProcess, ...]
    distributor_format: tuple[Format, ...]
    distributor_transfer_options: tuple[DigitalTransferOptions, ...]


@dataclass(frozen=True, slots=True)
class Distribution:
    """Information about the distributor of and options for obtaining the
    resource.

    Attributes:
        description (str): 
        distribution_format (tuple[Format, ...]): 
        distributor (tuple[Distributor, ...]): 
        transfer_options (tuple[DigitalTransferOptions, ...]): 

    """

    description: str
    distribution_format: tuple[Format, ...]
    distributor: tuple[Distributor, ...]
    transfer_options: tuple[DigitalTransferOptions, ...]
