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
package org.opengis.util;


/**
 * Thrown when a {@linkplain Factory factory} can't create an instance
 * of the requested object.
 * <p>
 * If the failure is caused by an illegal authority code, then the actual exception should
 * be {@link org.opengis.referencing.NoSuchAuthorityCodeException}. Otherwise, if the failure
 * is caused by some error in the underlying database (e.g. {@link java.io.IOException} or
 * {@link java.sql.SQLException}), then the cause shall be specified to the constructor.
 *
 * @departure extension
 *   This exception is not part of the OGC specification.
 *
 * @author  Martin Desruisseaux (IRD)
 * @version 3.0
 * @since   1.0
 *
 * @see org.opengis.referencing.operation.CoordinateOperationFactory
 */
public class FactoryException extends Exception {
    /**
     * Serial number for inter-operability with different versions.
     */
    private static final long serialVersionUID = -3414250034883898315L;

    /**
     * Construct an exception with no detail message.
     */
    public FactoryException() {
    }

    /**
     * Constructs an exception with the specified detail message.
     *
     * @param  message The detail message. The detail message is saved
     *         for later retrieval by the {@link #getMessage()} method.
     */
    public FactoryException(String message) {
        super(message);
    }

    /**
     * Constructs an exception with the specified cause.
     *
     * @param  cause The cause for this exception. The cause is saved
     *         for later retrieval by the {@link #getCause()} method.
     */
    public FactoryException(Throwable cause) {
        super(cause);
    }

    /**
     * Constructs an exception with the specified detail message and cause.
     * The cause is the exception thrown in the underlying database
     * (e.g. {@link java.io.IOException} or {@link java.sql.SQLException}).
     *
     * @param  message The detail message. The detail message is saved
     *         for later retrieval by the {@link #getMessage()} method.
     * @param  cause The cause for this exception. The cause is saved
     *         for later retrieval by the {@link #getCause()} method.
     */
    public FactoryException(String message, Throwable cause) {
        super(message, cause);
    }
}
