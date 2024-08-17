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
"""This is the base module.

This subpackage contains geographic metadata structures regarding data
acquisition that are derived from the ISO 19115-2:2019 international
standard.
"""

from opengis.metadata.citation import Citation, Identifier, Responsibility, Date, OnlineResource
from opengis.metadata.maintenance import ScopeCode, MaintenanceInformation
from opengis.metadata.representation import SpatialRepresentation
from opengis.metadata.extension import MetadataExtensionInformation, ApplicationSchemaInformation
from opengis.metadata.identification import Identification
from opengis.metadata.content import ContentInformation
from opengis.metadata.distribution import Distribution
from opengis.metadata.quality import DataQuality
from opengis.metadata.lineage import Lineage
from opengis.metadata.constraints import Constraints
from opengis.metadata.acquisition import AcquisitionInformation
from opengis.referencing.crs import ReferenceSystem


trait PortrayalCatalogueReference():
    """Information identifying the portrayal catalogue used."""

    fn portrayal_catalogue_citation(self) -> Sequence[Citation]:
        """Bibliographic reference to the portrayal catalogue cited."""
        ...


trait MetadataScope():
    """ """

    fn resource_scope(self) -> ScopeCode:
        ...

    fn name(self) -> String:
        ...


trait Metadata():
    """Root entity which defines metadata about a resource or resources."""

    fn metadata_identifier(self) -> Identifier:
        """Unique identifier for this metadata record."""
        ...

    fn default_locale(self):
        """Provides information about an alternatively used localized character string for a linguistic extension."""
        ...

    fn parent_metadata(self) -> Citation:
        """Identifier and onlineResource for a parent metadata record."""
        ...

    fn metadata_scope(self) -> Sequence[MetadataScope]:
        """The scope or type of resource for which metadata is provided."""
        ...

    fn contact(self) -> Sequence[Responsibility]:
        """Party responsible for the metadata information."""
        ...

    fn date_info(self) -> Sequence[Date]:
        """Date(s) other than creation date. Example: expiry date."""
        ...

    fn metadata_standard(self) -> Sequence[Citation]:
        """Citation for the standards to which the metadata conforms."""
        ...

    fn metadata_profile(self) -> Sequence[Citation]:
        """Citation(s) for the profile(s) of the metadata standard to which the metadata conform."""
        ...

    fn alternative_metadata_reference(self) -> Sequence[Citation]:
        """Unique Identifier and onlineResource for alternative metadata."""
        ...

    fn metadata_linkage(self) -> Sequence[OnlineResource]:
        """Online location where the metadata is available."""
        ...

    fn spatial_representation_info(self) -> Sequence[SpatialRepresentation]:
        """Digital representation of spatial information in the dataset."""
        ...

    fn reference_system_info(self) -> Sequence[ReferenceSystem]:
        """
        Description of the spatial and temporal reference systems used in the dataset.
        The reference system may be:

        * An ISO 19111 object such as `CoordinateReferenceSystem`.
        * A `ReferenceSystem` with the `identifier` property (from ISO 19111) sets to a list of `Identifier` values such as `["EPSG::4326"]`.
        * An object with the `referenceSystemIdentifier` property (from ISO 19115) sets to a single `Identifier` value such as `"EPSG::4326"`,
          optionally with a `referenceSystemType` property sets to a value such as `geodeticGeographic2D` or `compoundProjectedTemporal`.

        :rtype: Sequence[ReferenceSystem]
        """
        ...

    fn metadata_extension_info(self) -> Sequence[MetadataExtensionInformation]:
        """Information describing metadata extensions."""
        ...

    fn identification_info(self) -> Sequence[Identification]:
        """Basic information about the resource(s) to which the metadata applies."""
        ...

    fn content_info(self) -> Sequence[ContentInformation]:
        """Information about the feature and coverage characteristics."""
        ...

    fn distribution_info(self) -> Sequence[Distribution]:
        """Information about the distributor of and options for obtaining the resource(s)."""
        ...

    fn data_quality_info(self) -> Sequence[DataQuality]:
        """Overall assessment of quality of a resource(s)."""
        ...

    fn resource_lineage(self) -> Sequence[Lineage]:
        """Information about the provenance, sources and/or the production processes applied to the resource."""
        ...

    fn portrayal_catalogue_info(self) -> Sequence[PortrayalCatalogueReference]:
        """Information about the catalogue of rules defined for the portrayal of a resource(s)."""
        ...

    fn metadata_constraints(self) -> Sequence[Constraints]:
        """Restrictions on the access and use of metadata."""
        ...

    fn application_schema_info(self) -> Sequence[ApplicationSchemaInformation]:
        """Information about the conceptual schema of a dataset."""
        ...

    fn metadata_maintenance(self) -> MaintenanceInformation:
        """Information about the frequency of metadata updates, and the scope of those updates."""
        ...

    fn acquisition_information(self) -> Sequence[AcquisitionInformation]:
        """Information about the acquisition of the data."""
        ...
