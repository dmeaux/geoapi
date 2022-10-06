/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    http://www.geoapi.org
 *
 *    Copyright (C) 2021 Open Geospatial Consortium, Inc.
 *    All Rights Reserved. http://www.opengeospatial.org/ogc/legal
 *
 *    Permission to use, copy, and modify this software and its documentation, with
 *    or without modification, for any purpose and without fee or royalty is hereby
 *    granted, provided that you include the following on ALL copies of the software
 *    and documentation or portions thereof, including modifications, that you make:
 *
 *    1. The full text of this NOTICE in a location viewable to users of the
 *       redistributed or derivative work.
 *    2. Notice of any changes or modifications to the OGC files, including the
 *       date changes were made.
 *
 *    THIS SOFTWARE AND DOCUMENTATION IS PROVIDED "AS IS," AND COPYRIGHT HOLDERS MAKE
 *    NO REPRESENTATIONS OR WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 *    TO, WARRANTIES OF MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE OR THAT
 *    THE USE OF THE SOFTWARE OR DOCUMENTATION WILL NOT INFRINGE ANY THIRD PARTY
 *    PATENTS, COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS.
 *
 *    COPYRIGHT HOLDERS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL OR
 *    CONSEQUENTIAL DAMAGES ARISING OUT OF ANY USE OF THE SOFTWARE OR DOCUMENTATION.
 *
 *    The name and trademarks of copyright holders may NOT be used in advertising or
 *    publicity pertaining to the software without specific, written prior permission.
 *    Title to copyright in this software and any associated documentation will at all
 *    times remain with copyright holders.
 */
package org.opengis.metadata.quality;

import java.util.Collection;
import java.util.Collections;
import org.opengis.util.InternationalString;
import org.opengis.util.TypeName;
import org.opengis.annotation.UML;
import org.opengis.metadata.Identifier;

import static org.opengis.annotation.Obligation.*;
import static org.opengis.annotation.Specification.*;


/**
 * Data quality measure.
 * Measures are not referenced directly by {@link Element}.
 * Instead {@link Measure}s may be stored in a measure register or catalogue,
 * and referenced only indirectly with {@link MeasureReference}.
 *
 * @author  Alexis Gaillard (Geomatys)
 * @author  Martin Desruisseaux (Geomatys)
 * @version 3.1
 *
 * @see MeasureReference
 * @see Element#getMeasure()
 *
 * @since 3.1
 */
@UML(identifier="DQM_Measure", specification=ISO_19157)
public interface Measure {
    /**
     * Value uniquely identifying the measure within a namespace.
     * This identifier enables references to the data quality measure within the data quality elements.
     *
     * @return value uniquely identifying the measure within a namespace.
     *
     * @see MeasureReference#getMeasureIdentification()
     */
    @UML(identifier="measureIdentifier", obligation=MANDATORY, specification=ISO_19157)
    Identifier getMeasureIdentifier();

    /**
     * Name of the data quality measure applied to the data.
     * If the measure already has a commonly used name, this name should be used.
     * If no name exists, a name should be chosen that reflects the nature of the measure.
     *
     * @return name of the data quality measure applied to the data.
     *
     * @see MeasureReference#getNamesOfMeasure()
     */
    @UML(identifier="Name", obligation=MANDATORY, specification=ISO_19157)
    InternationalString getName();

    /**
     * Other recognized names, abbreviations or short names for the same data quality measure.
     * It may be a different commonly used name, or an abbreviation, or a short name.
     * More than one alias may be provided.
     *
     * @return others recognized names, abbreviations or short names.
     */
    @UML(identifier="alias", obligation=OPTIONAL, specification=ISO_19157)
    default Collection<? extends InternationalString> getAliases() {
        return Collections.emptyList();
    }

    /**
     * Names of the data quality element to which a measure applies.
     * More than one element name may be provided.
     *
     * @return names of the data quality element for which quality is reported.
     */
    @UML(identifier="elementName", obligation=MANDATORY, specification=ISO_19157)
    Collection<? extends TypeName> getElementNames();

    /**
     * Predefined basic measure on which this measure is based.
     * If a measure is based on one of the basic measures,
     * it shall be described by its name, definition and value type.
     *
     * <p>A variety of measures are based on counting of erroneous items.
     * There are also several measures dealing with the uncertainty of numerical values.
     * In order to avoid repetition, the most common methods of constructing count-related measures,
     * as well as general statistical measures, for one- and two-dimensional random variables
     * should be defined in terms of basic measures.</p>
     *
     * @condition mandatory if this measure is derived from basic measures.
     *
     * @return predefined basic measure on which this measure is based, or {@code null} if none.
     */
    @UML(identifier="basicMeasure", obligation=CONDITIONAL, specification=ISO_19157)
    default BasicMeasure getBasicMeasure() {
        return null;
    }

    /**
     * Definition of the fundamental concept for the data quality measure.
     * If the measure is derived from a {@linkplain #getBasicMeasure() basic measure},
     * the definition is based on the basic measure definition and specialized for this measure.
     *
     * @return definition of the fundamental concept for the data quality measure.
     */
    @UML(identifier="definition", obligation=MANDATORY, specification=ISO_19157)
    InternationalString getDefinition();

    /**
     * Description of the data quality measure.
     * Includes methods of calculation, with all formulae and/or illustrations
     * needed to establish the result of applying the measure.
     *
     * <p>If the measure uses the concept of errors, it should be stated how an item is classified as incorrect.
     * This is the case when the quality only can be reported as correct or incorrect.</p>
     *
     * @condition mandatory if the {@linkplain #getDefinition() definition} is not sufficient
     *            for the understanding of the data quality measure concept.
     *
     * @return description of data quality measure, or {@code null} if none.
     *
     * @see MeasureReference#getMeasureDescription()
     */
    @UML(identifier="description", obligation=CONDITIONAL, specification=ISO_19157)
    Description getDescription();

    /**
     * References to the source of an item that has been adopted from an external source.
     *
     * @condition mandatory is an external source exists.
     *
     * @return references to the source.
     */
    @UML(identifier="sourceReference", obligation=CONDITIONAL, specification=ISO_19157)
    default Collection<? extends SourceReference> getSourceReferences() {
        return Collections.emptyList();
    }

    /**
     * Value type for reporting a data quality result.
     *
     * @return value type for reporting a data quality result.
     */
    @UML(identifier="valueType", obligation=MANDATORY, specification=ISO_19157)
    TypeName getValueType();

    /**
     * Structure for reporting a complex data quality result.
     * A result may consist of multiple values.
     * In such cases, the result shall be structured using the value structure.
     *
     * @return structure for reporting a complex data quality result.
     */
    @UML(identifier="valueStructure", obligation=OPTIONAL, specification=ISO_19157)
    default ValueStructure getValueStructure() {
        return null;
    }

    /**
     * Auxiliary variable(s) used by the data quality measure.
     * It shall include its name, definition and value type.
     * More than one measure parameter may be provided.
     *
     * @return auxiliary variable(s) used by data quality measure.
     */
    @UML(identifier="parameter", obligation=CONDITIONAL, specification=ISO_19157)
    default Collection<? extends Parameter> getParameters() {
        return Collections.emptyList();
    }

    /**
     * Illustrations of the use of a data quality measure.
     * More than one example may be provided.
     *
     * @return examples of applying the measure or the result obtained for the measure.
     */
    @UML(identifier="example", obligation=OPTIONAL, specification=ISO_19157)
    default Collection<? extends Description> getExamples() {
        return Collections.emptyList();
    }
}
