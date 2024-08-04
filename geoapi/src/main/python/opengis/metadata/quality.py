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
"""This is the quality module.


This module contains geographic metadata structures derived from the
ISO 19115-1:2014 international standard and data quality structures derived
from the ISO 19157:2013 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

from dataclasses import dataclass
from datetime import datetime
from enum import Enum
from typing import Any

from opengis.metadata.citation import Citation, Identifier
from opengis.metadata.content import CoverageDescription
from opengis.metadata.distribution import DataFile, Format
from opengis.metadata.identification import BrowseGraphic
from opengis.metadata.maintenance import Scope
from opengis.metadata.naming import Record, RecordType, TypeName
from opengis.metadata.representation import (
    SpatialRepresentationTypeCode, SpatialRepresentation
)
# from opengis.util import TypeName


class EvaluationMethodTypeCode(Enum):
    """Type of method for evaluating an identified data quality measure."""

    DIRECT_INTERNAL = "directInternal"
    DIRECT_EXTERNAL = "directExternal"
    INDIRECT = "indirect"


class ValueStructure(Enum):
    """The way in which values are grouped together."""

    BAG = "BAG"
    SET = "SET"
    SEQUENCE = "SEQUENCE"
    TABLE = "TABLE"
    MATRIX = "MATRIX"
    COVERAGE = "COVERAGE"


@dataclass(frozen=True, slots=True)
class StandaloneQualityReportInformation:
    """Reference to an external stadalone quality report

    Attributes:
        report_reference (Citation): Reference to the associated standalone1
            quality report.
        abstract (str): Abstract for the associated standalone quality report.

    """

    report_reference: Citation
    abstract: str


@dataclass(frozen=True, slots=True)
class Result:
    """Generalization of more specific result classes.

    Attributes:
        result_scope (Scope): Scope of the result.
        date_time (datetime): Date when the result was generated.

    """

    result_scope: Scope
    date_time: datetime


@dataclass(frozen=True, slots=True)
class EvaluationMethod:
    """Description of the evaluation method and procedure applied.

    Attributes:
        evaluation_method_type (EvaluationMethodTypeCode): Type of method used
            to evaluate quality of the data.
        evaluation_method_description (str): Description of the evaluation
            method.
        evaluation_procedure (Citation): Reference to the procedure
            information.
        reference_doc (tuple[Citation, ...]): Information on documents which
            are referenced in developing and applying a data quality
            evaluation method.
        date_time (tuple[datetime, ...]): Date or range of dates on which a
            data quality measure was applied.

    """

    evaluation_method_type: EvaluationMethodTypeCode
    evaluation_method_description: str
    evaluation_procedure: Citation
    reference_doc: tuple[Citation, ...]
    date_time: tuple[datetime, ...]


@dataclass(frozen=True, slots=True)
class MeasureReference:
    """Reference to the measure used.

    Attributes:
        measure_identification (Identifier): Identifier of the measure, value
            uniquely identifying the measure within a namespace.
        name_of_measure (tuple[str, ...]): Name of the test applied to the
            data.
        measure_description (str): Description of the measure.

    """

    measure_identification: Identifier
    name_of_measure: tuple[str, ...]
    measure_description: str


@dataclass(frozen=True, slots=True)
class Element:
    """Aspect of quantitative quality information.

    Attributes:
        standalone_quality_report_details (str): 
        meausure (MeasureReference): 
        evaluation_method (EvaluationMethod): 
        result (tuple[Result, ...]): 
        derived_element (tuple['Element', ...]): 
    """

    standalone_quality_report_details: str
    meausure: MeasureReference
    evaluation_method: EvaluationMethod
    result: tuple[Result, ...]
    derived_element: tuple['Element', ...]


@dataclass(frozen=True, slots=True)
class DataQuality:
    """Quality information for the data specified by a data quality scope.

    Attributes:
        scope (Scope): 
        report (tuple[Element, ...]): 
        standalone_quality_report (StandaloneQualityReportInformation):
    """

    scope: Scope
    report: tuple[Element, ...]
    standalone_quality_report: StandaloneQualityReportInformation


@dataclass(frozen=True, slots=True)
class Description:
    """Data quality measure description.

    Attributes:
        text_description (str): Text description.
        extended_Description (BrowseGraphic): Illustration.
    """

    text_description: str
    extended_Description: BrowseGraphic


@dataclass(frozen=True, slots=True)
class SourceReference:
    """Reference to the source of the data quality measure.

    Attributes:
        citation (Citation): Reference to the source.
    """

    citation: Citation


@dataclass(frozen=True, slots=True)
class BasicMeasure:
    """Data quality basic measure.

    Attributes:
        name (str): Name of the data quality basic measure applied to the data.
        definition (str): Definition of the data quality basic measure.
        example (Description): Illustration of the use of a data quality
            measure.
        value_type (TypeName): Value type for the result of the basic measure
            (shall be one of the data types defined in ISO/TS 19103:2005).
    """

    name: str
    definition: str
    example: Description
    value_type: TypeName


@dataclass(frozen=True, slots=True)
class Measure:
    """Data quality measure.

    Attributes:
        measure_identifier (Identifier): Value uniquely identifying the
            measure within a namespace.
        name (str): Name of the data quality measure applied to the data.
        alias (str): Another recognized name, an abbreviation or a short name
            for the same data quality measure.
        element_name (TypeName): Name of the data quality element for which
            quality is reported.
        definition (str): Definition of the fundamental concept for the data
            quality measure.
        description (Description): Description of the data quality measure,
            including all formulae and/or illustrations needed to establish
            the result of applying the measure.
        value_type (TypeName): 
        value_structure (ValueStructure): 
        example (tuple[Description, ...]): 
        basic_measure (BasicMeasure): 
        source_reference (tuple[SourceReference, ...]): 
        parameter (Any): 

    """

    measure_identifier: Identifier
    name: str
    alias: str
    element_name: TypeName
    definition: str
    description: Description
    value_type: TypeName
    value_structure: ValueStructure
    example: tuple[Description, ...]
    basic_measure: BasicMeasure
    source_reference: tuple[SourceReference, ...]
    parameter: Any


@dataclass(frozen=True, slots=True)
class TemporalQuality(Element):
    """
    Accuracy of the temporal attributes and temporal relationships of features.
    """


@dataclass(frozen=True, slots=True)
class Metaquality(Element):
    """Information about the reliability of data quality results.

    Attributes:
        derived_element (tuple[Element, ...]): Derived element.

    """

    derived_element: tuple[Element, ...]


@dataclass(frozen=True, slots=True)
class Confidence(Metaquality):
    """Trustworthiness of a data quality result."""


@dataclass(frozen=True, slots=True)
class Representativity(Metaquality):
    """Trustworthiness of a data quality result."""


@dataclass(frozen=True, slots=True)
class DataEvaluation(EvaluationMethod):
    """Data evaluation method."""


@dataclass(frozen=True, slots=True)
class SimpleBasedInspection(DataEvaluation):
    """Sample based inspection.

    Attributes:
        sampling_scheme (str): Information of the type of sampling scheme and
            description of the sampling procedure.
        lot_description (str): Information of how lots are defined.
        simple_ratio (str): Information on how many samples on average are
            extracted for inspection from each lot of population.

    """

    sampling_scheme: str
    lot_description: str
    simple_ratio: str


@dataclass(frozen=True, slots=True)
class IndirectEvaluation(DataEvaluation):
    """Indirect evaluation.

    Attributes:
        deductive_source (str): Information on which data are used as sources
            in deductive evaluation method.

    """

    deductive_source: str


@dataclass(frozen=True, slots=True)
class Homogeneity(Metaquality):
    """
    Expected or tested uniformity of the results obtained for a data quality
    evaluation.
    """


@dataclass(frozen=True, slots=True)
class FullInspection(DataEvaluation):
    """
    Test of every item in the population specified by the data quality scope.
    """


@dataclass(frozen=True, slots=True)
class DescriptiveResult(Result):
    """Data quality descriptive result.

    Attributes:
        statement (str): Textual expression of the descriptive result.
    """

    statement: str


@dataclass(frozen=True, slots=True)
class AggregationDerivation(EvaluationMethod):
    """Aggregation or derivation method."""


@dataclass(frozen=True, slots=True)
class PositionalAccuracy(Element):
    """Accuracy of the position of features."""


@dataclass(frozen=True, slots=True)
class AbsoluteExternalPositionalAccuracy(PositionalAccuracy):
    """
    Closeness of reported coordinate values to values accepted as or being
    true.
    """


@dataclass(frozen=True, slots=True)
class GriddedDataPositionalAccuracy(PositionalAccuracy):
    """
    Closeness of gridded data position values to values accepted as or being
    true.
    """


@dataclass(frozen=True, slots=True)
class RelativeInternalPositionalAccuracy(PositionalAccuracy):
    """
    Closeness of the relative positions of features in the scope to their
    respective relative positions accepted as or being true.
    """


@dataclass(frozen=True, slots=True)
class TemporalConsistency(TemporalQuality):
    """Correctness of ordered events or tuples, if reported."""


@dataclass(frozen=True, slots=True)
class TemporalValidity(TemporalQuality):
    """Validity of data specified by the scope with respect to time."""


@dataclass(frozen=True, slots=True)
class AccuracyOfATimeMeasurement(TemporalQuality):
    """
    Correctness of the temporal references of an item (reporting of error in
    time measurement).
    """


@dataclass(frozen=True, slots=True)
class ThematicAccuracy(Element):
    """
    Accuracy of quantitative attributes and the correctness of
    non-quantitative attributes and of the classifications of features and
    their relationships.
    """


@dataclass(frozen=True, slots=True)
class ThematicClassificationCorrectness(ThematicAccuracy):
    """
    Comparison of the classes assigned to features or their attributes to a
    universe of discourse.
    """


@dataclass(frozen=True, slots=True)
class QuantitativeAttributeAccuracy(ThematicAccuracy):
    """Accuracy of quantitative attributes."""


@dataclass(frozen=True, slots=True)
class NonQuantitativeAttributeCorrectness(ThematicAccuracy):
    """Correctness of non-quantitative attributes."""


@dataclass(frozen=True, slots=True)
class LogicalConsistency(Element):
    """
    Degree of adherence to logical rules of data structure, attribution and
    relationships (data structure can be conceptual, logical or physical).
    """


@dataclass(frozen=True, slots=True)
class ConceptualConsistency(LogicalConsistency):
    """Adherence to rules of the conceptual schema."""


@dataclass(frozen=True, slots=True)
class DomainConsistency(LogicalConsistency):
    """Adherence of values to the value domains."""


@dataclass(frozen=True, slots=True)
class FormatConsistency(LogicalConsistency):
    """
    Degree to which data is stored in accordance with the physical structure
    of the dataset, as described by the scope.
    """


@dataclass(frozen=True, slots=True)
class TopologicalConsistency(LogicalConsistency):
    """
    Correctness of the explicitly encoded topological characteristics of the
    dataset as described by the scope.
    """


@dataclass(frozen=True, slots=True)
class Completeness(Element):
    """
    Presence and absence of features, their attributes and their
    relationships.
    """


@dataclass(frozen=True, slots=True)
class CompletenessCommission(Completeness):
    """Excess data present in the dataset, as described by the scope."""


@dataclass(frozen=True, slots=True)
class CompletenessOmission(Completeness):
    """Data absent from the dataset, as described by the scope."""


@dataclass(frozen=True, slots=True)
class ConformanceResult(Result):
    """Information about the outcome of evaluating the obtained value (or set
    of values) against a specified acceptable conformance quality level.

    Attributes:
        specification (Citation): Citation of data product specification or
            user requirement against which data is being evaluated.
        explanation (str): Explanation of the meaning of conformance for this
            result.
        is_conform (bool): Indication of the conformance result where 0 = fail
            and 1 = pass.

    """

    specification: Citation
    explanation: str
    is_conform: bool


@dataclass(frozen=True, slots=True)
class CoverageResult(Result):
    """Result of a data quality measure organising the measured values as a
    coverage.

    Attributes:
        spatial_representation_type (SpatialRepresentationTypeCode): Method
            used to spatially represent the coverage result.
        result_file (DataFile): 
        result_spatial_representation (SpatialRepresentation): 
        result_content_description (CoverageDescription): 
        result_format (Format): 

    """

    spatial_representation_type: SpatialRepresentationTypeCode
    result_file: DataFile
    result_spatial_representation: SpatialRepresentation
    result_content_description: CoverageDescription
    result_format: Format


@dataclass(frozen=True, slots=True)
class QuantitativeResult(Result):
    """The values or information about the value(s) (or set of values)
    obtained from applying a data quality measure.

    Attributes:
        value (tuple[Record, ...]): Quantitative value or values, content
            determined by the evaluation procedure used, accordingly with the
            value type and valueStructure defined for the measure.
        value_unit (UnitOfMeasure): Value unit for reporting a data quality
            result.
        value_record_type (RecordType): Value type for reporting a data
            quality result, depends of the implementation.

    """

    value: tuple[Record, ...]
    value_unit: UnitOfMeasure
    value_record_type: RecordType
