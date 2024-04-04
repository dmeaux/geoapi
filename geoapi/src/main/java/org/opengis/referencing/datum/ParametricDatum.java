/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2016-2023 Open Geospatial Consortium, Inc.
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
package org.opengis.referencing.datum;

import java.util.Map;
import java.util.Optional;
import org.opengis.parameter.ParameterValueGroup;
import org.opengis.annotation.UML;

import static org.opengis.annotation.Obligation.OPTIONAL;
import static org.opengis.annotation.Specification.ISO_19111;


/**
 * Identification of a particular reference surface used as the origin of a parametric coordinate system.
 * The identification includes the frame position with respect to the Earth or other planet.
 * It may be a textual description and/or a set of parameters.
 *
 * @author  OGC Topic 2 (for abstract model and documentation)
 * @author  Johann Sorel (Geomatys)
 * @author  Martin Desruisseaux (Geomatys)
 * @version 3.1
 * @since   3.1
 *
 * @see DatumAuthorityFactory#createParametricDatum(String)
 * @see DatumFactory#createParametricDatum(Map)
 */
@UML(identifier="ParametricDatum", specification=ISO_19111)
public interface ParametricDatum extends Datum {
    /**
     * Parameters used to define the parametric datum.
     * Each parameter can be a parameter value, an ordered sequence of values,
     * or a reference to a file of parameter values that define a parametric datum.
     *
     * @return parameter used to define the parametric datum.
     *
     * @departure harmonization
     *   ISO 19111 defines a {@code DefiningParameter} class.
     *   GeoAPI retrofits in the {@link org.opengis.parameter} framework.
     */
    @UML(identifier="datumDefiningParameter", obligation=OPTIONAL, specification=ISO_19111)
    default Optional<ParameterValueGroup> getDatumDefiningParameter() {
        return Optional.empty();
    }
}
