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
"""This is the service module.

This module contains geographic metadata structures regarding data services
derived from the ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from abc import ABC, abstractmethod
from collections.abc import Sequence
from enum import Enum

from opengis.metadata.citation import Citation, OnlineResource
from opengis.metadata.distribution import StandardOrderProcess
from opengis.metadata.identification import DataIdentification, Identification
from opengis.metadata.naming import GenericName, ScopedName


class CouplingType(Enum):
    """Class of information to which the referencing entity applies."""

    LOOSE = "loose"
    MIXED = "mixed"
    TIGHT = "tight"


class DCPList(Enum):
    """Class of information to which the referencing entity applies."""
    XML = "XML"
    CORBA = "CORBA"
    JAVA = "JAVA"
    COM = "COM"
    SQL = "SQL"
    SOAP = "SOAP"
    Z3950 = "Z3950"
    HTTP = "HTTP"
    FTP = "FTP"
    WEB_SERVICES = "WebServices"


class OperationMetadata(ABC):
    """
    Describes the signature of one and only one method provided by the service.
    """

    @property
    @abstractmethod
    def operation_name(self) -> str:
        """A unique identifier for this interface."""

    @property
    @abstractmethod
    def distributed_computing_platform(self) -> Sequence[DCPList]:
        """
        Distributed computing platforms on which the operation has been
        implemented.
        """

    @property
    @abstractmethod
    def operation_description(self) -> str:
        """
        Free text description of the intent of the operation and the results
        of the operation.
        """

    @property
    @abstractmethod
    def invocation_name(self) -> str:
        """
        The name used to invoke this interface within the context of the DCP.
        The name is identical for all DCPs.
        """

    @property
    @abstractmethod
    def connect_point(self) -> Sequence[OnlineResource]:
        """Handle for accessing the service interface."""

    @property
    @abstractmethod
    def parameter(self):
        """The parameters that are required for this interface."""

    @property
    @abstractmethod
    def depends_on(self) -> Sequence['OperationMetadata']:
        """
        List of operation that must be completed immediately before current
        operation is invoked.
        """


class OperationChainMetadata(ABC):
    """Operation Chain Information."""

    @property
    @abstractmethod
    def name(self) -> str:
        """The name, as used by the service for this chain."""

    @property
    @abstractmethod
    def description(self) -> str:
        """
        A narrative explanation of the services in the chain and resulting
        output.
        """

    @property
    @abstractmethod
    def operation(self) -> Sequence[OperationMetadata]:
        """"""


class CoupledResource(ABC):
    """
    Links a given operationName (mandatory attribute of SV_OperationMetadata)
    with a data set identified by an 'identifier'.
    """

    @property
    @abstractmethod
    def scoped_name(self) -> ScopedName:
        """
        Scoped identifier of the resource in the context of the given service
        instance. NOTE: name of the resources (i.e. dataset) as it is used by
        a service instance (e.g. layer name or featureTypeName).
        """

    @property
    @abstractmethod
    def resource_reference(self) -> Sequence[Citation]:
        """Reference to the dataset on which the service operates."""

    @property
    @abstractmethod
    def operation(self) -> OperationMetadata:
        """"""

    @property
    @abstractmethod
    def resource(self) -> Sequence[DataIdentification]:
        """"""


class ServiceIdentification(Identification):
    """
    Identification of capabilities which a service provider makes available to
    a service user through a set of interfaces that define a behaviour -
    See ISO 19119 for further information.
    """

    @property
    @abstractmethod
    def service_type(self) -> GenericName:
        """
        A service type name, e.g., 'discovery', 'view', 'download',
        'transformation', or 'invoke'.
        """

    @property
    @abstractmethod
    def service_type_version(self) -> Sequence[str]:
        """
        Provide for searching based on the version of serviceType.
        For example, we may only be interested in OGC Catalogue V1.1 services.
        If version is maintained as a separate attribute, users can easily
        search for all services of a type regardless of the version.
        """

    @property
    @abstractmethod
    def access_properties(self) -> StandardOrderProcess:
        """
        Information about the availability of the service, including 'fees',
        'planned', 'available date and time', 'ordering instructions',
        and 'turnaround'.
        """

    @property
    @abstractmethod
    def coupling_type(self) -> CouplingType:
        """Type of coupling between service and associated data (if exists)."""

    @property
    @abstractmethod
    def coupled_resource(self) -> Sequence[CoupledResource]:
        """
        Further description of the data coupling in the case of tightly
        coupled services.
        """

    @property
    @abstractmethod
    def operated_dataset(self) -> Sequence[Citation]:
        """
        Provides a reference to the dataset on which the service operates.
        """

    @property
    @abstractmethod
    def profile(self) -> Sequence[Citation]:
        """"""

    @property
    @abstractmethod
    def service_standard(self) -> Sequence[Citation]:
        """"""

    @property
    @abstractmethod
    def contains_operations(self) -> Sequence[OperationMetadata]:
        """"""

    @property
    @abstractmethod
    def operates_on(self) -> Sequence[DataIdentification]:
        """"""

    @property
    @abstractmethod
    def contains_chain(self) -> Sequence[OperationChainMetadata]:
        """"""
