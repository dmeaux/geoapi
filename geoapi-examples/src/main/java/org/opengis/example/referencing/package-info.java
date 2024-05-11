/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    This file is hereby placed into the Public Domain.
 *    This means anyone is free to do whatever they wish with this file.
 */

/**
 * Implementation of some interfaces from the {@link org.opengis.referencing} package.
 * In order to provide a simpler model, some classes in this package merge many distinct
 * GeoAPI concepts. For example, some existing projection libraries make no distinction between
 * <i>Coordinate System</i> (<abbr>CS</abbr>) and <i>Coordinate Reference System</i> (<abbr>CRS</abbr>).
 * This package follows this simplified model by providing a single class implementing both
 * the <abbr>CS</abbr> and <abbr>CRS</abbr> interfaces.
 *
 * <p>The following table lists the classes that implement more than one GeoAPI interface:</p>
 *
 * <blockquote><table class="ogc">
 * <caption>Example classes implementing two or more interfaces</caption>
 * <tr>
 * <th>Simple class</th>
 * <th colspan="2">Implements</th>
 * </tr><tr>
 * <td>{@link org.opengis.example.referencing.SimpleCRS}:</td>
 * <td>{@link org.opengis.referencing.crs.CoordinateReferenceSystem},</td>
 * <td>{@link org.opengis.referencing.cs.CoordinateSystem}</td>
 * </tr><tr>
 * <td>{@link org.opengis.example.referencing.SimpleDatum}:</td>
 * <td>{@link org.opengis.referencing.datum.GeodeticDatum},</td>
 * <td>{@link org.opengis.referencing.datum.Ellipsoid}</td>
 * </tr><tr>
 * <td>{@link org.opengis.example.referencing.SimpleTransform}:</td>
 * <td>{@link org.opengis.referencing.operation.CoordinateOperation},</td>
 * <td>{@link org.opengis.referencing.operation.MathTransform}</td>
 * </tr><tr>
 * <td>{@link org.opengis.example.metadata.SimpleCitation}:</td>
 * <td>{@link org.opengis.metadata.citation.Citation},</td>
 * <td>{@link org.opengis.util.InternationalString}</td>
 * </tr></table></blockquote>
 *
 * <p>Every classes in this package are hereby placed into the Public Domain.
 * This means anyone is free to do whatever they wish with those files.</p>
 */
package org.opengis.example.referencing;
