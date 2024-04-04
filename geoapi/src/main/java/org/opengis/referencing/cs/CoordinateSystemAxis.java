/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2003-2024 Open Geospatial Consortium, Inc.
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
package org.opengis.referencing.cs;

import java.util.Map;
import javax.measure.Unit;
import org.opengis.referencing.IdentifiedObject;
import org.opengis.annotation.UML;

import static org.opengis.annotation.Obligation.*;
import static org.opengis.annotation.Specification.*;


/**
 * Definition of a coordinate system axis.
 * Each axis is characterized by a unique combination of name, abbreviation, direction and unit.
 *
 * <h2>Axis name</h2>
 * Usage of coordinate system axis names is constrained by geodetic custom in a number of cases,
 * depending mainly on the coordinate reference system type. These constraints are shown in the table below.
 * This constraint works in two directions; for example the names <q>geodetic latitude</q> and <q>geodetic longitude</q>
 * shall be used to designate the coordinate axis names associated with a geographic coordinate reference system.
 * Conversely, these names shall not be used in any other context.
 *
 * <table class="ogc">
 * <caption>Context of coordinate system axis names usage</caption>
 * <tr><th><abbr>CS</abbr></th>
 *     <th><abbr>CRS</abbr></th>
 *     <th>Permitted coordinate system axis names</th></tr>
 * <tr><td>Cartesian</td><td>Geodetic</td>
 *     <td>“geocentric <var>X</var>”,
 *         “geocentric <var>Y</var>”,
 *         “geocentric <var>Z</var>”</td></tr>
 * <tr><td>Cartesian</td><td>Projected</td>
 *     <td>“easting” or “westing”,
 *         “northing” or “southing”,
 *         “ellipsoidal height” (if 3D)</td></tr>
 * <tr><td>Ellipsoidal</td><td>Geographic</td>
 *     <td>“geodetic latitude”,
 *         “geodetic longitude”,
 *         “ellipsoidal height” (if 3D)</td></tr>
 * <tr><td>Spherical</td><td>Geodetic</td>
 *     <td>“spherical latitude”,
 *         “spherical longitude”,
 *         “geocentric radius” (if 3D)</td></tr>
 * <tr><td>″</td><td>″</td>
 *     <td>“geocentric latitude”,
 *         “geodetic longitude”,
 *         “geocentric radius” (if 3D)</td></tr>
 * <tr><td>″</td><td>″</td>
 *     <td>“geocentric co-latitude”,
 *         “geodetic longitude”,
 *         “geocentric radius” (if 3D)</td></tr>
 * <tr><td>Vertical</td><td>Vertical</td>
 *     <td>“depth” or “gravity-related height”</td></tr>
 * </table>
 *
 * Parametric, temporal and engineering coordinate reference systems may make use of names specific
 * to the local context or custom and are therefore not included as constraints in the above list.
 *
 * <h2>Axis direction</h2>
 * The {@linkplain #getDirection() direction} of the coordinate axes is often only approximate.
 * Two geographic coordinate reference systems will make use of the same ellipsoidal coordinate system.
 * These coordinate systems are associated with the planet through two different geodetic reference frames,
 * which may lead to the two systems being slightly rotated with respect to each other.
 *
 * @author  OGC Topic 2 (for abstract model and documentation)
 * @author  Martin Desruisseaux (IRD, Geomatys)
 * @version 3.1
 * @since   1.0
 *
 * @see CoordinateSystem
 * @see CSAuthorityFactory#createCoordinateSystemAxis(String)
 * @see CSFactory#createCoordinateSystemAxis(Map, String, AxisDirection, Unit)
 */
@UML(identifier="CoordinateSystemAxis", specification=ISO_19111)
public interface CoordinateSystemAxis extends IdentifiedObject {
    /**
     * Returns the abbreviation used for this coordinate system axes.
     * This abbreviation is also used to identify the coordinates in coordinate tuple.
     * Examples are “<var>X</var>” and “<var>Y</var>”.
     *
     * @return the coordinate system axis abbreviation.
     */
    @UML(identifier="axisAbbrev", obligation=MANDATORY, specification=ISO_19111)
    String getAbbreviation();

