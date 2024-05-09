/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2006-2023 Open Geospatial Consortium, Inc.
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
package org.opengis.temporal;

import java.time.Duration;
import java.time.temporal.TemporalAmount;
import org.opengis.annotation.UML;
import static org.opengis.annotation.Specification.ISO_19108;


/**
 * <strong>Effectively deprecated</strong> — use {@code java.time.Duration} instead.
 * This interface defined by ISO 19108 represents the duration of a period in ISO 8601 format.
 * As of GeoAPI 3.1, this interface is replaced by the {@link TemporalAmount} interface from
 * the standard Java time API, or by the {@link Duration} specialization.
 * {@code PeriodDuration} is kept in GeoAPI 3.1 for compatibility reasons but will be removed in GeoAPI 4.0.
 *
 * @since 2.3
 *
 * @see TemporalAmount
 * @see Duration
 *
 * @version 3.1
 */
@UML(identifier="TM_PeriodDuration", specification=ISO_19108)
public interface PeriodDuration extends TemporalAmount {
}
