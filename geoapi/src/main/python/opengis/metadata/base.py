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
"""This is the base module.

This subpackage contains geographic metadata structures regarding data
acquisition that are derived from the ISO 19115-2:2019 international
standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass

from opengis.metadata.acquisition import AcquisitionInformation
from opengis.metadata.citation import (
    Citation,
    Date,
    Identifier,
    OnlineResource,
    Responsibility
)
from opengis.metadata.constraints import Constraints
from opengis.metadata.content import ContentInformation
from opengis.metadata.distribution import Distribution
from opengis.metadata.extension import (
    ApplicationSchemaInformation,
    MetadataExtensionInformation
)
from opengis.metadata.identification import Identification
from opengis.metadata.lineage import Lineage
from opengis.metadata.maintenance import (
    MaintenanceInformation,
    ScopeCode
)
from opengis.metadata.quality import DataQuality
from opengis.metadata.representation import SpatialRepresentation
from opengis.referencing.crs import ReferenceSystem


@dataclass(frozen=True, slots=True)
class PortrayalCatalogueReference:
    """Information identifying the portrayal catalogue used.

    Attributes:
        portrayal_catalogue_citation (tuple[Citation, ...]): Bibliographic
            reference to the portrayal catalogue cited.
    """

    portrayal_catalogue_citation: tuple[Citation, ...]


@dataclass(frozen=True, slots=True)
class MetadataScope:
    """Information about the scope of the resource.

    Attributes:
        resource_scope (ScopeCode): Code for the scope.
        name (str): Description of the scope.

    """

    resource_scope: ScopeCode
    name: str | None = None


@dataclass(frozen=True, slots=True)
class Metadata:
    """Root entity which defines metadata about a resource or resources.

    Attributes:
        metadata_identifier (Identifier): Unique identifier for this metadata
            record.
        default_locale (PT_Locale): Identifier and onlineResource for a parent
            metadata record.
        parent_metadata (Citation): 
        metadata_scope (tuple[MetadataScope, ...]): The scope or type of
            resource for which metadata is provided.
        contact (tuple[Responsibility, ...]): Party responsible for the
            metadata information.
        date_info (tuple[Date, ...]): Date(s) other than creation date.
            A `metadata.citation.Date` object. Example: expiry date.
        metadata_standard (tuple[Citation, ...]): Citation for the standards
            to which the metadata conforms.
        metadata_profile (tuple[Citation, ...]): Citation(s) for the
            profile(s) of the metadata standard to which the metadata conform.
        alternative_metadata_reference (tuple[Citation, ...]): Unique
            Identifier and onlineResource for alternative metadata.
        metadata_linkage (tuple[OnlineResource, ...]): Online location where
            the metadata is available.
        spatial_representation_info (tuple[SpatialRepresentation, ...]):
            Digital representation of spatial information in the dataset.
        reference_system_info (tuple[ReferenceSystem, ...]): Description of
            the spatial and temporal reference systems used in the dataset.
            The reference system may be:

            * An ISO 19111 object such as `CoordinateReferenceSystem`.
            * A `ReferenceSystem` with the `identifier` property (from
                ISO 19111) sets to a list of `Identifier` values such as
                `["EPSG::4326"]`.
            * An object with the `referenceSystemIdentifier` property (from
                ISO 19115) sets to a single `Identifier` value such as
                `"EPSG::4326"`, optionally with a `referenceSystemType`
                property sets to a value such as `geodeticGeographic2D`
                or `compoundProjectedTemporal`.

        metadata_extension_info (tuple[MetadataExtensionInformation, ...]):
            Information describing metadata extensions.
        identification_info (tuple[Identification, ...]): Basic information
            about the resource(s) to which the metadata applies.
        content_info (tuple[ContentInformation, ...]): Information about the
            feature and coverage characteristics.
        distribution_info (tuple[Distribution, ...]): Information about the
            distributor of and options for obtaining the resource(s).
        data_quality_info (tuple[DataQuality, ...]): Overall assessment of
            quality of a resource(s).
        resource_lineage (tuple[Lineage, ...]): Information about the
            provenance, sources and/or the production processes applied to
            the resource.
        portrayal_catalogue_info (tuple[PortrayalCatalogueReference, ...]):
            Information about the catalogue of rules defined for the portrayal
            of a resource(s).
        metadata_constraints (tuple[Constraints, ...]): Restrictions on the
            access and use of metadata.
        application_schema_info (tuple[ApplicationSchemaInformation, ...]):
            Information about the conceptual schema of a dataset.
        metadata_maintenance (tuple[MaintenanceInformation, ...]): Information
            about the frequency of metadata updates, and the scope of those
            updates.
        acquisition_information (tuple[AcquisitionInformation, ...]):
            Information about the acquisition of the data.

    """

    metadata_identifier: Identifier
    default_locale: PT_Locale
    parent_metadata: Citation
    metadata_scope: tuple[MetadataScope, ...]
    contact: tuple[Responsibility, ...]
    date_info: tuple[Date, ...]
    metadata_standard: tuple[Citation, ...]
    metadata_profile: tuple[Citation, ...]
    alternative_metadata_reference: tuple[Citation, ...]
    metadata_linkage: tuple[OnlineResource, ...]
    spatial_representation_info: tuple[SpatialRepresentation, ...]
    reference_system_info: tuple[ReferenceSystem, ...]
    metadata_extension_info: tuple[MetadataExtensionInformation, ...]
    identification_info: tuple[Identification, ...]
    content_info: tuple[ContentInformation, ...]
    distribution_info: tuple[Distribution, ...]
    data_quality_info: tuple[DataQuality, ...]
    resource_lineage: tuple[Lineage, ...]
    portrayal_catalogue_info: tuple[PortrayalCatalogueReference, ...]
    metadata_constraints: tuple[Constraints, ...]
    application_schema_info: tuple[ApplicationSchemaInformation, ...]
    metadata_maintenance: tuple[MaintenanceInformation, ...]
    acquisition_information: tuple[AcquisitionInformation, ...]
