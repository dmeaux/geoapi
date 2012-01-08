/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    http://www.geoapi.org
 *
 *    This file is hereby placed into the Public Domain.
 *    This means anyone is free to do whatever they wish with this file.
 */
package org.opengis.example.parameter;

import java.util.Set;
import java.net.URI;

import javax.measure.converter.ConversionException;
import javax.measure.unit.NonSI;
import javax.measure.unit.SI;
import javax.measure.unit.Unit;

import org.opengis.metadata.citation.Citation;
import org.opengis.parameter.InvalidParameterValueException;
import org.opengis.parameter.InvalidParameterTypeException;
import org.opengis.parameter.ParameterDescriptor;
import org.opengis.parameter.ParameterValue;

import org.opengis.example.referencing.SimpleIdentifiedObject;


/**
 * A relatively "simple" implementation of a parameter value for {@code double} values.
 * In order to keep the conceptual model simpler, this parameter value is also its own
 * descriptor. This is not quite a recommended practice (such descriptors are less suitable
 * for use in {@link java.util.HashMap}), but allow us to keep the amount of classes smaller
 * and closely related interfaces together.
 * <p>
 * For keeping things yet simpler, the {@linkplain #getValueClass() value class} is hard-coded as
 * {@link Double}, the {@linkplain #getUnit() units of measurement} are constrained to standard
 * units (metres, decimal degrees or dimensionless) and we care only about descriptor properties
 * ({@linkplain #getMinimumValue() minimum}, {@linkplain #getMaximumValue() maximum}, <i>etc.</i>)
 * determined by our own {@link Type} enumeration. The only mutable property in this class is the
 * numerical {@linkplain #value}.
 * <p>
 * The most interesting methods in this class are:
 * <p>
 * <ul>
 *   <li>{@link #getName()}, for the name of this parameter</li>
 *   <li>{@link #getUnit()}, for the unit of measurement.</li>
 *   <li>{@link #getMinimumValue()} and {@link #getMaximumValue()}, for the range of valid values</li>
 *   <li>{@link #getValue()}, {@link #doubleValue()} and {@link #doubleValue(Unit)}, for the actual parameter value</li>
 *   <li>{@link #setValue(double)}, {@link #setValue(double, Unit)} and {@link #setValue(Object)}, for setting the parameter value</li>
 * </ul>
 * <p>
 * Other methods can be ignored, since they are metadata or methods designed for parameter values
 * of other kind than {@code double}. To be strict, all methods working with any value type other
 * than {@code double} should throw an {@link InvalidParameterTypeException}. However this
 * implementation is {@linkplain #LENIENT lenient}.
 *
 * @author  Martin Desruisseaux (Geomatys)
 * @version 3.1
 * @since   3.1
 */
public class SimpleParameter extends SimpleIdentifiedObject implements Parameter<Double>, Cloneable {
    /**
     * Determines the range of values and the unit of measurement of a parameter.
     * This enum is stored in the {@link SimpleParameter#type} field, and used in
     * order to determine the values returned by the methods implementing the
     * {@link ParameterDescriptor} interface.
     *
     * @author  Martin Desruisseaux (Geomatys)
     * @version 3.1
     * @since   3.1
     */
    public static enum Type {
        /**
         * Longitude as decimal degrees in the [-180° &hellip; +180°] range.
         */
        LONGITUDE(NonSI.DEGREE_ANGLE, -180.0, +180.0),

        /**
         * Latitude as decimal degrees in the [-90° &hellip; +90°] range.
         */
        LATITUDE(NonSI.DEGREE_ANGLE, -90.0, +90.0),

        /**
         * Any linear value as metres, unbounded.
         */
        LINEAR(SI.METRE, null, null),

        /**
         * Length as metres in the [0 &hellip; &infin;] range.
         */
        LENGTH(SI.METRE, 0.0, null),

        /**
         * Scale as dimensionless number in the [0 &hellip; &infin;] range.
         */
        SCALE(Unit.ONE, LENGTH.minimum, null);

        /** Value to be returned by {@link SimpleParameter#getUnit()}. */
        final Unit<?> unit;

        /** Value to be returned by {@link SimpleParameter}. */
        final Double minimum, maximum;

