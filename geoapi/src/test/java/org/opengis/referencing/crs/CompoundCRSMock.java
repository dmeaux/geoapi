/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2023 Open Geospatial Consortium, Inc.
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
package org.opengis.referencing.crs;

import java.util.List;
import org.opengis.metadata.Identifier;


/**
 * A dummy implementation of a compound CRS.
s *
 * @author  Martin Desruisseaux (Geomatys)
 * @version 4.0
 * @since   3.1
 */
final class CompoundCRSMock implements CompoundCRS, Identifier {
    /**
     * A dummy name for this compound CRS.
     */
    static final String NAME = "Compound CRS mock";

    /**
     * The components of this compound CRS.
     */
    private final List<CoordinateReferenceSystem> components;

    /**
     * Creates a new mock with only single CRSs.
     *
     * @param  components  the components of this compound CRS.
     */
    CompoundCRSMock(final CoordinateSystemMock... components) {
        this.components = List.of(components);
        for (int i=1; i < components.length; i++) {
            components[i-1].assertContinuous(components[i]);
        }
    }

    /**
     * Creates a new mock with a nested compound CRS.
     */
    CompoundCRSMock(final CoordinateSystemMock head, final CompoundCRSMock tail) {
        components = List.of(head, tail);
    }

    /**
     * Returns a dummy name for this compound CRS.
     */
    @Override
    public Identifier getName() {
        return this;
    }

    /**
     * Returns a dummy name for this compound CRS.
     */
    @Override
    public String getCode() {
        return NAME;
    }

    /**
     * Returns the components of this compound CRS.
     */
    @Override
    @SuppressWarnings("ReturnOfCollectionOrArrayField")
    public List<CoordinateReferenceSystem> getComponents() {
        return components;
    }
}
