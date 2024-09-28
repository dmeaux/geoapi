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

"""This is the `base` module.

This subpackage contains geographic metadata structures regarding data
acquisition that are derived from theISO 19115-1:2014 and ISO 19115-2:2019
international standards.
"""

from collections import Optional

from opengis.metadata.acquisition import AcquisitionInformation
from opengis.metadata.citation import (
    Citation,
    Date,
    Identifier,
    OnlineResource,
    Responsibility,
)
from opengis.metadata.constraints import Constraints
from opengis.metadata.content import ContentInformation
from opengis.metadata.distribution import Distribution
from opengis.metadata.extension import (
    ApplicationSchemaInformation,
    MetadataExtensionInformation,
)
from opengis.metadata.identification import Identification
from opengis.metadata.lineage import Lineage
from opengis.metadata.maintenance import MaintenanceInformation, ScopeCode
from opengis.metadata.quality import DataQuality
from opengis.metadata.representation import SpatialRepresentation
from opengis.referencing.crs import ReferenceSystem


trait PortrayalCatalogueReference:
    """Information identifying the portrayal catalogue used."""

    fn portrayal_catalogue_citation(self) -> Tuple[Citation]:
        """Bibliographic reference to the portrayal catalogue cited."""
        ...


trait MetadataScope:
    """Information about the scope of the resource."""

    fn resource_scope(self) -> ScopeCode:
        """Code for the scope. Default = 'dataset'."""
        ...

    fn name(self) -> Optional[String]:
        """Description of the scope."""
        ...


trait Metadata:
    """Root entity which defines metadata about a resource or resources."""

    fn metadata_identifier(self) -> Optional[Identifier]:
        """Unique identifier for this metadata record."""
        ...

    fn default_locale(self) -> Optional[String]:
        """Language and character set used for documenting metadata.
        A string conforming to IETF BCP 47.

        MANDATORY:
            If UTF-8 not used and not defined in encoding.
        """
        ...

    fn parent_metadata(self) -> Optional[Citation]:
        """Identification of the parent metadata record.

        MANDATORY:
            If there is an upper level object.
        """
        ...

    fn contact(self) -> Tuple[Responsibility]:
        """Party responsible for the metadata information."""
        ...

    fn date_info(self) -> Tuple[Date]:
        """Date(s) associated with the metadata.

        NOTE: 'Creation' date must be provided, others can also be provided.
        """
        ...

    fn metadata_standard(self) -> Optional[Tuple[Citation]]:
        """Citation for the standards to which the metadata conforms.

        NOTE: Metadata standard citations should include an identifier.
        """
        ...

    fn metadata_profile(self) -> Optional[Tuple[Citation]]:
        """Citation(s) for the profile(s) of the metadata standard to which the
        metadata conform.

        NOTE: Metadata citations should include an identifier.
        """
        ...

    fn alternative_metadata_reference(self) -> Optional[Tuple[Citation]]:
        """Reference to alternative metadata,e.g., Dublin Core, FGDC, or metadata
        in a non-ISO standard for the same resource.
        """
        ...

    fn other_locale(self) -> Optional[Tuple[String]]:
        """Provides information about an alternatively used localized character
        strings. A string conforming to IETF BCP 47.
        """
        ...

    fn metadata_linkage(self) -> Optional[Tuple[OnlineResource]]:
        """Online location where the metadata is available."""
        ...

    fn spatial_representation_info(
        self,
    ) -> Optional[Tuple[SpatialRepresentation]]:
        """Digital representation of spatial information in the dataset."""
        ...

    fn reference_system_info(self) -> Optional[Tuple[ReferenceSystem]]:
        """Description of the spatial and temporal reference systems used in
        the dataset.

        The reference system may be:
        - An ISO 19111 object such as `CoordinateReferenceSystem`.
        - A `ReferenceSystem` with the `identifier` property (from
            ISO 19111) sets to a list of `Identifier` values such as
            `["EPSG::4326"]`.
        - An object with the `referenceSystemIdentifier` property (from
            ISO 19115) sets to a single `Identifier` value such as
                `"EPSG::4326"`,
        The ReferenceSystem object may optionally have a
            `reference_system_type_code` property set to a value such as
            `geodeticGeographic2D` or `compoundProjectedTemporal`.
        """
        ...

    fn metadata_extension_info(
        self,
    ) -> Optional[Tuple[MetadataExtensionInformation]]:
        """Information describing metadata extensions."""
        ...

    fn identification_info(self) -> Tuple[Identification]:
        """Basic information about the resource(s) to which the metadata applies.
        """
        ...

    fn content_info(self) -> Optional[Tuple[ContentInformation]]:
        """Information about the feature and coverage characteristics."""
        ...

    fn distribution_info(self) -> Optional[Tuple[Distribution]]:
        """Information about the distributor of and options for obtaining the
        resource(s).
        """
        ...

    fn data_quality_info(self) -> Optional[Tuple[DataQuality]]:
        """Overall assessment of quality of a resource(s)."""
        ...

    fn portrayal_catalogue_info(
        self,
    ) -> Optional[Tuple[PortrayalCatalogueReference]]:
        """Information about the catalogue of rules defined for the portrayal of
        a resource(s).
        """
        ...

    fn metadata_constraints(self) -> Optional[Tuple[Constraints]]:
        """Restrictions on the access and use of metadata."""
        ...

    fn application_schema_info(
        self,
    ) -> Optional[Tuple[ApplicationSchemaInformation]]:
        """Information about the conceptual schema of a dataset."""
        ...

    fn metadata_maintenance(self) -> Optional[MaintenanceInformation]:
        """Information about the frequency of metadata updates, and the scope of
        those updates.
        """
        ...

    fn resource_lineage(self) -> Optional[Tuple[Lineage]]:
        """Information about the provenance, sources and/or the production
        processes applied to the resource.
        """
        ...

    fn metadata_scope(self) -> Optional[Tuple[MetadataScope]]:
        """The scope or type of resource for which metadata is provided.

        MANDATORY:
            If `Metadata` is about a resource other than a dataset.
        """
        ...

    fn acquisition_information(self) -> Optional[Tuple[AcquisitionInformation]]:
        """Information about the acquisition of the data."""
        ...
