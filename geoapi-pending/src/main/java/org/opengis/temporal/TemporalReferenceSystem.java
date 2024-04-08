/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2005-2023 Open Geospatial Consortium, Inc.
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

import org.opengis.metadata.Identifier;
import org.opengis.referencing.ReferenceIdentifier;
import org.opengis.referencing.ReferenceSystem;
import org.opengis.annotation.UML;

import static org.opengis.annotation.Obligation.*;
import static org.opengis.annotation.Specification.*;


/**
 * Provides information about a temporal reference system.
 * <p>
 * This interface is similar to ReferenceSytem and may be deprecated
 * in the future. It is made available currently in order to *exactly*
 * match this ISO 19108 specification with a "domain of validity"
 * association to an Extent.
 * </p>
 * @author Stephane Fellah (Image Matters)
 * @author Alexander Petkov
 */
@UML(identifier="TM_ReferenceSystem", specification=ISO_19108)
public interface TemporalReferenceSystem extends ReferenceSystem {
    /**
     * Returns name that uniquely identifies the temporal reference system.
     *
     * Currently returns MD_Identifier, which is defined in ISO 19115, while ISO 19108
     * requires that RS_Identifier (defined in ISO 19111 and http://www.opengis.org/docs/03-073r1.zip) is returned.
     * From the looks of it, org.opengis.referencing.ReferenceSystem could also fit the bill.
     *
     * @return {@link Identifier} for the temporal reference system
     */
    @Override
    @UML(identifier="name", obligation=MANDATORY, specification=ISO_19108)
    ReferenceIdentifier getName();
}
