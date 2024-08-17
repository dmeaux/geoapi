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
"""This is the maintenance module.

This module contains geographic metadata structures regarding data maintenance
derived from the ISO 19115-1:2014 international standard.
"""

from opengis.metadata.citation import Date, Responsibility
from opengis.metadata.extent import Extent

struct MaintenanceFrequencyCode():
    alias CONTINUAL = "continual"
    alias DAILY = "daily"
    alias WEEKLY = "weekly"
    alias FORTNIGHTLY = "fortnightly"
    alias MONTHLY = "monthly"
    alias QUARTERLY = "quarterly"
    alias BIANNUALLY = "biannually"
    alias ANNUALLY = "annually"
    alias AS_NEEDED = "asNeeded"
    alias IRREGULAR = "irregular"
    alias NOT_PLANNED = "notPlanned"
    alias UNKNOWN = "unknown"
    alias PERIODIC = "periodic"
    alias SEMIMONTHLY = "semimonthly"
    alias BIENNIALLY = "biennially"


struct ScopeCode():
    alias COLLECTION_HARDWARE = "collectionHardware"
    alias COLLECTION_SESSION = "collectionSession"
    alias SERIES = "series"
    alias DATASET = "dataset"
    alias NON_GEOGRAPHIC_DATASET = "nonGeographicDataset"
    alias DIMENSION_GROUP = "dimensionGroup"
    alias FEATURE_TYPE = "featureType"
    alias FEATURE = "feature"
    alias ATTRIBUTE_TYPE = "attributeType"
    alias ATTRIBUTE = "attribute"
    alias PROPERTY_TYPE = "propertyType"
    alias FIELD_SESSION = "fieldSession"
    alias SOFTWARE = "software"
    alias SERVICE = "service"
    alias MODEL = "model"
    alias TILE = "tile"
    alias METADATA = "metadata"
    alias INITIATIVE = "initiative"
    alias SAMPLE = "sample"
    alias DOCUMENT = "document"
    alias REPOSITORY = "repository"
    alias AGGREGATE = "aggregate"
    alias PRODUCT = "product"
    alias COLLECTION = "collection"
    alias COVERAGE = "coverage"
    alias APPLICATION = "application"


trait ScopeDescription():
    """Description of the trait of information covered by the information."""

    fn attributes(self) -> Sequence[String]:
        """Instances of attribute types to which the information applies."""
        ...

    fn features(self) -> Sequence[String]:
        """Instances of feature types to which the information applies."""
        ...

    fn feature_instances(self) -> Sequence[String]:
        """Feature instances to which the information applies."""
        ...

    fn attribute_instances(self) -> Sequence[String]:
        """Attribute instances to which the information applies."""
        ...

    fn dataset(self) -> String:
        """Dataset to which the information applies."""
        ...

    fn other(self) -> String:
        """Trait of information that does not fall into the other categories to which the information applies."""
        ...


trait Scope():
    """New: information about the scope of the resource."""

    fn level(self) -> ScopeCode:
        """Description of the scope."""
        ...

    fn extent(self) -> Sequence[Extent]:
        ...

    fn level_description(self) -> Sequence[ScopeDescription]:
        ...


trait MaintenanceInformation():
    """Information about the scope and frequency of updating."""

    fn maintenance_and_update_frequency(self) -> MaintenanceFrequencyCode:
        """Frequency with which changes and additions are made to the resource after the initial resource is completed."""
        ...

    fn maintenance_date(self) -> Sequence[Date]:
        """Date information associated with maintenance of resource."""
        ...

    fn user_defined_maintenance_frequency(self):
        """Maintenance period other than those defined."""
        ...

    fn maintenance_scope(self) -> Sequence[Scope]:
        """Information about the scope and extent of maintenance."""
        ...

    fn maintenance_note(self) -> Sequence[String]:
        """Information regarding specific requirements for maintaining the resource."""
        ...

    fn contact(self) -> Sequence[Responsibility]:
        """Identification of, and means of communicating with, person(s) and organisation(s) with responsibility for maintaining the metadata."""
        ...
