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
package org.opengis.referencing.operation;


/**
 * Base interface for for azimuthal (or planar) map projections.
 *
 * @author  Martin Desruisseaux (IRD)
 * @version 3.1
 * @since   1.0
 *
 * @see org.opengis.referencing.crs.ProjectedCRS
 *
 * @deprecated
 *   This interface is not part of the OGC/ISO abstract specifications. This interface has been added in GeoAPI
 *   as a way to know the kind of map projection, but it is only one classification scheme among many.
 *   This way of classifying projections is difficult to implement and rarely used.
 */
@Deprecated(since = "3.1")
public interface PlanarProjection extends Projection {
}
