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
package org.opengis.referencing.datum;

import java.util.Map;
import java.util.Collection;
import java.time.temporal.Temporal;
import javax.measure.Unit;
import javax.measure.quantity.Angle;
import javax.measure.quantity.Length;
import org.opengis.util.GenericName;
import org.opengis.util.InternationalString;
import org.opengis.util.FactoryException;
import org.opengis.util.UnimplementedServiceException;
import org.opengis.referencing.IdentifiedObject;
import org.opengis.referencing.ObjectDomain;
import org.opengis.referencing.ObjectFactory;
import org.opengis.metadata.Identifier;
import org.opengis.metadata.quality.PositionalAccuracy;
import org.opengis.annotation.UML;

import static org.opengis.annotation.Specification.*;


/**
 * Builds up complex datum objects from simpler objects or values.
 * {@code DatumFactory} allows applications to make {@linkplain Datum datums}
 * that cannot be created by a {@link DatumAuthorityFactory}.
 * This factory is very flexible, whereas the authority factory is easier to use.
 * So {@link DatumAuthorityFactory} can be used to make "standard" datums,
 * and {@code DatumFactory} can be used to make "special" datums.
 *
 * <h2>Metadata</h2>
 * All factory methods expect metadata as <i>key</i>-<i>value</i> pairs in a {@code Map<String,?>} argument,
 * sometime followed by one or more arguments of specific types. As a general rule, the {@code Map<String,?>}
 * argument contains metadata having no incidence on the numerical results of coordinate operations,
 * while changes in the other arguments can cause changes in the numerical results.
 * The datum {@value org.opengis.referencing.IdentifiedObject#NAME_KEY}
 * and/or datum {@value org.opengis.referencing.IdentifiedObject#IDENTIFIERS_KEY}
 * are exceptions to this rule as they are often the only way to distinguish datum definitions or reference frames.
 *
 * <p>The standard keys for the {@code Map<String,?>} argument are listed in the {@link ObjectFactory} interface.
 * The following table lists the additional properties for datum definitions,
 * together with a reminder of some properties defined in {@code ObjectFactory}:</p>
 *
 * <table class="ogc">
 *   <caption>Keys for standard properties</caption>
 *   <tr>
 *     <th>Key</th>
 *     <th>Value type</th>
 *     <th>Alternative types</th>
 *     <th>Value returned by</th>
 *   </tr><tr>
 *     <td>{@value org.opengis.referencing.datum.Datum#ANCHOR_DEFINITION_KEY}</td>
 *     <td>{@link InternationalString}</td>
 *     <td>{@link String}</td>
 *     <td>{@link Datum#getAnchorDefinition()}</td>
 *   </tr><tr>
 *     <td>{@value org.opengis.referencing.datum.Datum#ANCHOR_EPOCH_KEY}</td>
 *     <td>{@link Temporal}</td>
 *     <td></td>
 *     <td>{@link Datum#getAnchorEpoch()}</td>
 *   </tr><tr>
 *     <td>{@value org.opengis.referencing.datum.Datum#PUBLICATION_DATE_KEY}</td>
 *     <td>{@link Temporal}</td>
 *     <td></td>
 *     <td>{@link Datum#getPublicationDate()}</td>
 *   </tr><tr>
 *     <td>{@value org.opengis.referencing.datum.Datum#CONVENTIONAL_RS_KEY}</td>
 *     <td>{@link IdentifiedObject}</td>
 *     <td></td>
 *     <td>{@link Datum#getConventionalRS()}</td>
 *   </tr><tr>
 *     <th colspan="4" class="hsep">Defined in parent interface (reminder)</th>
 *   </tr><tr>
 *     <td>{@value org.opengis.referencing.IdentifiedObject#NAME_KEY}</td>
 *     <td>{@link Identifier}</td>
 *     <td>{@link String}</td>
 *     <td>{@link IdentifiedObject#getName()}</td>
 *   </tr><tr>
 *     <td>{@value org.opengis.referencing.IdentifiedObject#ALIAS_KEY}</td>
 *     <td><code>{@linkplain GenericName}[]</code></td>
 *     <td>{@link GenericName}, {@link String} or <code>{@linkplain String}[]</code></td>
 *     <td>{@link IdentifiedObject#getAlias()}</td>
 *   </tr><tr>
 *     <td>{@value org.opengis.referencing.IdentifiedObject#IDENTIFIERS_KEY}</td>
 *     <td><code>{@linkplain Identifier}[]</code></td>
 *     <td>{@link Identifier}</td>
 *     <td>{@link IdentifiedObject#getIdentifiers()}</td>
 *   </tr><tr>
 *     <td>{@value org.opengis.referencing.IdentifiedObject#DOMAINS_KEY}</td>
 *     <td><code>{@linkplain ObjectDomain}[]</code></td>
 *     <td>{@link ObjectDomain}</td>
 *     <td>{@link IdentifiedObject#getDomains()}</td>
 *   </tr><tr>
 *     <td>{@value org.opengis.referencing.IdentifiedObject#REMARKS_KEY}</td>
 *     <td>{@link InternationalString}</td>
 *     <td>{@link String}</td>
 *     <td>{@link IdentifiedObject#getRemarks()}</td>
 *   </tr>
 * </table>
 *
 * <h2>Default methods</h2>
 * All {@code create(…)} methods in this interface are optional.
 * If a method is not overridden by the implementer,
 * the default is to throw an {@link UnimplementedServiceException}
 * with a message saying that the type or service is not supported.
 *
 * @author  OGC 01-009 (for abstract model and documentation)
 * @author  Martin Desruisseaux (IRD, Geomatys)
 * @author  Johann Sorel (Geomatys)
 * @version 4.0
 * @since   1.0
 *
 * @see org.opengis.referencing.cs.CSFactory
 * @see org.opengis.referencing.crs.CRSFactory
 * @see org.opengis.referencing.RegisterOperations#getFactory(Class)
 */