        /** Creates a new enum with the given unit of measurement and range of values. */
        private Type(final Unit<?> unit, final Double minimum, final Double maximum) {
            this.unit    = unit;
            this.minimum = minimum;
            this.maximum = maximum;
        }
    }

    /**
     * For cross-version compatibility.
     */
    private static final long serialVersionUID = -127301955366750847L;

    /**
     * Controls whatever this implementation can convert values between the {@code double} type
     * and other types. If {@code false}, methods {@link #intValue()}, {@link #intValueList()},
     * {@link #doubleValueList()}, {@link #booleanValue()} and {@link #stringValue()} - together
     * with their setter companions - will always throw an {@link InvalidParameterTypeException}.
     * If {@code true}, some conversions will be attempted.
     * <p>
     * This field is defined for two purposes:
     * <ul>
     *   <li>Developers may find convenient to set this field to {@code false} during debugging,
     *       since strict behavior often help to identify unexpected usage of parameters.</li>
     *   <li>This field make easy to spot the codes implementing a lenient behavior. Library
     *       implementors may want to remove such codes for making parameters definitively
     *       strict.</li>
     * </ul>
     * <p>
     * The current value is <code>{@value}</code>.
     */
    protected static final boolean LENIENT = true;

    /**
     * The parameter type, which determines the range of values and the unit of measurement.
     * This field can be {@code null} if the parameter type is none of the enumerated ones.
     */
    protected final Type type;

    /**
     * The parameter value. This is the only mutable property of the {@code SimpleParameter}
     * class.
     *
     * @see #doubleValue()
     * @see #setValue(double)
     */
    protected double value;

    /**
     * Creates a new parameter of the given authority and name.
     *
     * @param authority Organization responsible for definition of the parameter, or {@code null}.
     * @param name      The parameter name.
     * @param type      The parameter type, which determines the range of values and the unit of measurement.
     *                  This argument can be {@code null} if the parameter type is none of the enumerated ones.
     */
    public SimpleParameter(final Citation authority, final String name, final Type type) {
        super(authority, name);
        this.type = type;
    }

    /**
     * Returns the descriptor of the parameter value. Since this simple class implements both the
     * {@linkplain ParameterValue value} and the {@linkplain ParameterDescriptor descriptor}
     * interfaces, this method returns {@code this}. However more sophisticated libraries are
     * likely to return a different object.
     */
    @Override
    public ParameterDescriptor<Double> getDescriptor() {
        return this;
    }

    /**
     * Returns the minimum number of times that values for this parameter are required.
     * The default implementation returns 1, meaning that a value shall alway be supplied
     * (the {@link #getValue()} method never return {@code null}).
     */
    @Override
    public int getMinimumOccurs() {
        return 1;
    }

    /**
     * Returns the maximum number of times that values for this parameter can be included.
     * This method unconditionally returns 1, which is the mandatory value for
     * {@link ParameterValue} implementations.
     */
    @Override
    public int getMaximumOccurs() {
        return 1;
    }

    /**
     * Unconditionally returns {@code Double.class}, which is the hard-coded type of values
     * in this parameter implementation.
     */
    @Override
    public Class<Double> getValueClass() {
        return Double.class;
    }

    /**
     * Returns the unit of measurement. Because this class implements both the <cite>value</cite>
     * and <cite>descriptor</cite> interfaces, the unit of measurement applies to the
     * {@linkplain #doubleValue() parameter value} as well as the {@linkplain #getDefaultValue default},
     * the {@linkplain #getMinimumValue minimum} and the {@linkplain #getMaximumValue maximum} values.
     *
     * @return The unit of measurement, or {@code null} if unknown.
     */
    @Override
    public Unit<?> getUnit() {
        return (type != null) ? type.unit : null;
    }

    /**
     * Returns the minimum parameter value, or {@code null} if none.
     * The default implementation infers this property from the {@linkplain #type}.
     *
     * @return The minimum parameter value, or {@code null} if unbounded.
     */
    @Override
    public Comparable<Double> getMinimumValue() {
        return (type != null) ? type.minimum : null;
    }

    /**
     * Returns the maximum parameter value, or {@code null} if none.
     * The default implementation infers this property from the {@linkplain #type}.
     *
     * @return The maximum parameter value, or {@code null} if unbounded.
     */
    @Override
    public Comparable<Double> getMaximumValue() {
        return (type != null) ? type.maximum : null;
    }

