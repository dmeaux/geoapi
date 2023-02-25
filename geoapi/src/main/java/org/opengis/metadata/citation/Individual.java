/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    http://www.geoapi.org
 *
 *    Copyright (C) 2014-2021 Open Geospatial Consortium, Inc.
 *    All Rights Reserved. http://www.opengeospatial.org/ogc/legal
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
package org.opengis.metadata.citation;

import org.opengis.annotation.UML;
import org.opengis.util.InternationalString;

import static org.opengis.annotation.Obligation.CONDITIONAL;
import static org.opengis.annotation.Specification.ISO_19115;


/**
 * Information about the party if the party is an individual.
 *
 * <p><b>Conditional properties:</b></p>
 * Following property has default method but shall nevertheless be implemented if the corresponding condition is met:
 * <ul>
 *   <li>{@linkplain #getPositionName() Position name} is mandatory if the
 *       {@linkplain #getName() name} (in parent interface) is not documented.</li>
 * </ul>
 *
 * @author  Rémi Maréchal (Geomatys)
 * @version 3.1
 * @since   3.1
 */
@UML(identifier="CI_Individual", specification=ISO_19115)
public interface Individual extends Party {
    /**
     * Position of the individual in an organisation.
     *
     * @return position of the individual in an organisation, or {@code null} if none.
     *
     * @condition Mandatory if {@linkplain #getName() name} is not documented.
     */
    @UML(identifier="positionName", obligation=CONDITIONAL, specification=ISO_19115)
    default InternationalString getPositionName() {
        return null;
    }
}