@UML(identifier="CS_CoordinateSystemFactory", specification=OGC_01009)
public interface DatumFactory extends ObjectFactory {
    /**
     * Creates an ellipsoid from radius values.
     * The {@code properties} map shall contain at least an entry for the {@value Ellipsoid#NAME_KEY} key.
     *
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @param  semiMajorAxis  equatorial radius in supplied linear units.
     * @param  semiMinorAxis  polar radius in supplied linear units.
     * @param  unit  linear units of ellipsoid axes.
     * @return the ellipsoid for the given properties.
     * @throws FactoryException if the object creation failed.
     */
    @UML(identifier="createEllipsoid", specification=OGC_01009)
    default Ellipsoid createEllipsoid(Map<String,?> properties,
                                      double        semiMajorAxis,
                                      double        semiMinorAxis,
                                      Unit<Length>  unit) throws FactoryException
    {
        throw new UnimplementedServiceException(this, Ellipsoid.class);
    }

    /**
     * Creates an ellipsoid from an major radius, and inverse flattening.
     * The {@code properties} map shall contain at least an entry for the {@value Ellipsoid#NAME_KEY} key.
     *
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @param  semiMajorAxis  equatorial radius in supplied linear units.
     * @param  inverseFlattening  eccentricity of ellipsoid.
     * @param  unit  linear units of major axis.
     * @return the ellipsoid for the given properties.
     * @throws FactoryException if the object creation failed.
     */
    @UML(identifier="createFlattenedSphere", specification=OGC_01009)
    default Ellipsoid createFlattenedSphere(Map<String,?> properties,
                                            double        semiMajorAxis,
                                            double        inverseFlattening,
                                            Unit<Length>  unit) throws FactoryException
    {
        throw new UnimplementedServiceException(this, Ellipsoid.class, "flattened");
    }

    /**
     * Creates a prime meridian, relative to Greenwich.
     * The {@code properties} map shall contain at least an entry for the {@value PrimeMeridian#NAME_KEY} key.
     *
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @param  longitude  longitude of prime meridian in supplied angular units East of Greenwich.
     * @param  unit  angular units of longitude.
     * @return the prime meridian for the given properties.
     * @throws FactoryException if the object creation failed.
     */
    @UML(identifier="createPrimeMeridian", specification=OGC_01009)
    default PrimeMeridian createPrimeMeridian(Map<String,?> properties,
                                              double        longitude,
                                              Unit<Angle>   unit) throws FactoryException
    {
        throw new UnimplementedServiceException(this, PrimeMeridian.class);
    }

    /**
     * Creates a static geodetic reference frame from ellipsoid and prime meridian.
     * The {@code properties} map shall contain at least an entry for the {@value Datum#NAME_KEY} key.
     *
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @param  ellipsoid  ellipsoid to use in new geodetic reference frame.
     * @param  primeMeridian  prime meridian to use in new geodetic reference frame.
     * @return the static datum for the given properties.
     * @throws FactoryException if the object creation failed.
     */
    @UML(identifier="createHorizontalDatum", specification=OGC_01009)
    default GeodeticDatum createGeodeticDatum(Map<String,?> properties,
                                              Ellipsoid     ellipsoid,
                                              PrimeMeridian primeMeridian) throws FactoryException
    {
        throw new UnimplementedServiceException(this, GeodeticDatum.class);
    }

