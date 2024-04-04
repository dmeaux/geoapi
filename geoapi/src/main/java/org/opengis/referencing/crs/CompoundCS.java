/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2023-2024 Open Geospatial Consortium, Inc.
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

import java.io.Serializable;
import org.opengis.metadata.Identifier;
import org.opengis.referencing.ReferenceIdentifier;
import org.opengis.referencing.cs.CoordinateSystem;
import org.opengis.referencing.cs.CoordinateSystemAxis;


/**
 * Default coordinate system of a compound CRS as a view over the CRS components.
 * This default coordinate system delegates all operations to the compound CRS provided by the implementer.
 * There is intentionally no caching, method calls are systematically redirected to the CRS implementation.
 * This is done that way in order to make no assumption about the implementer {@link CompoundCRS} behavior
 * (in particular whether the CRS is really immutable), and because caching would be mostly ineffective
 * anyway since {@code CompoundCS} instances are not themselves cached in {@link CompoundCRS} instances.
 * Implementers should override {@link CompoundCRS#getCoordinateSystem()} with their own implementation
 * for better performances or other characteristics such as WKT support.
 *
 * <h2>Serialization</h2>
 * Instances of this class are serializable if the wrapped <abbr>CRS</abbr> implementation is also serializable.
 *
 * @author  Martin Desruisseaux (Geomatys)
 * @version 3.1
 * @since   3.1
 */
final class CompoundCS implements CoordinateSystem, ReferenceIdentifier, Serializable {
    /**
     * For cross-version compatibility.
     */
    private static final long serialVersionUID = 3782889810638117329L;

    /**
     * The CRS provided by the implementer.
     */
    @SuppressWarnings("serial")         // Whether the CRS is serializable is implementor's decision.
    private final CompoundCRS crs;

    /**
     * Creates a new default CS for the specified compound CRS.
     *
     * @param  crs  the CRS provided by the implementer.
     */
    CompoundCS(final CompoundCRS crs) {
        this.crs = crs;
    }

    /**
     * {@return a synthetic name for this coordinate system}.
     * The returned identifier implements only {@link #getCode()}.
     */
    @Override
    public ReferenceIdentifier getName() {
        return this;
    }

    /**
     * {@return a synthetic code for this coordinate system}.
     */
    @Override
    public String getCode() {
        final Identifier n = crs.getName();
        return "Coordinate system of " + ((n != null) ? n.getCode() : crs);
    }

    /**
     * {@return the total number of dimensions of all components}.
     */
    @Override
    public int getDimension() {
        int dimension = 0;
        for (final CoordinateReferenceSystem c : crs.getComponents()) {
            dimension += c.getCoordinateSystem().getDimension();
        }
        return dimension;
    }

    /**
     * Returns the axis for this coordinate system at the specified dimension.
     *
     * @param  dimension  the zero based index of axis.
     * @return the axis at the specified dimension.
     * @throws IndexOutOfBoundsException if {@code dimension} is out of bounds.
     */
    @Override
    public CoordinateSystemAxis getAxis(final int dimension) {
        int i = dimension;
        if (i >= 0) {
            for (final CoordinateReferenceSystem c : crs.getComponents()) {
                final CoordinateSystem cs = c.getCoordinateSystem();
                final int n = cs.getDimension();
                if (i < n) {
                    return cs.getAxis(i);
                }
                i -= n;
            }
        }
        throw new IndexOutOfBoundsException(dimension);
    }
}