    /**
     * Returns the set of allowed values when these are restricted to some finite set or returns
     * {@code null} otherwise. The default implementation unconditionally returns {@code null}.
     */
    @Override
    public Set<Double> getValidValues() {
        return null;
    }

    /**
     * Returns the default value for the parameter.
     * The default implementation unconditionally returns {@code null}.
     */
    @Override
    public Double getDefaultValue() {
        return null;
    }

    /**
     * Returns the parameter {@linkplain #value} as an object.
     *
     * @return The parameter value as an object.
     */
    @Override
    public Double getValue() {
        return value;
    }

    /**
     * Returns the numeric {@linkplain #value} represented by this parameter.
     *
     * @return The numeric value represented by this parameter.
     */
    @Override
    public double doubleValue() {
        return value;
    }

    /**
     * Returns the numeric value of the operation parameter in the specified unit of measure.
     * This convenience method applies unit conversion on the fly as needed.
     *
     * @param  unit The unit of measure for the value to be returned.
     * @return The numeric value represented by this parameter after conversion to {@code unit}.
     * @throws IllegalArgumentException if the specified unit is invalid for this parameter.
     * @throws IllegalStateException if there is no unit associated to this parameter value.
     */
    @Override
    public double doubleValue(final Unit<?> unit) throws IllegalArgumentException, IllegalStateException {
        if (type == null) {
            throw new IllegalStateException("No unit for parameter " + code + '.');
        }
        try {
            return type.unit.getConverterToAny(unit).convert(value);
        } catch (ConversionException e) {
            throw new IllegalArgumentException(e);
        }
    }

    /**
     * Returns the integer value of an operation parameter, usually used for a count.
     * If {@linkplain #LENIENT lenient}, this method returns the {@linkplain #value}
     * casted to the {@code int} type only if this cast can be done without lost of
     * information. In all other cases an exception is thrown.
     *
     * @return The numeric value represented by this parameter after conversion to type {@code int}.
     * @throws InvalidParameterTypeException if the value can not be casted to an integer type.
     */
    @Override
    public int intValue() throws InvalidParameterTypeException {
        if (LENIENT) {
            final int candidate = (int) value;
            if (candidate == value) {
                return candidate;
            }
        }
        throw new InvalidParameterTypeException("Value " + value + " is not an integer.", code);
    }

    /**
     * Returns the boolean value of an operation parameter.
     * If {@linkplain #LENIENT lenient}, this method makes the following choice:
     * <p>
     * <ul>
     *   <li>Returns {@code false} if the {@linkplain #value} is 0</li>
     *   <li>Returns {@code true} if the {@linkplain #value} is 1</li>
     *   <li>Throws an exception in all other cases</li>
     * </ul>
     *
     * @return The boolean value represented by this parameter.
     * @throws InvalidParameterTypeException if the value can not be converted to a boolean.
     */
    @Override
    public boolean booleanValue() throws InvalidParameterTypeException {
        if (LENIENT) {
            if (value == 0) return false;
            if (value == 1) return true;
        }
        throw new InvalidParameterTypeException("Value " + value + " is not a boolean.", code);
    }

    /**
     * Returns the string representation of an operation parameter value.
     * If {@linkplain #LENIENT lenient}, this method formats the {@linkplain #value}
     * as a string and appends the units of measurement, if any.
     *
     * @return The numeric value and its units of measurement as a string.
     * @throws InvalidParameterTypeException if the value can not be converted to a string.
     *
     * @see #toString()
     */
    @Override
    public String stringValue() throws InvalidParameterTypeException {
        if (LENIENT) {
            String s = String.valueOf(value);
            if (type != null) {
                s = s + ' ' + type.unit;
            }
            return s;
        }
        throw new InvalidParameterTypeException("This parameter is not for strings.", code);
    }

    /**
     * Returns the string representation of this parameter value. The default implementation returns
     * the concatenation of the {@linkplain SimpleIdentifiedObject#toString() identifier string}, the
     * {@code " = "} string, then the same string than the {@linkplain #stringValue() string value}.
     *
     * @see #stringValue()
     */
    @Override
    public String toString() {
        final StringBuilder buffer = new StringBuilder(super.toString()).append(" = ").append(value);
        if (type != null) {
            buffer.append(' ').append(type.unit);
        }
        return buffer.toString();
    }

