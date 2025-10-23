/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2018-2023 Open Geospatial Consortium, Inc.
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
package org.opengis.geoapi;

import java.net.URL;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import static org.junit.jupiter.api.Assertions.*;


/**
 * Base class of tests that may potentially generate source files (resources, Python, etc).
 * If the source file already exists, the test class verifies its content.
 * Otherwise (if the source file has been deleted), the test class regenerates it.
 *
 * @author  Martin Desruisseaux (Geomatys)
 * @version 3.1
 * @since   3.1
 */
public abstract class SourceGenerator {
    /**
     * Suffix of compiled class files.
     */
    static final String CLASS_SUFFIX = ".class";

    /**
     * The Maven {@code target} directory found by the last call to {@link #targetDirectory()}.
     */
    private static Path targetDirectory;

    /**
     * For subclass constructors.
     */
    protected SourceGenerator() {
    }

    /**
     * Finds the Maven module containing GeoAPI interfaces, then returns the {@code target/classes} directory of that module.
     * Only the Maven {@code target} directory containing the {@code Metadata} interface is searched; this is not necessarily
     * the full classpath (which is not desired anyway since we do not want to include pending interfaces and test classes).
     *
     * @return  the {@code geoapi/target/classes} directory (never null).
     */
    static synchronized Path targetDirectory() {
        Path dir = targetDirectory;
        if (dir == null) {
            // Use any class expected to exist in the target directory.
            dir = rootClassesDirectory(org.opengis.metadata.Metadata.class);
            Path parent = parent(dir, "classes");
            switch (parent.getFileName().toString()) {
                case "target": break;                       // Building with Maven - nothing to do.
                default: fail("Unexpected directory: " + dir);
            }
            assertTrue(Files.isDirectory(dir), "Not a directory.");
            targetDirectory = dir;
        }
        return dir;
    }

    /**
     * Returns the root of the directory containing the given class.
     * In a Maven build, this is the {@code target/classes} directory of the module containing the given class.
     *
     * @param  sample  any class in the module to find.
     * @return the root of the directory containing the given class.
     */
    private static Path rootClassesDirectory(final Class<?> sample) {
        final String pathname = sample.getCanonicalName();
        int s = pathname.lastIndexOf('.');
        String name = pathname.substring(s+1) + CLASS_SUFFIX;
        final URL url = sample.getResource(name);
        assertNotNull(url, "Class file not found.");
        Path dir;
        try {
            dir = Paths.get(url.toURI());
        } catch (URISyntaxException e) {
            fail("Cannot create a URI for the " + pathname + " class:\n" + e);
            return null;
        }
        for (;;) {                                                          // Break condition is in the middle of the loop.
            dir = parent(dir, name);
            if (s < 0) break;
            final int end = s;
            s = pathname.lastIndexOf('.', end - 1);
            name = pathname.substring(s+1, end);
        }
        return dir;
    }

    /**
     * Ensures that the given path has the given name, then returns its parent.
     *
     * @param  path      the path from which to get the parent directory.
     * @param  expected  the expected name of the given file.
     * @return the parent directory (never null).
     */
    private static Path parent(final Path path, final String expected) {
        assertEquals(expected, path.getFileName().toString(), "Unexpected file or directory name.");
        final Path parent = path.getParent();
        if (parent == null) {
            fail("Missing parent directory for " + path);
        }
        return parent;
    }

    /**
     * Returns the GeoAPI source directory for the given language. For example, if the given language is {@code "java"},
     * then this method returns the {@code "geoapi/src/main/java"} directory. An absolute path may be returned in order
     * to have a valid directory even if the default directory is not the root of the Maven project.
     *
     * @param  language {@code "java"}, {@code "python"} or {@code "resources"}.
     * @return the source directory for the given language.
     */
    protected static Path sourceDirectory(final String language) {
        Path dir = parent(targetDirectory(), "classes");
        dir = parent(dir, "target");
        assertEquals("geoapi", dir.getFileName().toString(), "Not the expected module.");
        dir = dir.resolve("src").resolve("main").resolve(language);
        assertTrue(Files.isDirectory(dir), "Not a directory.");
        return dir;
    }

    /**
     * Prints the given message to standard output stream.
     * This method is used instead of logging for reporting creation of new files.
     *
     * @param  message  the message to print.
     */
    @SuppressWarnings("UseOfSystemOutOrSystemErr")
    protected static void info(final String message) {
        System.out.println("[GeoAPI] " + message);
    }
}
