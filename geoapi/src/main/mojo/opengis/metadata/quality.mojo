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

"""This is the quality module.


This module contains geographic metadata structures derived from the
ISO 19115-1:2014 international standard and data quality structures derived
from the ISO 19157:2013 international standard.
"""

from opengis.metadata.citation import Citation, Identifier
from opengis.metadata.content import CoverageDescription
from opengis.metadata.distribution import DataFile, Format
from opengis.metadata.identification import BrowseGraphic
from opengis.metadata.maintenance import Scope
from opengis.metadata.naming import Record, RecordType
from opengis.metadata.representation import SpatialRepresentationTypeCode


struct EvaluationMethodTypeCode():
    alias DIRECT_INTERNAL = "directInternal"
    alias DIRECT_EXTERNAL = "directExternal"
    alias INDIRECT = "indirect"


struct ValueStructure():
    alias BAG = "BAG"
    alias SET = "SET"
    alias SEQUENCE = "SEQUENCE"
    alias TABLE = "TABLE"
    alias MATRIX = "MATRIX"
    alias COVERAGE = "COVERAGE"


trait StandaloneQualityReportInformation():
    """Reference to an external stadalone quality report."""

    fn report_reference(self) -> Citation:
        """Reference to the associated standalone quality report."""
        ...

    fn abstract(self) -> String:
        """Abstract for the associated standalone quality report."""
        ...


trait Result():
    """Generalization of more specific result classes."""

    fn result_scope(self) -> Scope:
        """Scope of the result."""
        ...

    fn date_time(self) -> datetime:
        """Date when the result was generated."""
        ...


trait EvaluationMethod():
    """Description of the evaluation method and procedure applied."""

    fn evaluation_method_type(self) -> EvaluationMethodTypeCode:
        """Type of method used to evaluate quality of the data."""
        ...

    fn evaluation_method_description(self) -> String:
        """Description of the evaluation method."""
        ...

    fn evaluation_procedure(self) -> Citation:
        """Reference to the procedure information."""
        ...

    fn reference_doc(self) -> Sequence[Citation]:
        """Information on documents which are referenced in developing and applying a data quality evaluation method."""
        ...

    fn date_time(self) -> Sequence[Date]:
        """Date or range of dates on which a data quality measure was applied."""
        ...


trait MeasureReference():
    """Reference to the measure used."""

    fn measure_identification(self) -> Identifier:
        """Identifier of the measure, value uniquely identifying the measure within a namespace."""
        ...

    fn name_of_measure(self) -> Sequence[String]:
        """Name of the test applied to the data."""
        ...

    fn measure_description(self) -> String:
        """Description of the measure."""
        ...


trait Element():
    """Aspect of quantitative quality information."""

    fn Standalone_quality_report_details(self) -> String:
        """Clause in the standaloneQualityReport where this data quality element or any related data quality element (original results in case of derivation or aggregation) is described."""
        ...

    fn Measure(self) -> MeasureReference:
        """Reference to measure used."""
        ...

     fn Evaluation_method(self) -> EvaluationMethod:
        """Evaluation information."""
        ...

    fn result(self) -> Sequence[Result]:
        """Values obtained from applying a data quality measure against a specified acceptable conformance quality level."""
        ...

     fn derived_element(self) -> Sequence[Element]:
        """In case of aggregation or derivation, indicates the original element."""
        ...


trait DataQuality():
    """Quality information for the data specified by a data quality scope."""

    fn scope(self) -> Scope:
        """The specific data to which the data quality information applies."""
        ...

    fn report(self) -> Sequence[Element]:
        """Quantitative quality information for the data specified by the scope."""
        ...

    fn standalone_quality_report(self) -> StandaloneQualityReportInformation:
        ...


trait Description():
    """Data quality measure description."""

    fn text_description(self) -> String:
        """Text description."""
        ...

    fn extended_Description(self) -> BrowseGraphic:
        """Illustration."""
        ...


trait SourceReference():
    """Reference to the source of the data quality measure."""

    fn citation(self) -> Citation:
        """References to the source."""
        ...


trait BasicMeasure():
    """Data quality basic measure."""

    fn name(self) -> String:
        """Name of the data quality basic measure applied to the data."""
        ...

    fn definition(self) -> String:
        """Definition of the data quality basic measure."""
        ...

    fn exemple(self) -> Description:
        """Illustration of the use of a data quality measure."""
        ...

    fn value_type(self) -> TypeName:
        """Value type for the result of the basic measure (shall be one of the data types defined in ISO/TS 19103:2005)."""
        ...


trait Measure():
    """Data quality measure."""

    fn measure_identifier(self) -> Identifier:
        """Value uniquely identifying the measure within a namespace."""
        ...

    fn name(self) -> String:
        """Name of the data quality measure applied to the data."""
        ...

    fn alias(self) -> String:
        """Another recognized name, an abbreviation or a short name for the same data quality measure."""
        ...

    fn element_name(self) -> TypeName:
        """Name of the data quality element for which quality is reported."""
        ...

    fn definition(self) -> String:
        """Definition of the fundamental concept for the data quality measure."""
        ...

    fn description(self) -> description:
        """Description of the data quality measure, including all formulae and/or illustrations needed to establish the result of applying the measure."""
        ...

    fn value_type(self) -> TypeName:
        """Value type for reporting a data quality result (shall be one of the data types defined in ISO/19103:2005)."""
        ...

    fn value_structure(self) -> ValueStructure:
        """Structure for reporting a complex data quality result."""
        ...

    fn example(self) -> Sequence[Description]:
        """Illustration of the use of a data quality measure."""
        ...

    fn basic_measure(self) -> BasicMeasure:
        """Definition of the fundamental concept for the data quality measure."""
        ...

    fn source_reference(self) -> Sequence[SourceReference]:
        """Reference to the source of an item that has been adopted from an external source."""
        ...

    fn parameter(self):
        """Reference to the source of an item that has been adopted from an external source."""
        ...


