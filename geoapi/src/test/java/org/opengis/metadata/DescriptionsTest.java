/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2009-2024 Open Geospatial Consortium, Inc.
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
package org.opengis.metadata;

import java.util.Set;
import java.util.HashSet;
import java.util.Enumeration;
import java.util.ResourceBundle;
import java.util.Locale;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

import org.opengis.geoapi.Content;
import org.opengis.util.CodeList;
import org.opengis.annotation.UML;
import org.opengis.annotation.Specification;
import org.opengis.annotation.ResourceBundles;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;


/**
 * Tests the content of {@code Descriptions.properties} file.
 *
 * @author  Martin Desruisseaux (Geomatys)
 * @version 3.1
 * @since   2.3
 */
public final class DescriptionsTest {
    /**
     * Creates a new test case.
     */
    public DescriptionsTest() {
    }

    /**
     * {@return whether to test the given type}.
     *
     * @param  type  a class that may be tested.
     */
    private static boolean filter(final Class<?> type) {
        if (type.getName().startsWith("org.opengis.metadata.")) {
            // Exclude some types for which descriptions are still missing.
            // TODO - https://github.com/opengeospatial/geoapi/issues/24
            return (type != org.opengis.metadata.constraint.Releasability.class) &&
                   (type != org.opengis.metadata.content.AttributeGroup.class) &&
                   (type != org.opengis.metadata.content.FeatureTypeInfo.class) &&
                   (type != org.opengis.metadata.MetadataScope.class);
        }
        // Some additional types for which descriptions are provided.
        return (type == org.opengis.annotation.Obligation.class) ||
               (type == org.opengis.parameter.ParameterDirection.class) ||
               (type == org.opengis.referencing.ReferenceSystemType.class);
    }

    /**
     * Asserts that the given key exists in the given resource bundle.
     *
     * @param  resources   the resource from which to get an entry.
     * @param  identifier  entry to get from the resource.
     */
    private static void assertResourceExists(final ResourceBundle resources, final String identifier) {
        final String value = assertDoesNotThrow(() -> resources.getString(identifier), identifier);
        assertNotNull(identifier, value);
    }

    /**
     * Ensures that every metadata interfaces have a description, and that there is no extra definitions.
     * This test is theoretically locale-sensitive since we search for the resources in the current locale.
     * However, it should works for every locales since the English locale is used as a fallback.
     */
    @Test
    public void testAll() {
        final ResourceBundle resources = ResourceBundles.descriptions(null);
        /*
         * Get the set of keys. We will remove entries from this set as we found them.
         * When this test is finished, the set of keys should be empty.
         */
        final Set<String> keys = new HashSet<>();
        for (final Enumeration<String> e = resources.getKeys(); e.hasMoreElements();) {
            final String key = e.nextElement();
            assertTrue(keys.add(key), "Duplicated key");
        }
        for (final Class<?> type : Content.ALL.types()) {
            if (!filter(type)) continue;
            UML uml = type.getAnnotation(UML.class);
            assertNotNull(uml, "Missing UML annotation");
            final String classIdentifier = uml.identifier();
            if (Enum.class.isAssignableFrom(type)) {
                assertResourceExists(resources, classIdentifier);
                assertTrue(keys.remove(classIdentifier), classIdentifier);
                for (final Field code : type.getDeclaredFields()) {
                    uml = code.getAnnotation(UML.class);
                    if (uml != null) {
                        final String identifier = classIdentifier + '.' + uml.identifier();
                        assertResourceExists(resources, identifier);
                        assertTrue(keys.remove(identifier), identifier);
                    }
                }
            } else if (CodeList.class.isAssignableFrom(type)) {
                /*
                 * Check a code list and its fields. Note that the fields without UML
                 * annotation (for example serialVersionUID) must be ignored. We also
                 * need to ignore ISO 19115-2 code list items for now.
                 */
                if (uml.specification() == Specification.ISO_19115_2) {
                    // Resources for ISO 19115-2 code lists are not yet provided.
                    continue;
                }
                assertResourceExists(resources, classIdentifier);
                assertTrue(keys.remove(classIdentifier), classIdentifier);
                for (final Field code : type.getDeclaredFields()) {
                    if (code.isAnnotationPresent(Deprecated.class)) {
                        continue;                                       // Skip deprecated fields or methods.
                    }
                    uml = code.getAnnotation(UML.class);
                    if (uml != null) {
                        if (uml.specification() == Specification.ISO_19115_2) {
                            // Resources for ISO 19115-2 code lists are not yet provided.
                            continue;
                        }
                        if (uml.identifier().equals("8859part12")) {
                            // Special case: "A future ISO/IEC 8-bit single-byte coded graphic
                            // character set" declared in ISO 19115 but not yet in gmxCodelists.xml.
                            continue;
                        }
                        final String identifier = classIdentifier + '.' + uml.identifier();
                        assertResourceExists(resources, identifier);
                        assertTrue(keys.remove(identifier), identifier);
                    }
                }
            } else {
                /*
                 * Check a metadata interface and its methods. Note that a few methods are
                 * GeoAPI extensions without UML (e.g. explicit definition of hashCode()),
                 * which must be excluded.
                 */
                assertResourceExists(resources, classIdentifier);
                assertTrue(keys.remove(classIdentifier), classIdentifier);
                for (final Method method : type.getDeclaredMethods()) {
                    uml = method.getAnnotation(UML.class);
                    if (uml != null) {
                        final String identifier = classIdentifier + '.' + uml.identifier();
                        assertResourceExists(resources, identifier);
                        assertTrue(keys.remove(identifier), identifier);
                    }
                }
            }
        }
        assertTrue(keys.isEmpty(), () -> "Some keys do not map any class or method: " + keys);
    }

    /**
     * Tests the content of a few specific items in the English locale.
     */
    @Test
    public void testEnglish() {
        final ResourceBundle resources = ResourceBundles.descriptions(Locale.ENGLISH);
        assertEquals("Unique identifier for the resource. Example: Universal Product Code (UPC), National Stock Number (NSN).",
                resources.getString("CI_Citation.identifier"));
    }
}
