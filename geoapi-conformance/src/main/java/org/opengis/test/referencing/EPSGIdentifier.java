/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    http://www.geoapi.org
 *
 *    Copyright (C) 2012-2021 Open Geospatial Consortium, Inc.
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
package org.opengis.test.referencing;

import org.opengis.referencing.ReferenceIdentifier;


/**
 * A simple implementation of {@link ReferenceIdentifier},
 * used for {@link PseudoEpsgFactory} purpose only.
 *
 * @author  Martin Desruisseaux (Geomatys)
 * @version 3.1
 * @since   3.1
 */
final strictfp class EPSGIdentifier implements ReferenceIdentifier {
    /**
     * The value to be returned by {@link #getCode()}.
     */
    private final int code;

    /**
     * Creates a new identifier for the "EPSG" namespace and the given code.
     */
    EPSGIdentifier(final int code) {
        this.code = code;
    }

    /**
     * Returns the code given at construction time.
     *
     * @return string representation of the code given at construction time.
     */
    @Override
    public String getCode() {
        return String.valueOf(code);
    }

    /**
     * Returns the code space, which is fixed to {@code "EPSG"}.
     *
     * @return {@code "EPSG"}.
     */
    @Override
    public String getCodeSpace() {
        return "EPSG";
    }

    /**
     * Returns a string representation of this identifier.
     */
    @Override
    public String toString() {
        return "EPSG:" + code;
    }

    /**
     * Returns an arbitrary hash code value for this identifier.
     * Current implementation does not use the codespace, since
     * tested EPSG and EPSG codes do not overlap.
     */
    @Override
    public int hashCode() {
        return code ^ 45729784;
    }

    /**
     * Compares this identifier with the given object for equality.
     */
    @Override
    public boolean equals(final Object obj) {
        return (obj instanceof EPSGIdentifier) && code == ((EPSGIdentifier) obj).code;
    }
}
