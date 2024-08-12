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
"""This is the maintenance module.

This module contains geographic metadata structures regarding data maintenance
derived from the ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from abc import ABC, abstractmethod
from collections.abc import Sequence
from datetime import timedelta
from enum import Enum
from typing import Optional

from opengis.metadata.citation import Date, Responsibility
from opengis.metadata.extent import Extent


class MaintenanceFrequencyCode(Enum):
    """
    Frequency with which modifications and deletions are made to the data
    after it is first produced
    """

    CONTINUAL = "continual"
    DAILY = "daily"
    WEEKLY = "weekly"
    FORTNIGHTLY = "fortnightly"
    MONTHLY = "monthly"
    QUARTERLY = "quarterly"
    BIANNUALLY = "biannually"
    ANNUALLY = "annually"
    AS_NEEDED = "asNeeded"
    IRREGULAR = "irregular"
    NOT_PLANNED = "notPlanned"
    UNKNOWN = "unknown"
    PERIODIC = "periodic"
    SEMIMONTHLY = "semimonthly"
    BIENNIALLY = "biennially"


class ScopeCode(Enum):
    """Class of information to which the referencing entity applies."""

    COLLECTION_HARDWARE = "collectionHardware"
    COLLECTION_SESSION = "collectionSession"
    SERIES = "series"
    DATASET = "dataset"
    NON_GEOGRAPHIC_DATASET = "nonGeographicDataset"
    DIMENSION_GROUP = "dimensionGroup"
    FEATURE_TYPE = "featureType"
    FEATURE = "feature"
    ATTRIBUTE_TYPE = "attributeType"
    ATTRIBUTE = "attribute"
    PROPERTY_TYPE = "propertyType"
    FIELD_SESSION = "fieldSession"
    SOFTWARE = "software"
    SERVICE = "service"
    MODEL = "model"
    TILE = "tile"
    METADATA = "metadata"
    INITIATIVE = "initiative"
    SAMPLE = "sample"
    DOCUMENT = "document"
    REPOSITORY = "repository"
    AGGREGATE = "aggregate"
    PRODUCT = "product"
    COLLECTION = "collection"
    COVERAGE = "coverage"
    APPLICATION = "application"


class ScopeDescription(ABC):
    """Description of the class of information covered by the information."""

    @property
    @abstractmethod
    def attributes(self) -> Optional[Sequence[str]]:
        """
        Instances of attribute types to which the information applies.

        MANDATORY: if `features`, `feature_instances`, `attribute_instances`,
            `dataset`, and `other` are `None`.
        """

    @property
    @abstractmethod
    def features(self) -> Optional[Sequence[str]]:
        """
        Instances of feature types to which the information applies.

        MANDATORY: if `attributes`, `feature_instances`, `attribute_instances`,
            `dataset`, and `other` are `None`.
        """

    @property
    @abstractmethod
    def feature_instances(self) -> Optional[Sequence[str]]:
        """
        Feature instances to which the information applies.

        MANDATORY: if `attributes`, `features`, `attribute_instances`,
            `dataset`, and `other` are `None`.
        """

    @property
    @abstractmethod
    def attribute_instances(self) -> Optional[Sequence[str]]:
        """
        Attribute instances to which the information applies.

        MANDATORY: if `attributes`, `features`, `feature_instances`,
            `dataset`, and `other` are `None`.
        """

    @property
    @abstractmethod
    def dataset(self) -> Optional[str]:
        """
        Dataset to which the information applies.

        MANDATORY: if `attributes`, `features`, `feature_instances`,
            `attribute_instances`, and `other` are `None`.
        """

    @property
    @abstractmethod
    def other(self) -> Optional[str]:
        """
        Class of information that does not fall into the other categories to
        which the information applies.

        MANDATORY: if `attributes`, `features`, `feature_instances`,
            `attribute_instances`, and `dataset` are `None`.
        """


class Scope(ABC):
    """
    The target resource and physical extent for which information is reported.
    Information about the scope of the resource.
    """

    @property
    @abstractmethod
    def level(self) -> ScopeCode:
        """Description of the scope."""

    @property
    @abstractmethod
    def extent(self) -> Optional[Sequence[Extent]]:
        """
        Information about the horizontal, vertical, and temporal extent of
        the specified resource.
        """

    @property
    @abstractmethod
    def level_description(self) -> Optional[Sequence[ScopeDescription]]:
        """
        Detailed information/listing of the items specified by the level.
        """


class MaintenanceInformation(ABC):
    """Information about the scope and frequency of updating."""

    @property
    @abstractmethod
    def maintenance_and_update_frequency(self) -> Optional[
        MaintenanceFrequencyCode
    ]:
        """
        Frequency with which changes and additions are made to the resource
        after the initial resource is completed.

        MANDATORY: if `user_defined_maintenance_frequency` is `None`.
        """

    @property
    @abstractmethod
    def maintenance_date(self) -> Optional[Sequence[Date]]:
        """Date information associated with maintenance of resource."""

    @property
    @abstractmethod
    def user_defined_maintenance_frequency(self) -> Optional[timedelta]:
        """
        Maintenance period other than those defined.

        MANDATORY: if `user_defined_maintenance_frequency` is `None`.
        """

    @property
    @abstractmethod
    def maintenance_scope(self) -> Optional[Sequence[Scope]]:
        """Information about the scope and extent of maintenance."""

    @property
    @abstractmethod
    def maintenance_note(self) -> Optional[Sequence[str]]:
        """
        Information regarding specific requirements for maintaining the
        resource.
        """

    @property
    @abstractmethod
    def contact(self) -> Optional[Sequence[Responsibility]]:
        """
        Identification of, and means of communicating with, person(s) and
        organisation(s) with responsibility for maintaining the metadata.
        """
