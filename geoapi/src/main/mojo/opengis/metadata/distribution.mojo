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

# author: OGC Topic 11 (for abstract model and documentation), David Meaux

"""This is the `distribution` module.

This module contains geographic metadata structures regarding data
distribution derived from the ISO 19115-1:2014 international standard.
"""

from collections import Optional

from opengis.metadata.citation import (
    Citation,
    Identifier,
    OnlineResource,
    Responsibility,
)


struct MediumFormatCode:
    """Method used to write to the medium."""

    alias CPIO = "cpio"
    """Copy In / Out (UNIX file format and command)."""

    alias TAR = "tar"
    """Tape Archive."""

    alias HIGH_SIERRA = "highSierra"
    """High sierra file system."""

    alias ISO_9660 = "iso9660"
    """Information processing - volume and file structure of CD-ROM."""

    alias ISO_9660_ROCK_RIDGE = "iso9660RockRidge"
    """Rock ridge interchange protocol (UNIX)."""

    alias ISO_9660_APPLE_HFS = "iso9660AppleHFS"
    """Hierarchical file system (Macintosh)."""

    alias UDF = "udf"
    """Universal disk format."""


trait Medium:
    """Information about the media on which the resource can be distributed."""

    fn name(self) -> Optional[Citation]:
        """Name of the medium on which the resource can be received."""
        ...

    fn density(self) -> Optional[Float64]:
        """Density at which the data is recorded.

        Domain: > 0.0
        """
        ...

    fn density_units(self) -> Optional[String]:
        """Units of measure for the recording density."""
        ...

    fn volumes(self) -> Optional[Int]:
        """Number of items in the media identified.

        Domain: > 0
        """
        ...

    fn medium_format(self) -> Optional[Tuple[MediumFormatCode]]:
        """Method used to write to the medium."""
        ...

    fn medium_note(self) -> Optional[String]:
        """Description of other limitations or requirements for using the medium.
        """
        ...

    fn identifier(self) -> Optional[Identifier]:
        """Unique identifier for an instance of the `Medium`."""
        ...


trait Format:
    """Description of the computer language construct that specifies the
    representation of data objects in a record, file, message, storage device
    or transmission channel."""

    fn format_specification_citation(self) -> Citation:
        """Citation/URL of the specification for the format."""
        ...

    fn amendment_number(self) -> Optional[String]:
        """Amendment number of the format version."""
        ...

    fn file_decompression_technique(self) -> Optional[String]:
        """Recommendations of algorithms or processes that can be applied to read
        or expand resources to which compression techniques have been applied.
        """
        ...

    fn medium(self) -> Optional[Tuple[Medium]]:
        """Medium used by the format."""
        ...

    fn format_distributor(self) -> Optional[Tuple["Distributor"]]:
        """Provides information about the distributor of the format."""
        ...


trait DataFile:
    """Description of a transfer data file."""

    fn file_name(self) -> String:
        """Name of the file that contains the data."""
        ...

    fn file_description(self) -> String:
        """Text description of the data."""
        ...

    fn file_type(self) -> String:
        """Format in which the data is encoded."""
        ...

    fn feature_types(self) -> Tuple[GenericName]:
        """Provides the list of feature types concerned by the transfer data file.
        """
        ...


trait StandardOrderProcess:
    """Common ways in which the resource may be obtained or received, and related
    instructions and fee information."""

    fn fees(self) -> Optional[String]:
        """Fees and terms for retrieving the resource. Include monetary units
        (as specified in ISO 4217).
        """
        ...

    fn planned_available_date_time(self) -> Optional[datetime]:
        """Date and time when the resource will be available."""
        ...

    fn ordering_instructions(self) -> Optional[String]:
        """General instructions, terms and services provided by the distributor.
        """
        ...

    fn turnaround(self) -> Optional[String]:
        """Typical turnaround time for the filling of an order."""
        ...

    fn order_options_type(self) -> Optional[RecordType]:
        """Description of the order options record."""
        ...

    fn order_options(self) -> Optional[Record]:
        """Request/purchase choices."""
        ...


trait Distributor:
    """Information about the distributor."""

    fn distributor_contact(self) -> Responsibility:
        """Party from whom the resource may be obtained. This list need not be
        exhaustive.
        """
        ...

    fn distribution_order_process(
        self,
    ) -> Optional[Tuple[StandardOrderProcess]]:
        """Provides information abouthowthe resource may be obtained and related
        instructions and fee information.
        """
        ...

    fn distributor_format(self) -> Optional[Tuple[Format]]:
        """Provides information about the format used by the distributor."""
        ...

    fn distributor_transfer_options(
        self,
    ) -> Optional[Tuple["DigitalTransferOptions"]]:
        """Provides information about the technical means and media used by
        the distributor.
        """
        ...


trait Distribution:
    """Information about the distributor of and options for obtaining the
    resource."""

    fn description(self) -> Optional[String]:
        """Brief description of a set of distribution options."""
        ...

    fn distribution_format(self) -> Optional[Tuple[Format]]:
        """Provides the description of the format of the data to be distributed.
        """
        ...

    fn distributor(self) -> Optional[Tuple[Distributor]]:
        """Provides information about the distributor."""
        ...

    fn transfer_options(self) -> Optional[Tuple["DigitalTransferOptions"]]:
        """Provides information about technical means and media by which a
        resource is obtained from the distributor.
        """
        ...


trait DigitalTransferOptions:
    """Technical means and media by which a resource is obtained from the
    distributor."""

    fn units_of_distribution(self) -> Optional[String]:
        """Tiles, layers, geographic areas, etc., in which data is available.

        NOTE: units_of_distribution applies to both onLine and offLine
        distributions.
        """
        ...

    fn transfer_size(self) -> Optional[Float64]:
        """Estimated size of a unit in the specified transfer format, expressed
        in megabytes.

        NOTE: The transfer size is > 0.0.

        Domain: > 0.0
        """
        ...

    fn on_line(self) -> Optional[Tuple[OnlineResource]]:
        """Information about online sources from which the resource can be
        obtained.
        """
        ...

    fn off_line(self) -> Optional[Tuple[Medium]]:
        """Information about offline media on which the resource can be obtained.
        """
        ...

    fn transfer_frequency(self) -> Optional[timedelta]:
        """Rate of occurrence of distribution."""
        ...

    fn distribution_format(self) -> Optional[Tuple[Format]]:
        """Format of distribution."""
        ...
