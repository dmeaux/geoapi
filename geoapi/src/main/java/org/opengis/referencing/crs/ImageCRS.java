/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2003-2023 Open Geospatial Consortium, Inc.
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

import java.util.Map;
import org.opengis.referencing.cs.AffineCS;
import org.opengis.referencing.cs.CartesianCS;
import org.opengis.referencing.datum.ImageDatum;
import org.opengis.annotation.UML;

import static org.opengis.annotation.Obligation.*;
import static org.opengis.annotation.Specification.*;


/**
 * A 2-dimensional engineering <abbr>CRS</abbr> applied to locations in images.
 *
 * <div class="note"><b>Note:</b>
 * image coordinate reference systems are treated as a separate sub-type because a separate
 * user community exists for images with its own terms of reference. Furthermore, image datum
 * contains a property not relevant to other engineering datums.</div>
 *
 * <p>This type of CRS can be used with coordinate systems of type
 * {@link org.opengis.referencing.cs.CartesianCS} or
 * {@link org.opengis.referencing.cs.AffineCS}.</p>
 *
 * @author  Martin Desruisseaux (IRD, Geomatys)
 * @version 3.0
 * @since   1.0
 *
 * @see CRSAuthorityFactory#createImageCRS(String)
 * @see CRSFactory#createImageCRS(Map, ImageDatum, AffineCS)
 *
 * @deprecated Replaced by {@link EngineeringCRS} as of ISO 19111:2019.
 */
@Deprecated(since="3.1")
@UML(identifier="SC_ImageCRS", specification=ISO_19111, version=2007)
public interface ImageCRS extends SingleCRS {
    /**
     * Returns the affine coordinate system, which shall be {@linkplain AffineCS affine} or
     * {@linkplain CartesianCS Cartesian}.
     *
     * @return the affine or Cartesian coordinate system.
     */
    @Override
    @UML(identifier="coordinateSystem", obligation=MANDATORY, specification=ISO_19111)
    AffineCS getCoordinateSystem();

    /**
     * Returns the datum, which shall be an image one.
     */
    @Override
    @UML(identifier="datum", obligation=MANDATORY, specification=ISO_19111)
    ImageDatum getDatum();
}
