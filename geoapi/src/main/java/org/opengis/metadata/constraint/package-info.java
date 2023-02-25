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

/**
 * {@linkplain org.opengis.metadata.constraint.Constraints} information
 * (includes legal and security). The following is adapted from
 * {@linkplain org.opengis.annotation.Specification#ISO_19115 OpenGIS&reg; Metadata (Topic 11)}
 * specification.
 *
 * <P ALIGN="justify">This package contains information concerning the restrictions placed on data.
 * The {@linkplain org.opengis.metadata.constraint.Constraints constraints} entity is optional and
 * may be specified as {@linkplain org.opengis.metadata.constraint.LegalConstraints legal constraints}
 * and/or {@linkplain org.opengis.metadata.constraint.SecurityConstraints security constraints}. The
 * {@linkplain org.opengis.metadata.constraint.LegalConstraints#getOtherConstraints other constraint}
 * element shall be non-null (used) only if
 * {@linkplain org.opengis.metadata.constraint.LegalConstraints#getAccessConstraints access constraints} and/or
 * {@linkplain org.opengis.metadata.constraint.LegalConstraints#getUseConstraints use constraints} elements have
 * a value of "{@linkplain org.opengis.metadata.constraint.Restriction#OTHER_RESTRICTIONS other restrictions}".</P>
 *
 * @author  Martin Desruisseaux (IRD)
 * @author  Cory Horner (Refractions Research)
 * @version 3.0
 * @since   2.0
 */
package org.opengis.metadata.constraint;
