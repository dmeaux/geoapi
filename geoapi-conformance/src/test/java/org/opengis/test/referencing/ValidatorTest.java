/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2011-2024 Open Geospatial Consortium, Inc.
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
package org.opengis.test.referencing;

import java.util.List;
import java.util.ArrayList;
import org.opengis.referencing.cs.AxisDirection;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import static org.opengis.referencing.cs.AxisDirection.*;


/**
 * Tests {@link CSValidator} and {@link CRSValidator}.
 *
 * @author  Martin Desruisseaux (Geomatys)
 * @version 3.1
 * @since   2.2
 */
public final class ValidatorTest {
    /**
     * Creates a new test case.
     */
    public ValidatorTest() {
    }

    /**
     * Tests the content of the {@link CSValidator#ORIENTATIONS} array.
     * We expect orientations in the [0…360]° range.
     */
    @Test
    public void testOrientations() {
        final AxisDirection[] directions = new AxisDirection[] {
            NORTH, NORTH_NORTH_EAST, NORTH_EAST, EAST_NORTH_EAST,
            EAST,  EAST_SOUTH_EAST,  SOUTH_EAST, SOUTH_SOUTH_EAST,
            SOUTH, SOUTH_SOUTH_WEST, SOUTH_WEST, WEST_SOUTH_WEST,
            WEST,  WEST_NORTH_WEST,  NORTH_WEST, NORTH_NORTH_WEST,
            ROW_NEGATIVE, COLUMN_POSITIVE, ROW_POSITIVE, COLUMN_NEGATIVE,
            DISPLAY_UP, DISPLAY_RIGHT, DISPLAY_DOWN, DISPLAY_LEFT,
            FORWARD, STARBOARD, AFT, PORT
        };
        var type  = CSValidator.Space.GEOGRAPHIC;
        int value = 0;
        int step  = 1;
        for (final AxisDirection direction : directions) {
            final CSValidator.Orientation orientation = CSValidator.ORIENTATIONS[direction.ordinal()];
            assertNotNull(orientation, direction.toString());
            if (type != orientation.category) {
                assertEquals(16, value, "Expected orientations in the [0…360]° range.");
                type  = orientation.category;
                value = 0;
                step  = 4;
            }
            assertEquals(value, orientation.orientation, direction.toString());
            value += step;
        }
        assertEquals(16, value, "Expected orientations in the [0…360]° range.");
    }

    /**
     * Tests the {@link CSValidator#assertPerpendicularAxes(Iterable)} method.
     */
    @Test
    public void testAssertPerpendicularAxes() {
        final var directions = new ArrayList<>(List.of(
                NORTH, DISPLAY_DOWN, OTHER, WEST, DISPLAY_RIGHT, FUTURE));
        CSValidator.assertPerpendicularAxes(directions);
        assertTrue(directions.isEmpty(), "Collection is cleaned as a side effect of internal working.");
        directions.addAll(List.of(NORTH, DISPLAY_DOWN, OTHER, SOUTH_EAST, DISPLAY_RIGHT, FUTURE));
        try {
            CSValidator.assertPerpendicularAxes(directions);
            fail("Should have detected the non-perpendicular axes.");
        } catch (AssertionError e) {
            assertEquals(e.getMessage(), "Found an angle of 135.0° between axis directions NORTH and SOUTH_EAST.");
        }
    }

    /**
     * Tests the {@link CRSValidator#toLowerCase(String)} method.
     */
    @Test
    public void testLowerCase() {
        assertEquals(CRSValidator.toLowerCase("Geodetic latitude"), "geodetic latitude");
        assertEquals(CRSValidator.toLowerCase("Geocentric X"), "geocentric X");
    }
}