    /**
     * Creates a dynamic geodetic reference frame from ellipsoid, prime meridian and frame reference epoch.
     * The {@code properties} map shall contain at least an entry for the {@value Datum#NAME_KEY} key.
     * The returned object shall implement the {@link DynamicReferenceFrame} interface.
     *
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @param  ellipsoid  ellipsoid to use in new geodetic reference frame.
     * @param  primeMeridian  prime meridian to use in new geodetic reference frame.
     * @param  epoch  the epoch to which the definition of the dynamic reference frame is referenced.
     * @return the dynamic datum for the given properties.
     * @throws FactoryException if the object creation failed.
     *
     * @since 3.1
     */
    default GeodeticDatum createGeodeticDatum(Map<String,?> properties,
                                              Ellipsoid     ellipsoid,
                                              PrimeMeridian primeMeridian,
                                              Temporal      epoch) throws FactoryException
    {
        throw new UnimplementedServiceException(this, GeodeticDatum.class);
    }

    /**
     * Creates a static vertical datum from an enumerated type value.
     * The {@code properties} map shall contain at least an entry for the {@value Datum#NAME_KEY} key.
     *
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @param  method  the realization method of this vertical datum, or {@code null} if unspecified.
     * @return the static datum for the given properties.
     * @throws FactoryException if the object creation failed.
     *
     * @since 3.1
     */
    @UML(identifier="createVerticalDatum", specification=OGC_01009)
    default VerticalDatum createVerticalDatum(Map<String,?> properties,
                                              RealizationMethod method) throws FactoryException
    {
        throw new UnimplementedServiceException(this, VerticalDatum.class);
    }

    /**
     * Creates a dynamic vertical datum from an enumerated type value and frame reference epoch.
     * The {@code properties} map shall contain at least an entry for the {@value Datum#NAME_KEY} key.
     * The returned object shall implement the {@link DynamicReferenceFrame} interface.
     *
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @param  method  the realization method of this vertical datum, or {@code null} if unspecified.
     * @param  epoch  the epoch to which the definition of the dynamic reference frame is referenced.
     * @return the dynamic datum for the given properties.
     * @throws FactoryException if the object creation failed.
     *
     * @since 3.1
     */
    default VerticalDatum createVerticalDatum(Map<String,?> properties,
                                              RealizationMethod method,
                                              Temporal epoch) throws FactoryException
    {
        throw new UnimplementedServiceException(this, VerticalDatum.class);
    }

    /**
     * Creates a temporal datum from a temporal origin.
     * The {@code properties} map shall contain at least an entry for the {@value Datum#NAME_KEY} key.
     *
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @param  origin  the date and time origin of this temporal datum.
     *         The {@link java.time.Instant} sub-type is recommended.
     * @return the datum for the given properties.
     * @throws FactoryException if the object creation failed.
     *
     * @since 3.1
     */
    default TemporalDatum createTemporalDatum(Map<String,?> properties, Temporal origin) throws FactoryException {
        throw new UnimplementedServiceException(this, TemporalDatum.class);
    }

    /**
     * Creates a parametric datum.
     * The {@code properties} map shall contain at least an entry for the {@value Datum#NAME_KEY} key.
     *
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @return the datum for the given properties.
     * @throws FactoryException if the object creation failed.
     *
     * @since 3.1
     */
    default ParametricDatum createParametricDatum(Map<String,?> properties) throws FactoryException {
        throw new UnimplementedServiceException(this, ParametricDatum.class);
    }

    /**
     * Creates an engineering datum.
     * The {@code properties} map shall contain at least an entry for the {@value Datum#NAME_KEY} key.
     *
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @return the datum for the given properties.
     * @throws FactoryException if the object creation failed.
     */
    @UML(identifier="createLocalDatum", specification=OGC_01009)
    default EngineeringDatum createEngineeringDatum(Map<String,?> properties) throws FactoryException {
        throw new UnimplementedServiceException(this, EngineeringDatum.class);
    }

    /**
     * Creates a datum ensemble from a collection of members and an ensemble accuracy.
     * The {@code properties} map shall contain at least an entry for the {@value DatumEnsemble#NAME_KEY} key.
     *
     * @param  <D>         the type of datum contained in the ensemble.
     * @param  properties  name and other properties to give to the new object.
     *         Available properties are {@linkplain ObjectFactory listed there}.
     * @param  members     datum or reference frames which are members of the datum ensemble.
     * @param  accuracy    inaccuracy introduced through use of the given collection of datums.
     * @return the datum ensemble for the given properties.
     * @throws FactoryException if the object creation failed.
     *
     * @since 3.1
     */
    default <D extends Datum> DatumEnsemble<D> createDatumEnsemble(Map<String,?> properties,
            Collection<? extends D> members, PositionalAccuracy accuracy) throws FactoryException
    {
        throw new UnimplementedServiceException(this, DatumEnsemble.class);
    }
}
