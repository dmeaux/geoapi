/*$************************************************************************************************
 **
 ** $Id$
 **
 ** $Source$
 **
 ** Copyright (C) 2004-2005 Open GIS Consortium, Inc.
 ** All Rights Reserved. http://www.opengis.org/legal/
 **
 *************************************************************************************************/
package org.opengis.metadata.spatial;

// J2SE directdependencies
import java.util.List;
import java.util.ArrayList;

// OpenGIS direct dependencies
import org.opengis.util.CodeList;

// Annotations
import org.opengis.annotation.UML;
import static org.opengis.annotation.Obligation.*;
import static org.opengis.annotation.Specification.*;


/**
 * Name of the dimension.
 *
 * @version <A HREF="http://www.opengis.org/docs/01-111.pdf">Abstract specification 5.0</A>
 * @author Martin Desruisseaux (IRD)
 * @since GeoAPI 2.0
 */
@UML(identifier="MD_DimensionNameTypeCode", specification=ISO_19115)
public final class DimensionNameType extends CodeList<DimensionNameType> {
    /**
     * Serial number for compatibility with different versions.
     */
    private static final long serialVersionUID = -8534729639298737965L;

    /**
     * List of all enumerations of this type.
     * Must be declared before any enum declaration.
     */
    private static final List<DimensionNameType> VALUES = new ArrayList<DimensionNameType>(8);

    /**
     * Ordinate (y) axis.
     */
    @UML(identifier="row", obligation=CONDITIONAL, specification=ISO_19115)
    public static final DimensionNameType ROW = new DimensionNameType("ROW");

    /**
     * Abscissa (x) axis.
     */
    @UML(identifier="column", obligation=CONDITIONAL, specification=ISO_19115)
    public static final DimensionNameType COLUMN = new DimensionNameType("COLUMN");

    /**
     * Vertical (z) axis.
     */
    @UML(identifier="vertical", obligation=CONDITIONAL, specification=ISO_19115)
    public static final DimensionNameType VERTICAL = new DimensionNameType("VERTICAL");

    /**
     * Along the direction of motion of the scan point
     */
    @UML(identifier="track", obligation=CONDITIONAL, specification=ISO_19115)
    public static final DimensionNameType TRACK = new DimensionNameType("TRACK");

    /**
     * Perpendicular to the direction of motion of the scan point.
     */
    @UML(identifier="crossTrack", obligation=CONDITIONAL, specification=ISO_19115)
    public static final DimensionNameType CROSS_TRACK = new DimensionNameType("CROSS_TRACK");

    /**
     * Scan line of a sensor.
     */
    @UML(identifier="line", obligation=CONDITIONAL, specification=ISO_19115)
    public static final DimensionNameType LINE = new DimensionNameType("LINE");

    /**
     * Element along a scan line.
     */
    @UML(identifier="sample", obligation=CONDITIONAL, specification=ISO_19115)
    public static final DimensionNameType SAMPLE = new DimensionNameType("SAMPLE");

    /**
     * Duration.
     */
    @UML(identifier="time", obligation=CONDITIONAL, specification=ISO_19115)
    public static final DimensionNameType TIME = new DimensionNameType("TIME");

    /**
     * Constructs an enum with the given name. The new enum is
     * automatically added to the list returned by {@link #values}.
     *
     * @param name The enum name. This name must not be in use by an other enum of this type.
     */
    public DimensionNameType(final String name) {
        super(name, VALUES);
    }

    /**
     * Returns the list of {@code DimensionNameType}s.
     */
    public static DimensionNameType[] values() {
        synchronized (VALUES) {
            return (DimensionNameType[]) VALUES.toArray(new DimensionNameType[VALUES.size()]);
        }
    }

    /**
     * Returns the list of enumerations of the same kind than this enum.
     */
    public /*{DimensionNameType}*/ CodeList[] family() {
        return values();
    }
}
