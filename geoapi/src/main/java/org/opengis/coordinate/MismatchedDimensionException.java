/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2004-2023 Open Geospatial Consortium, Inc.
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
package org.opengis.coordinate;

import org.opengis.geometry.DirectPosition;


/**
 * Indicates that an operation cannot be completed properly because of a
 * mismatch in the number of dimensions of an argument given to a method.
 * For example, this exception may be thrown if a method expects a two-dimensional {@link DirectPosition}
 * argument but the {@linkplain DirectPosition#getDimension() dimension} of a given position was 3.
 *
 * @author  Martin Desruisseaux (IRD, Geomatys)
 * @version 3.1
 * @since   3.1
 */
public class MismatchedDimensionException extends MismatchedCoordinateMetadataException {
    /**
     * Serial number for inter-operability with different versions.
     */
    private static final long serialVersionUID = 3138484331425225155L;

    /**
     * Creates an exception with no message.
     */
    public MismatchedDimensionException() {
    }

    /**
     * Creates an exception with the specified message.
     *
     * @param message  the detail message, saved for later retrieval by the {@link #getMessage()} method.
     */
    public MismatchedDimensionException(String message) {
        super(message);
    }

    /**
     * Creates an exception with the specified message and cause.
     *
     * @param message  the detail message, saved for later retrieval by the {@link #getMessage()} method.
     * @param cause    the cause, saved for later retrieval by the {@link #getCause()} method.
     */
    public MismatchedDimensionException(String message, Throwable cause) {
        super(message, cause);
    }
}
