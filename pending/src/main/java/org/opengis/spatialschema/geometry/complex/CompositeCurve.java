/*$************************************************************************************************
 **
 ** $Id$
 **
 ** $Source$
 **
 ** Copyright (C) 2003-2005 Open GIS Consortium, Inc.
 ** All Rights Reserved. http://www.opengis.org/legal/
 **
 *************************************************************************************************/
package org.opengis.spatialschema.geometry.complex;

// J2SE direct dependencies
import java.util.List;

// OpenGIS direct dependencies
import org.opengis.spatialschema.geometry.primitive.OrientableCurve;

// Annotations
import org.opengis.annotation.UML;
import static org.opengis.annotation.Obligation.*;
import static org.opengis.annotation.Specification.*;


/**
 * A {@linkplain Complex complex} with all the geometric properties of a curve. Thus, this
 * composite can be considered as a type of {@linkplain OrientableCurve orientable curve}.
 * Essentially, a composite curve is a list of {@linkplain OrientableCurve orientable curves}
 * agreeing in orientation in a manner such that each curve (except the first) begins where
 * the previous one ends.
 *
 * @version <A HREF="http://www.opengis.org/docs/01-101.pdf">Abstract specification 5</A>
 * @author Martin Desruisseaux (IRD)
 * @since GeoAPI 1.0
 *
 * @todo This interface extends (indirectly) both {@link org.opengis.spatialschema.geometry.primitive.Primitive} and
 *       {@link org.opengis.spatialschema.geometry.complex.Complex}. Concequently, there is a clash in the semantics
 *       of some set theoretic operation. Specifically, {@code Primitive.contains(...)}
 *       (returns FALSE for end points) is different from {@code Complex.contains(...)}
 *       (returns TRUE for end points).
 */
@UML(identifier="GM_CompositeCurve", specification=ISO_19107)
public interface CompositeCurve extends Composite, OrientableCurve {
    /**
     * Returns the list of orientable curves in this composite.
     *
     * To get a full representation of the elements in the {@linkplain Complex complex},
     * the {@linkplain org.opengis.spatialschema.geometry.primitive.Point points} on the boundary of the
     * generator set of {@linkplain org.opengis.spatialschema.geometry.primitive.Curve curve} would be
     * added to the curves in the generator list.
     *
     * @return The list of orientable curves in this composite.
     */
    @UML(identifier="generator", obligation=MANDATORY, specification=ISO_19107)
    public List<OrientableCurve> getGenerators();
}
