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

from dataclasses import dataclass
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


class ParameterDirection(Enum):
    """Class of information to which the referencing entity applies."""

    IN = "in"
    OUT = "out"
    IN_OUT = "in/out"


@dataclass(frozen=True, slots=True)
class OperationMetadata:
    """Describes the signature of one and only one method provided by the
    service.

    Attributes:
        operation_name (str): A unique identifier for this interface.
        distributed_computing_platform (tuple[DCPList, ...]): Distributed
            computing platforms on which the operation has been implemented.
        operation_description (str): Free text description of the intent of
            the operation and the results of the operation.
        invocation_name (str): The name used to invoke this interface within
            the context of the DCP. The name is identical for all DCPs.
        connect_point (tuple[OnlineResource, ...]): Handle for accessing the
            service interface.
        parameter (...): The parameters that are required for this interface.
        depends_on (tuple[OperationMetadata, ...]): List of operation that
            must be completed immediately before current operation is invoked.

    """

    operation_name: str
    distributed_computing_platform: tuple[DCPList, ...]
    operation_description: str
    invocation_name: str
    connect_point: tuple[OnlineResource, ...]
    parameter: ...
    depends_on: tuple["OperationMetadata", ...]


@dataclass(frozen=True, slots=True)
class OperationChainMetadata:
    """Operation Chain Information.

    Attributes:
        name (str): The name, as used by the service for this chain.
        description (str): A narrative explanation of the services in the
            chain and resulting output.
        operation (tuple[OperationMetadata, ...]): 

    """

    name: str
    description: str
    operation: tuple[OperationMetadata, ...]


@dataclass(frozen=True, slots=True)
class CoupledResource:
    """Links a given operationName (mandatory attribute of
    SV_OperationMetadata) with a data set identified by an "identifier".

    Attributes:
        scoped_name (ScopedName): Scoped identifier of the resource in the
            context of the given service instance. NOTE: name of the resources
            (i.e. dataset) as it is used by a service instance (e.g. layer
            name or featureTypeName).
        resource_reference (tuple[Citation, ...]): Reference to the dataset on
            which the service operates.
        operation (OperationMetadata): 
        resource (tuple[DataIdentification, ...]): 

    """

    scoped_name: ScopedName
    resource_reference: tuple[Citation, ...]
    operation: OperationMetadata
    resource: tuple[DataIdentification, ...]


@dataclass(frozen=True, slots=True)
class ServiceIdentification(Identification):
    """Identification of capabilities which a service provider makes available
    to a service user through a set of interfaces that define a behaviour -
    See ISO 19119 for further information.

    Attributes:
        service_type (GenericName): A service type name, e.g., "discovery",
            "view", "download", "transformation", or "invoke".
        service_type_version (tuple[str, ...]): Provide for searching based on
            the version of serviceType. For example, we may only be interested
            in OGC Catalogue V1.1 services. If version is maintained as a
            separate attribute, users can easily search for all services of a
            type regardless of the version.
        access_properties (StandardOrderProcess): Information about the
            availability of the service, including, "fees", "planned",
            "available date and time", "ordering instructions", and
            "turnaround".
        coupling_type (CouplingType): Type of coupling between service and
            associated data (if exists).
        coupled_resource (tuple[CoupledResource, ...]): Further description of
            the data coupling in the case of tightly coupled services.
        operated_dataset (tuple[Citation, ...]): Provides a reference to the
            dataset on which the service operates.
        profile (tuple[Citation, ...]): 
        service_standard (tuple[Citation, ...]): 
        contains_operations (tuple[OperationMetadata, ...]): 
        operates_on (tuple[DataIdentification, ...]): 
        contains_chain (tuple[OperationChainMetadata, ...]): 

    """

    service_type: GenericName
    service_type_version: tuple[str, ...]
    access_properties: StandardOrderProcess
    coupling_type: CouplingType
    coupled_resource: tuple[CoupledResource, ...]
    operated_dataset: tuple[Citation, ...]
    profile: tuple[Citation, ...]
    service_standard: tuple[Citation, ...]
    contains_operations: tuple[OperationMetadata, ...]
    operates_on: tuple[DataIdentification, ...]
    contains_chain: tuple[OperationChainMetadata, ...]
