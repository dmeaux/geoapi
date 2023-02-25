/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2008-2023 Open Geospatial Consortium, Inc.
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
package org.opengis.style;

import org.opengis.annotation.XmlElement;
import org.opengis.filter.Expression;

/**
 * An AnchorPoint identifies the location inside a textlabel to use as an
 * "anchor" for positioning it relative to a point geometry.
 *
 * @version <A HREF="http://www.opengeospatial.org/standards/symbol">Symbology Encoding Implementation Specification 1.1.0</A>
 * @author Open Geospatial Consortium
 * @author Johann Sorel (Geomatys)
 * @author Ian Turton
 * @since GeoAPI 2.2
 */
@XmlElement("AnchorPoint")
public interface AnchorPoint {

    /**
     * get the x coordinate of the anchor point
     *
     * @return the expression which represents the X coordinate
     */
    @XmlElement("AnchorPointX")
    Expression getAnchorPointX();

    /**
     * get the y coordinate of the anchor point
     *
     * @return the expression which represents the Y coordinate
     */
    @XmlElement("AnchorPointY")
    Expression getAnchorPointY();

    /**
     * calls the visit method of a StyleVisitor
     *
     * @param visitor the style visitor
     */
    Object accept(StyleVisitor visitor, Object extraData);

}
