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

"""This is the distribution module.

This module contains geographic metadata structures regarding data
distribution derived from the ISO 19115-1:2014 international standard.
"""

from opengis.metadata.citation import Citation, Identifier, OnlineResource, Responsibility


struct MediumFormatCode():
    alias CPIO = "cpio"
    alias TAR = "tar"
    alias HIGH_SIERRA = "highSierra"
    alias ISO_9660 = "iso9660"
    alias ISO_9660_ROCK_RIDGE = "iso9660RockRidge"
    alias ISO_9660_APPLE_HFS = "iso9660AppleHFS"
    alias UDF = "udf"


trait Medium():
    """Information about the media on which the resource can be distributed."""

    fn name(self) -> Citation:
        """Name of the medium on which the resource can be received."""
        ...

    fn density(self) -> Float64:
        """Density at which the data is recorded."""
        ...

    fn density_units(self):
        """Units of measure for the recording density."""
        ...

    fn volumes(self) -> Int:
        """Number of items in the media identified."""
        ...

    fn medium_format(self) -> Sequence[MediumFormatCode]:
        """Method used to write to the medium."""
        ...

    fn medium_note(self) -> String:
        """Description of other limitations or requirements for using the medium."""
        ...

    fn identifier(self) -> Identifier:
        ...


trait Format():
    """Description of the computer language construct that specifies the representation of data objects in a record, file, message, storage device or transmission channel."""

    fn format_specification_citation(self) -> Citation:
        """Citation/URL of the specification for the format."""
        ...

    fn amendment_number(self) -> String:
        """Amendment number of the format version."""
        ...

    fn file_decompression_technique(self) -> String:
        """Recommendations of algorithms or processes that can be applied to read or expand resources to which compression techniques have been applied."""
        ...

    fn medium(self) -> Sequence[Medium]:
        """Medium used by the format."""
        ...

    fn format_distributor(self) -> Sequence['Distributor']:
        ...



from opengis.metadata.naming import GenericName, RecordType, Record

trait DataFile():
    """Description of a transfer data file."""

    fn file_name(self):
        """Name of the file that contains the data."""
        ...

    fn file_description(self) -> String:
        """Text description of the data."""
        ...

    fn file_type(self) -> String:
        """Format in which the data is encoded."""
        ...

    fn feature_types(self) -> Sequence[GenericName]:
        """Provides the list of feature types concerned by the transfer data file."""
        ...


trait DigitalTransferOptions():
    """Technical means and media by which a resource is obtained from the distributor."""

    fn units_of_distribution(self) -> String:
        """Tiles, layers, geographic areas, etc., in which data is available. NOTE: unitsOfDistribution applies to both onLine and offLine distributions."""
        ...

    fn transfer_size(self) -> Float64:
        """Estimated size of a unit in the specified transfer format, expressed in megabytes. The transfer size is > 0.0."""
        ...

    fn on_line(self) -> Sequence[OnlineResource]:
        """Information about online sources from which the resource can be obtained."""
        ...

    fn off_line(self) -> Sequence[Medium]:
        """Information about offline media on which the resource can be obtained."""
        ...

    fn transfer_frequency(self):
        """Rate of occurrence of distribution."""
        ...

    fn distribution_format(self) -> Sequence[Format]:
        """Format of distribution."""
        ...




trait StandardOrderProcess():
    """Common ways in which the resource may be obtained or received, and related instructions and fee information."""

    fn fees(self) -> String:
        """Fees and terms for retrieving the resource. Include monetary units (as specified in ISO 4217)."""
        ...

    fn planned_available_date_time(self) -> datetime:
        """Date and time when the resource will be available."""
        ...

    fn ordering_instructions(self) -> String:
        """General instructions, terms and services provided by the distributor."""
        ...

    fn turnaround(self) -> String:
        """Typical turnaround time for the filling of an order."""
        ...

    fn order_options_type(self) -> RecordType:
        """Description of the order options record."""
        ...

    fn order_options(self) -> Record:
        """Request/purchase choices."""
        ...


trait Distributor():
    """Information about the distributor."""

    fn distributor_contact(self) -> Responsibility:
        """Party from whom the resource may be obtained. This list need not be exhaustive."""
        ...

    fn distribution_order_process(self) -> Sequence[StandardOrderProcess]:
        ...

    fn distributor_format(self) -> Sequence[Format]:
        ...

    fn distributor_transfer_options(self) -> Sequence[DigitalTransferOptions]:
        ...


trait Distribution():
    """Information about the distributor of and options for obtaining the resource."""

    fn description(self) -> String:
        ...

    fn distribution_format(self) -> Sequence[Format]:
        ...

    fn distributor(self) -> Sequence[Distributor]:
        ...

    fn transfer_options(self) -> Sequence[DigitalTransferOptions]:
        ...