    /**
     * Returns an ordered sequence of numeric values in the specified unit of measure.
     * If {@linkplain #LENIENT lenient}, this method returns {@link #doubleValue(Unit)}
     * in an array of length 1.
     *
     * @throws IllegalArgumentException if the specified unit is invalid for this parameter.
     * @throws IllegalStateException if there is no unit associated to this parameter value.
     * @throws InvalidParameterTypeException if the value can not be converted to an array.
     */
    @Override
    public double[] doubleValueList(final Unit<?> unit) throws IllegalArgumentException, IllegalStateException {
        if (LENIENT) {
            return new double[] {doubleValue(unit)};
        }
        throw new InvalidParameterTypeException("This parameter is not for arrays.", code);
    }

    /**
     * Returns an ordered sequence numeric values of an operation parameter list, where each value
     * has the same associated {@linkplain Unit unit of measure}. If {@linkplain #LENIENT lenient},
     * this method returns {@link #doubleValue()} in an array of length 1.
     *
     * @return The sequence of values represented by this parameter.
     * @throws InvalidParameterTypeException if the value can not be converted to an array.
     */
    @Override
    public double[] doubleValueList() throws InvalidParameterTypeException {
        if (LENIENT) {
            return new double[] {doubleValue()};
        }
        throw new InvalidParameterTypeException("This parameter is not for arrays.", code);
    }

    /**
     * Returns an ordered sequence integer values of an operation parameter list.
     * If {@linkplain #LENIENT lenient}, this method returns {@link #intValue()}
     * in an array of length 1.
     *
     * @return The sequence of values represented by this parameter.
     * @throws InvalidParameterTypeException if the value can not be converted to an array.
     */
    @Override
    public int[] intValueList() throws InvalidParameterTypeException {
        if (LENIENT) {
            return new int[] {intValue()};
        }
        throw new InvalidParameterTypeException("This parameter is not for arrays.", code);
    }

    /**
     * Thrown unconditionally the exception, since this parameter implementation can not
     * represent URI.
     *
     * @return Never returned.
     * @throws InvalidParameterTypeException Always thrown.
     */
    @Override
    public URI valueFile() throws InvalidParameterTypeException {
        throw new InvalidParameterTypeException("This parameter is not for files.", code);
    }

    /**
     * Sets the parameter to the given value and its associated unit.
     * The default implementation converts the given value to the {@linkplain #getUnit()
     * units associated to this parameter}, then delegates to {@link #setValue(double)}.
     *
     * @param  value The parameter value.
     * @param  unit The unit for the specified value.
     * @throws InvalidParameterValueException if this parameter can not be set to the given value.
     */
    @Override
    public void setValue(final double value, final Unit<?> unit) throws InvalidParameterValueException {
        if (type == null) {
            throw new InvalidParameterValueException("No unit expected for parameter " + code, code, unit);
        }
        try {
            setValue(unit.getConverterToAny(type.unit).convert(value));
        } catch (ConversionException e) {
            throw new InvalidParameterValueException(e.getLocalizedMessage(), code, unit);
        }
    }

    /**
     * Sets the parameter value as a floating point. This method ensures that the given value
     * is inside the range of valid values, then assign the new value to the {@link #value}
     * field.
     *
     * @throws InvalidParameterValueException if the parameter value is out of range.
     */
    @Override
    public void setValue(final double value) throws InvalidParameterValueException {
        if (type != null) {
            Double limit = type.minimum;
            if (limit != null && value < limit) {
                throw new InvalidParameterValueException("Value " + value
                        + " shall be greater than or equals to " + limit, code, value);
            }
            limit = type.maximum;
            if (limit != null && value > limit) {
                throw new InvalidParameterValueException("Value " + value
                        + " shall be less than or equals to " + limit, code, value);
            }
        }
        this.value = value;
    }

    /**
     * Sets the parameter value as an array of floating point and their associated unit.
     * If {@linkplain #LENIENT lenient}, this method ensures that the array length is exactly 1,
     * then delegates to {@link #setValue(double, Unit)}.
     *
     * @param  values The parameter values.
     * @param  unit The unit for the specified values.
     * @throws InvalidParameterValueException if this parameter can not be set to the given value.
     */
    @Override
    public void setValue(final double[] values, final Unit<?> unit) throws InvalidParameterValueException {
        if (LENIENT && values.length == 1) {
            setValue(values[0], unit);
        } else {
            throw new InvalidParameterValueException("This parameter is not for arrays.", code, values);
        }
    }