    /**
     * Returns the direction of this coordinate system axis. In the case of Cartesian projected
     * coordinates, this is the direction of this coordinate system axis locally.
     * Examples:
     * {@linkplain AxisDirection#NORTH north} or {@linkplain AxisDirection#SOUTH south},
     * {@linkplain AxisDirection#EAST  east}  or {@linkplain AxisDirection#WEST  west},
     * {@linkplain AxisDirection#UP    up}    or {@linkplain AxisDirection#DOWN  down}.
     *
     * <p>Within any set of coordinate system axes, only one of each pair of terms can be used.
     * For planet-fixed coordinate reference systems, this direction is often approximate
     * and intended to provide a human interpretable meaning to the axis.
     * When a geodetic reference frame is used, the precise directions of the axes may therefore
     * vary slightly from this approximate direction.</p>
     *
     * <p>Note that an {@link org.opengis.referencing.crs.EngineeringCRS} often requires
     * specific descriptions of the directions of its coordinate system axes.</p>
     *
     * @return the coordinate system axis direction.
     */
    @UML(identifier="axisDirection", obligation=MANDATORY, specification=ISO_19111)
    AxisDirection getDirection();

    /**
     * Returns the unit of measure used for this coordinate system axis.
     * The value of a coordinate in a coordinate tuple shall be recorded using this unit of measure,
     * whenever those coordinates use a coordinate reference system that uses a coordinate system
     * that uses this axis.
     *
     * <h4>Obligation</h4>
     * This element may be {@code null} if this axis is part of an ordinal <abbr>CS</abbr>
     * (a coordinate system in which axes use {@linkplain CoordinateDataType#INTEGER integer values})
     * and in the case of a {@link TimeCS} using {@linkplain CoordinateDataType#DATE_TIME date-time}.
     * This property is mandatory for all other cases.
     *
     * @return the coordinate system axis unit.
     */
    @UML(identifier="axisUnitID", obligation=CONDITIONAL, specification=ISO_19111)
    Unit<?> getUnit();

    /**
     * Returns the minimum value normally allowed for this axis.
     * The value shall be in the {@linkplain #getUnit() unit of measure for the axis}.
     * If there is no minimum value, then this method returns
     * {@linkplain Double#NEGATIVE_INFINITY negative infinity}.
     *
     * @return the minimum value, or {@link Double#NEGATIVE_INFINITY} if none.
     */
    @UML(identifier="minimumValue", obligation=OPTIONAL, specification=ISO_19111)
    default double getMinimumValue() {
        return Double.NEGATIVE_INFINITY;
    }

    /**
     * Returns the maximum value normally allowed for this axis.
     * The value shall be in the {@linkplain #getUnit() unit of measure for the axis}.
     * If there is no maximum value, then this method returns
     * {@linkplain Double#POSITIVE_INFINITY positive infinity}.
     *
     * @return the maximum value, or {@link Double#POSITIVE_INFINITY} if none.
     */
    @UML(identifier="maximumValue", obligation=OPTIONAL, specification=ISO_19111)
    default double getMaximumValue() {
        return Double.POSITIVE_INFINITY;
    }

    /**
     * Returns the meaning of axis value range specified by the minimum and maximum values.
     * This element shall be omitted when both minimum and maximum values are omitted.
     * It may be included when minimum and/or maximum values are included.
     * If this element is omitted when minimum or maximum values are included, the meaning is unspecified.
     *
     * @return the range meaning, or {@code null} in none.
     *
     * @see RangeMeaning#EXACT
     * @see RangeMeaning#WRAPAROUND
     */
    @UML(identifier="rangeMeaning", obligation=CONDITIONAL, specification=ISO_19111)
    default RangeMeaning getRangeMeaning() {
        return null;
    }
}
