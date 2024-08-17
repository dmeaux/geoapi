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

"""This is the service module.

This module contains geographic metadata structures regarding data services
derived from the ISO 19115-1:2014 international standard.
"""

from opengis.metadata.citation import OnlineResource, Citation
from opengis.metadata.distribution import StandardOrderProcess
from opengis.metadata.naming import ScopedName, GenericName
from opengis.metadata.identification import DataIdentification, Identification


struct CouplingType:
    alias LOOSE = "loose"
    alias MIXED = "mixed"
    alias TIGHT = "tight"


struct DCPList:
    alias XML = "XML"
    alias CORBA = "CORBA"
    alias JAVA = "JAVA"
    alias COM = "COM"
    alias SQL = "SQL"
    alias SOAP = "SOAP"
    alias Z3950 = "Z3950"
    alias HTTP = "HTTP"
    alias FTP = "FTP"
    alias WEB_SERVICES = "WebServices"


struct ParameterDirection:
    alias IN = "in"
    alias OUT = "out"
    alias IN_OUT = "in/out"


trait OperationMetadata:
    """Describes the signature of one and only one method provided by the service.
    """

    fn operation_name(self) -> String:
        """A unique identifier for this interface."""
        ...

    fn distributed_computing_platform(self) -> Sequence[DCPList]:
        """Distributed computing platforms on which the operation has been implemented.
        """
        ...

    fn operation_description(self) -> String:
        """Free text description of the intent of the operation and the results of the operation.
        """
        ...

    fn invocation_name(self) -> String:
        """The name used to invoke this interface within the context of the DCP. The name is identical for all DCPs.
        """
        ...

    fn connect_point(self) -> Sequence[OnlineResource]:
        """Handle for accessing the service interface."""
        ...

    fn parameter(self):
        """The parameters that are required for this interface."""
        ...

    fn depends_on(self) -> Sequence[OperationMetadata]:
        """List of operation that must be completed immediately before current operation is invoked.
        """
        ...


trait OperationChainMetadata:
    """Operation Chain Information."""

    fn name(self) -> String:
        """The name, as used by the service for this chain."""
        ...

    fn description(self) -> String:
        """A narrative explanation of the services in the chain and resulting output.
        """
        ...

    fn operation(self) -> Sequence[OperationMetadata]:
        ...


trait CoupledResource:
    """Links a given operationName (mandatory attribute of SV_OperationMetadata) with a data set identified by an 'identifier'.
    """

    fn scoped_name(self) -> ScopedName:
        """Scoped identifier of the resource in the context of the given service instance. NOTE: name of the resources (i.e. dataset) as it is used by a service instance (e.g. layer name or featureTypeName).
        """
        ...

    fn resource_reference(self) -> Sequence[Citation]:
        """Reference to the dataset on which the service operates."""
        ...

    fn operation(self) -> OperationMetadata:
        ...

    fn resource(self) -> Sequence[DataIdentification]:
        ...


trait ServiceIdentification(Identification):
    """Identification of capabilities which a service provider makes available to a service user through a set of interfaces that define a behaviour - See ISO 19119 for further information.
    """

    fn service_type(self) -> GenericName:
        """A service type name, E.G. 'discovery', 'view', 'download', 'transformation', or 'invoke'.
        """
        ...

    fn service_type_version(self) -> Sequence[String]:
        """Provide for searching based on the version of serviceType. For example, we may only be interested in OGC Catalogue V1.1 services. If version is maintained as a separate attribute, users can easily search for all services of a type regardless of the version.
        """
        ...

    fn access_properties(self) -> StandardOrderProcess:
        """Information about the availability of the service, including, 'fees' 'planned' 'available date and time' 'ordering instructions' 'turnaround'.
        """
        ...

    fn coupling_type(self) -> CouplingType:
        """Type of coupling between service and associated data (if exists)."""
        ...

    fn coupled_resource(self) -> Sequence[CoupledResource]:
        """Further description of the data coupling in the case of tightly coupled services.
        """
        ...

    fn operated_dataset(self) -> Sequence[Citation]:
        """Provides a reference to the dataset on which the service operates."""
        ...

    fn profile(self) -> Sequence[Citation]:
        ...

    fn service_standard(self) -> Sequence[Citation]:
        ...

    fn contains_operations(self) -> Sequence[OperationMetadata]:
        ...

    fn operates_on(self) -> Sequence[DataIdentification]:
        ...

    fn contains_chain(self) -> Sequence[OperationChainMetadata]:
        ...