    /**
     * Sets the parameter value as an integer. If {@linkplain #LENIENT lenient},
     * this method delegates to {@link #setValue(double)}.
     *
     * @throws InvalidParameterValueException if this parameter can not be set to the given value.
     */
    @Override
    public void setValue(final int value) throws InvalidParameterValueException {
        if (LENIENT) {
            setValue((double) value);
        } else {
            throw new InvalidParameterValueException("This parameter is not for integers.", code, value);
        }
    }

    /**
     * Sets the parameter value as a boolean. If {@linkplain #LENIENT lenient}, the boolean value
     * {@code true} is stored as the numeric value 1 and the boolean value {@code false} is stored
     * as the numeric value 0.
     *
     * @throws InvalidParameterValueException if this parameter can not be set to the given value.
     */
    @Override
    public void setValue(final boolean value) throws InvalidParameterValueException {
        if (LENIENT) {
            setValue(value ? 1 : 0);
        } else {
            throw new InvalidParameterValueException("This parameter is not for booleans.", code, value);
        }
    }

    /**
     * Sets the parameter value as an object. If {@linkplain #LENIENT lenient}, then the object
     * type can be any {@link Number} or {@link CharSequence} parseable as a floating point
     * number. If not lenient, then the type must be restricted to {@link Double}.
     *
     * @param  value The parameter value.
     * @throws InvalidParameterValueException if the value can not be stored as a {@code double}.
     */
    @Override
    public void setValue(final Object value) throws InvalidParameterValueException {
        final double number;
        try {
            if (!LENIENT) {
                number = ((Double) value).doubleValue();
            } else if (value instanceof CharSequence) {
                number = Double.parseDouble(value.toString());
            } else {
                number = ((Number) value).doubleValue();
            }
        } catch (NumberFormatException e) {
            // JDK7 developers would use multi-catch here.
            throw new InvalidParameterValueException(e.toString(), code, value);
        } catch (ClassCastException e) {
            throw new InvalidParameterValueException(e.toString(), code, value);
        }
        setValue(number);
    }

    /**
     * Returns a new parameter with the same {@linkplain #authority authority}, {@linkplain #code code}
     * and {@linkplain #type} than this parameter. The {@linkplain #value} is left to their default
     * value.
     *
     * <blockquote><font size="-1"><b>Implementation note:</b>
     * Since this simple class implements both the {@linkplain ParameterValue value} and the
     * {@linkplain ParameterDescriptor descriptor} interfaces, this method is very similar to
     * the {@link #clone()} method. However in more sophisticated libraries, the
     * {@linkplain ParameterDescriptor#createValue()} and {@link ParameterValue#clone()}
     * methods are likely to be defined in different objects.</font></blockquote>
     *
     * @see #clone()
     */
    @Override
    public SimpleParameter createValue() {
        return new SimpleParameter(authority, code, type);
    }

    /**
     * Returns a copy of this parameter value. This method is similar to {@link #createValue()}
     * except for the following:
     * <p>
     * <ul>
     *   <li>This method returns an instance of the same class.</li>
     *   <li>The {@linkplain #value} is initialized to the same value than the cloned parameter.</li>
     * </ul>
     *
     * @see #createValue()
     */
    @Override
    public SimpleParameter clone() {
        try {
            return (SimpleParameter) super.clone();
        } catch (CloneNotSupportedException e) {
            throw new AssertionError(e); // Should never happen, since we are cloneable.
        }
    }

    /**
     * Compares the given object with this parameter for equality.
     */
    @Override
    public boolean equals(final Object object) {
        if (super.equals(object)) {
            final SimpleParameter other = (SimpleParameter) object;
            return type == other.type && Double.doubleToLongBits(value) == Double.doubleToLongBits(other.value);
        }
        return false;
    }

    /**
     * Returns a hash code value for this parameter.
     */
    @Override
    public int hashCode() {
        long code = Double.doubleToLongBits(value);
        if (type != null) {
            code += 31 * type.hashCode();
        }
        return (int) code + (int) (code >>> Integer.SIZE) + 37*super.hashCode();
    }
}
