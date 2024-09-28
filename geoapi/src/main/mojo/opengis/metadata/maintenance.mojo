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

"""This is the `maintenance` module.

This module contains geographic metadata structures regarding data maintenance
derived from the ISO 19115-1:2014 international standard.
"""

from collections import Optional

from opengis.metadata.citation import Date, Responsibility
from opengis.metadata.extent import Extent


struct MaintenanceFrequencyCode:
    """Frequency with which modifications and deletions are made to the data
    after it is first produced
    """

    alias CONTINUAL = "continual"
    """Resource is repeatedly and frequentlyupdated."""

    alias DAILY = "daily"
    """Resource is updated each day"""

    alias WEEKLY = "weekly"
    """Resource is updated on a weekly basis."""

    alias FORTNIGHTLY = "fortnightly"
    """Resource is updated every two weeks."""

    alias MONTHLY = "monthly"
    """Resource is updated each month."""

    alias QUARTERLY = "quarterly"
    """Resource is updatedevery three months."""

    alias BIANNUALLY = "biannually"
    """Resource is updated twice each year."""

    alias ANNUALLY = "annually"
    """Resource is updated every year."""

    alias AS_NEEDED = "asNeeded"
    """Resource is updated as deemed necessary."""

    alias IRREGULAR = "irregular"
    """Resource is updated in intervals that are uneven in duration."""

    alias NOT_PLANNED = "notPlanned"
    """There are no plans to update the data."""

    alias UNKNOWN = "unknown"
    """Frequency of maintenance for the data is not known."""

    alias PERIODIC = "periodic"
    """Resource is updated at regular intervals."""

    alias SEMIMONTHLY = "semimonthly"
    """Resource is updated twice monthly."""

    alias BIENNIALLY = "biennially"
    """Resource is updated every two years."""


struct ScopeCode:
    """trait of information to which the referencing entity applies."""

    alias ATTRIBUTE = "attribute"
    """Information applies to the attribute value."""

    alias ATTRIBUTE_TYPE = "attributeType"
    """Information applies to the characteristic of a feature."""

    alias COLLECTION_HARDWARE = "collectionHardware"
    """Information applies to the collection hardware class."""

    alias COLLECTION_SESSION = "collectionSession"
    """Information applies to the collection session."""

    alias DATASET = "dataset"
    """Information applies to the dataset."""

    alias SERIES = "series"
    """Information applies to the series."""

    alias NON_GEOGRAPHIC_DATASET = "nonGeographicDataset"
    """Information applies to the non-geographic dataset."""

    alias DIMENSION_GROUP = "dimensionGroup"
    """Information applies to a dimension group."""

    alias FEATURE = "feature"
    """Information applies to a featiure."""

    alias FEATURE_TYPE = "featureType"
    """Information applies to a feature type."""

    alias PROPERTY_TYPE = "propertyType"
    """Information applies to a property type."""

    alias FIELD_SESSION = "fieldSession"
    """Information applies to a field session."""

    alias SOFTWARE = "software"
    """Information applies to a computer program or routine."""

    alias SERVICE = "service"
    """Information applies to a capability which a service provider entity makes
    available to s service user entity through a set of interfaces that define
    a behaviour, such as a use case.
    """

    alias MODEL = "model"
    """Information applies to a copy or imitation of an existing or hypothetical
    object.
    """

    alias TILE = "tile"
    """Information applies to a tile, a spatial subset of geographic data."""

    alias METADATA = "metadata"
    """Information applies to metadata."""

    alias INITIATIVE = "initiative"
    """Information applies to an intitiative."""

    alias SAMPLE = "sample"
    """Information applies to a sample."""

    alias DOCUMENT = "document"
    """Information applies to a document."""

    alias REPOSITORY = "repository"
    """Information applies to a repository."""

    alias AGGREGATE = "aggregate"
    """Information applies to an aggregate resource."""

    alias PRODUCT = "product"
    """Metadata describing an ISO 19131 data product specification."""

    alias COLLECTION = "collection"
    """Information applies to an unstructured set."""

    alias COVERAGE = "coverage"
    """Information applies to a coverage."""

    alias APPLICATION = "application"
    """Information resource hosted on a specific set of hardware and accessible
    over a network.
    """


trait ScopeDescription:
    """Description of the trait of information covered by the information."""

    fn attributes(self) -> Optional[Set[String]]:
        """Instances of attribute types to which the information applies.

        MANDATORY:
            If `features`, `feature_instances`, `attribute_instances`,
            `dataset`, and `other` are `None`.
        """
        ...

    fn features(self) -> Optional[Set[String]]:
        """Instances of feature types to which the information applies.

        MANDATORY:
            If `attributes`, `feature_instances`, `attribute_instances`,
            `dataset`, and `other` are `None`.
        """
        ...

    fn feature_instances(self) -> Optional[Set[String]]:
        """Feature instances to which the information applies.

        MANDATORY:
            If `attributes`, `features`, `attribute_instances`,
            `dataset`, and `other` are `None`.
        """
        ...

    fn attribute_instances(self) -> Optional[Set[String]]:
        """Attribute instances to which the information applies.

        MANDATORY:
            If `attributes`, `features`, `feature_instances`,
            `dataset`, and `other` are `None`.
        """
        ...

    fn dataset(self) -> Optional[String]:
        """Dataset to which the information applies.

        MANDATORY:
            If `attributes`, `features`, `feature_instances`,
            `attribute_instances`, and `other` are `None`.
        """
        ...

    fn other(self) -> Optional[String]:
        """trait of information that does not fall into the other categories to
        which the information applies.

        MANDATORY:
            If `attributes`, `features`, `feature_instances`,
            `attribute_instances`, and `dataset` are `None`.
        """
        ...


trait Scope:
    """The target resource and physical extent for which information is reported.
    Information about the scope of the resource."""

    fn level(self) -> ScopeCode:
        """Description of the scope."""
        ...

    fn extent(self) -> Optional[Tuple[Extent]]:
        """Information about the horizontal, vertical, and temporal extent of
        the specified resource.
        """
        ...

    fn level_description(self) -> Optional[Tuple[ScopeDescription]]:
        """Detailed information/listing of the items specified by the level."""
        ...


trait MaintenanceInformation:
    """Information about the scope and frequency of updating."""

    fn maintenance_and_update_frequency(
        self,
    ) -> Optional[MaintenanceFrequencyCode]:
        """Frequency with which changes and additions are made to the resource
        after the initial resource is completed.

        MANDATORY:
            If `user_defined_maintenance_frequency` is `None`.
        """
        ...

    fn maintenance_date(self) -> Optional[Tuple[Date]]:
        """Date information associated with maintenance of resource."""
        ...

    fn user_defined_maintenance_frequency(self) -> Optional[timedelta]:
        """Maintenance period other than those defined.

        MANDATORY:
            If `user_defined_maintenance_frequency` is `None`.
        """
        ...

    fn maintenance_scope(self) -> Optional[Tuple[Scope]]:
        """Information about the scope and extent of maintenance."""
        ...

    fn maintenance_note(self) -> Optional[Tuple[String]]:
        """Information regarding specific requirements for maintaining the
        resource.
        """
        ...

    fn contact(self) -> Optional[Tuple[Responsibility]]:
        """Identification of, and means of communicating with, person(s) and
        organisation(s) with responsibility for maintaining the metadata.
        """
        ...
