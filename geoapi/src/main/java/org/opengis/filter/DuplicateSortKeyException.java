/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2021-2023 Open Geospatial Consortium, Inc.
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
package org.opengis.filter;

import org.opengis.annotation.UML;

import static org.opengis.annotation.Specification.ISO_19143;


/**
 * Thrown if {@code SortBy} has multiple {@code SortProperty} elements referencing the same value.
 *
 * @author  Martin Desruisseaux (Geomatys)
 * @version 3.1
 * @since   3.1
 */
@UML(identifier="DuplicateSortKey", specification=ISO_19143)
public class DuplicateSortKeyException extends RuntimeException {
    /**
     * Serial number for inter-operability with different versions.
     */
    private static final long serialVersionUID = -5514345183414858878L;

    /**
     * Creates an exception with no message.
     */
    public DuplicateSortKeyException() {
        super();
    }

    /**
     * Creates an exception with the specified message.
     *
     * @param message  the detail message, saved for later retrieval by the {@link #getMessage()} method.
     */
    public DuplicateSortKeyException(final String message) {
        super(message);
    }

    /**
     * Creates an exception with the specified message and cause.
     *
     * @param message  the detail message, saved for later retrieval by the {@link #getMessage()} method.
     * @param cause    the cause, saved for later retrieval by the {@link #getCause()} method.
     */
    public DuplicateSortKeyException(final String message, final Throwable cause) {
        super(message, cause);
    }
}
