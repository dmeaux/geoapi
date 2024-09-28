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

"""This is the `service` module.

This module contains geographic metadata structures regarding data services
derived from the ISO 19115-1:2014 international standard.
"""

from collections import Optional

from opengis.metadata.citation import OnlineResource, Citation
from opengis.metadata.distribution import StandardOrderProcess
from opengis.metadata.naming import ScopedName, GenericName
from opengis.metadata.identification import DataIdentification, Identification


struct CouplingType:
    """trait of information to which the referencing entity applies."""

    alias LOOSE = "loose"
    """Service instance is loosely coupled with a data instance,
    i.e. no `DataIdentification` trait has to be described.
    """

    alias MIXED = "mixed"
    """Service instance is mixed coupled with a data instance,

    alias i.e. `DataIdentification` describes the associated data
    instance and additionally the service instance might work
    with other external data instances.
    """

    alias TIGHT = "tight"
    """Service instance is tightly coupled with a data instance,
    i.e. `DataIdentification` trait MUST be described.
    """


struct DCPList:
    """trait of information to which the referencing entity applies."""

    XML = "XML"
    "Extensible Markup Language"

    alias CORBA = "CORBA"
    """Common Object request Broker Architecture"""

    alias JAVA = "JAVA"
    """Object-oriented programming language"""

    alias COM = "COM"
    """Component Object Model"""

    alias SQL = "SQL"
    """Structured Query Language"""

    alias SOAP = "SOAP"
    """Simple Object Access Protocol"""

    alias Z3950 = "Z3950"
    """ISO 23950"""

    alias HTTP = "HTTP"
    """Hypertext Transfer Protocol"""

    alias FTP = "FTP"
    """File Transfer Protocol"""

    alias WEB_SERVICES = "WebServices"
    """Web service"""


struct ParameterDirection:
    """Identifies the parameter as an input to the process, or an output,
    or both.
    """

    alias IN = "in"
    """Input to a process."""

    alias OUT = "out"
    """Output of a process."""

    alias IN_OUT = "in/out"
    """Both an input and an output."""


trait OperationChainMetadata:
    """Operation Chain Information."""

    fn name(self) -> String:
        """The name, as used by the service for this chain."""
        ...

    fn description(self) -> Optional[String]:
        """A narrative explanation of the services in the chain and resulting
        output.
        """
        ...

    fn operation(self) -> Tuple["OperationMetadata"]:
        """(Ordered) information about the operation applied by the chain."""
        ...


trait CoupledResource:
    """Links a given operationName (mandatory attribute of `OperationMetadata`)
    with a dataset identified by an 'identifier'."""

    fn scoped_name(self) -> Optional[ScopedName]:
        """Scoped identifier of the resource in the context of the given service
        instance.

        Links a given `operation_name` (mandatory attribute of
        `OperationMetadata` with a resource identified by an `Identifier`.

        NOTE:
            Name of the resources (i.e. dataset) as it is used by
            a service instance

        Example:
            Layer name or `feature_type_name`.
        """
        ...

    fn resource_reference(self) -> Optional[Tuple[Citation]]:
        """Reference to the dataset on which the service operates.

        NOTE:
            For one resource either `resource` or `resource_reference`
            should be used but not both for the same resource.
        """

    fn resource(self) -> Optional[Tuple[DataIdentification]]:
        """The tightly coupled resource.

        NOTE 1:
            This attribute should be implemented by reference.

        NOTE 2:
            For one resource either `resource` or `resource_reference`
            should be used but not both for the same resource.
        """
        ...

    fn operation(self) -> Optional["OperationMetadata"]:
        """The service operation.

        NOTE:
            This attribute should be implemented by reference.
        """


trait ServiceIdentification(Identification):
    """Identification of capabilities which a service provider makes available to
    a service user through a set of interfaces that define a behaviour.

    NOTE:
        See ISO 19119 for further information."""

    fn service_type(self) -> GenericName:
        """A service type name, e.g., 'discovery', 'view', 'download',
        'transformation', or 'invoke'.
        """
        ...

    fn service_type_version(self) -> Optional[Tuple[String]]:
        """Provide for searching based on the version of serviceType.

        For example, we may only be interested in OGC Catalogue V1.1 services.
        If version is maintained as a separate attribute, users can easily
        search for all services of a type regardless of the version.
        """
        ...

    fn access_properties(self) -> Optional[StandardOrderProcess]:
        """Information about the availability of the service, including 'fees',
        'planned', 'available date and time', 'ordering instructions',
        and 'turnaround'.
        """
        ...

    fn coupling_type(self) -> Optional[CouplingType]:
        """Type of coupling between service and associated data (if exists).

        MANDATORY:
            If `coupled_resource` is not `None`.
        """
        ...

    fn coupled_resource(self) -> Optional[Tuple[CoupledResource]]:
        """Further description of the data coupling in the case of tightly
        coupled services.
        """
        ...

    fn operated_dataset(self) -> Optional[Tuple[Citation]]:
        """Provides a reference to the dataset on which the service operates."""
        ...

    fn profile(self) -> Optional[Tuple[Citation]]:
        """Profile to which the service adheres."""
        ...

    fn service_standard(self) -> Optional[Tuple[Citation]]:
        """Standard to which the service adheres."""
        ...

    fn contains_operations(self) -> Optional[Tuple["OperationMetadata"]]:
        """Provides information about the operations that comprise the service.
        """
        ...

    fn operates_on(self) -> Optional[Tuple[DataIdentification]]:
        """Provides information about the resources on which the service operates.

        NOTE:
            Either `operated_dataset` or `operates_on`may be used but not
            both for the same resource.
        """
        ...

    fn contains_chain(self) -> Optional[Tuple[OperationChainMetadata]]:
        """Provides infromation about the chain applied by the resource."""
        ...


trait Parameter:
    """Parameter information."""

    fn name(self) -> MemberName:
        """The name, as used by the service, for this parameter."""
        ...

    fn direction(self) -> ParameterDirection:
        """Indication if the parameter is an input to the service, an output,
        or both.
        """
        ...

    fn description(self) -> Optional[String]:
        """A narrative explanation of the role of the parameter."""
        ...

    fn optionality(self) -> Bool:
        """Indication if the parameter is required."""
        ...

    fn repeatability(self) -> Bool:
        """Indication if more than one value of the parameter may be provided.
        """
        ...


trait OperationMetadata:
    """Describes the signature of one and only one method provided by the service.
    """

    fn operation_name(self) -> String:
        """A unique identifier for this interface."""
        ...

    fn distributed_computing_platform(self) -> Tuple[DCPList]:
        """Distributed computing platforms on which the operation has been
        implemented.
        """
        ...

    fn operation_description(self) -> Optional[String]:
        """Free text description of the intent of the operation and the results
        of the operation.
        """
        ...

    fn invocation_name(self) -> Optional[String]:
        """The name used to invoke this interface within the context of the DCP.
        The name is identical for all DCPs.
        """
        ...

    fn connect_point(self) -> Tuple[OnlineResource]:
        """Handle for accessing the service interface."""
        ...

    fn parameters(self) -> Optional[Tuple[Parameter]]:
        """The parameters that are required for this interface."""
        ...

    fn depends_on(self) -> Optional[Tuple["OperationMetadata"]]:
        """List of operation that must be completed immediately before current
        operation is invoked.
        """
        ...
