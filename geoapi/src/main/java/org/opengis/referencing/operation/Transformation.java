/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2004-2011 Open Geospatial Consortium, Inc.
 *    http://www.geoapi.org
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */
package org.opengis.referencing.operation;

import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.opengis.annotation.UML;
import static org.opengis.annotation.Obligation.*;
import static org.opengis.annotation.Specification.*;


/**
 * An operation on coordinates that usually includes a change of Datum. The parameters
 * of a coordinate transformation are empirically derived from data containing the coordinates
 * of a series of points in both coordinate reference systems. This computational process
 * is usually "over-determined", allowing derivation of error (or accuracy) estimates
 * for the transformation. Also, the stochastic nature of the parameters may result
 * in multiple (different) versions of the same coordinate transformation.
 *
 * @author  Martin Desruisseaux (IRD)
 * @version 3.0
 * @since   1.0
 *
 * @see Conversion
 */
@UML(identifier="CC_Transformation", specification=ISO_19111)
public interface Transformation extends SingleOperation {
    /**
     * Returns the source CRS.
     *
     * @return The source CRS (never {@code null}).
     */
    @UML(identifier="sourceCRS", obligation=MANDATORY, specification=ISO_19111)
    CoordinateReferenceSystem getSourceCRS();

    /**
     * Returns the target CRS.
     *
     * @return The target CRS (never {@code null}).
     */
    @UML(identifier="targetCRS", obligation=MANDATORY, specification=ISO_19111)
    CoordinateReferenceSystem getTargetCRS();

    /**
     * Version of the coordinate transformation (i.e., instantiation due to the stochastic
     * nature of the parameters). This attribute is mandatory in a Transformation.
     *
     * @return The coordinate operation version.
     */
    @UML(identifier="operationVersion", obligation=MANDATORY, specification=ISO_19111)
    String getOperationVersion();
}