trait TemporalQuality(Element):
    """Accuracy of the temporal attributes and temporal relationships of features."""
...


trait Metaquality(Element):
    """Information about the reliability of data quality results."""

    fn derived_element(self) -> Sequence[Element]:
        """Derived element."""
        ...


trait Confidence(Metaquality):
    """Trustworthiness of a data quality result."""
...


trait Representativity(Metaquality):
    """Trustworthiness of a data quality result."""
...


trait DataEvaluation(EvaluationMethod):
    """Data evaluation method."""
...


trait SimpleBasedInspection(DataEvaluation):
    """Sample based inspection."""

    fn sampling_scheme(self) -> String:
        """Information of the type of sampling scheme and description of the sampling procedure."""
        ...

    fn lot_description(self) -> String:
        """Information of how lots are defined."""
        ...

    fn simple_ratio(self) -> String:
        """Information on how many samples on average are extracted for inspection from each lot of population."""
        ...


trait IndirectEvaluation(DataEvaluation):
    """Indirect evaluation."""

    fn deductive_source(self) -> String:
        """Information on which data are used as sources in deductive evaluation method."""
        ...


trait Homogeneity(Metaquality):
    """Expected or tested uniformity of the results obtained for a data quality evaluation."""
...


trait FullInspection(DataEvaluation):
    """Test of every item in the population specified by the data quality scope."""
...


trait DescriptiveResult(Result):
    """Data quality descriptive result."""

    fn statement(self) -> String:
        """Textual expression of the descriptive result."""
        ...


trait AggregationDerivation(EvaluationMethod):
    """Aggregation or derivation method."""
...


trait PositionalAccuracy(Element):
    """Accuracy of the position of features."""
...


trait AbsoluteExternalPositionalAccuracy(PositionalAccuracy):
    """Closeness of reported coordinate values to values accepted as or being true."""
...


trait GriddedDataPositionalAccuracy(PositionalAccuracy):
    """Closeness of gridded data position values to values accepted as or being true."""
...


trait RelativeInternalPositionalAccuracy(PositionalAccuracy):
    """Closeness of the relative positions of features in the scope to their respective relative positions accepted as or being true."""
...


trait TemporalConsistency(TemporalQuality):
    """Correctness of ordered events or sequences, if reported."""
...


trait TemporalValidity(TemporalQuality):
    """Validity of data specified by the scope with respect to time."""
...


trait AccuracyOfATimeMeasurement(TemporalQuality):
    """Correctness of the temporal references of an item (reporting of error in time measurement)."""
...


trait ThematicAccuracy(Element):
    """Accuracy of quantitative attributes and the correctness of non-quantitative attributes and of the classifications of features and their relationships."""
...


trait ThematicClassificationCorrectness(ThematicAccuracy):
    """Comparison of the classes assigned to features or their attributes to a universe of discourse."""
...


trait QuantitativeAttributeAccuracy(ThematicAccuracy):
    """Accuracy of quantitative attributes."""
...


trait NonQuantitativeAttributeCorrectness(ThematicAccuracy):
    """Correctness of non-quantitative attributes."""
...


trait LogicalConsistency(Element):
    """Degree of adherence to logical rules of data structure, attribution and relationships (data structure can be conceptual, logical or physical)."""
...


trait ConceptualConsistency(LogicalConsistency):
    """Adherence to rules of the conceptual schema."""
...


trait DomainConsistency(LogicalConsistency):
    """Adherence of values to the value domains."""
...


trait FormatConsistency(LogicalConsistency):
    """Degree to which data is stored in accordance with the physical structure of the dataset, as described by the scope."""
...


trait TopologicalConsistency(LogicalConsistency):
    """Correctness of the explicitly encoded topological characteristics of the dataset as described by the scope."""
...


trait Completeness(Element):
    """Presence and absence of features, their attributes and their relationships."""
...


trait CompletenessCommission(Completeness):
    """Excess data present in the dataset, as described by the scope."""
...


trait CompletenessOmission(Completeness):
    """Data absent from the dataset, as described by the scope."""
...


trait ConformanceResult(Result):
    """Information about the outcome of evaluating the obtained value (or set of values) against a specified acceptable conformance quality level."""

    fn specification(self) -> Citation:
        """Citation of data product specification or user requirement against which data is being evaluated."""
        ...

    fn explanation(self) -> String:
        """Explanation of the meaning of conformance for this result."""
        ...

    fn is_conform(self):
        """Indication of the conformance result where 0 = fail and 1 = ...."""
        ...


trait CoverageResult(Result):
    """Result of a data quality measure organising the measured values as a coverage."""

    fn spatial_representation_type(self) -> SpatialRepresentationTypeCode:
        """Method used to spatially represent the coverage result."""
        ...

    fn result_file(self) -> DataFile:
        ...

    fn result_spatial_representation(self) -> SpatialRepresentation:
        ...

    fn result_content_description(self) -> CoverageDescription:
        ...

    fn result_format(self) -> Format:
        ...


trait QuantitativeResult(Result):
    """The values or information about the value(s) (or set of values) obtained from applying a data quality measure."""

    fn value(self) -> Sequence[Record]:
        """Quantitative value or values, content determined by the evaluation procedure used, accordingly with the value type and valueStructure defined for the measure."""
        ...

    fn value_unit(self) -> Unit:
        """Value unit for reporting a data quality result."""
        ...


    fn value_record_type(self) -> RecordType:
        """Value type for reporting a data quality result, depends of the implementation."""
        ...
