/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    http://www.geoapi.org
 *
 *    Copyright (C) 2009-2017 Open Geospatial Consortium, Inc.
 *    All Rights Reserved. http://www.opengeospatial.org/ogc/legal
 *
 *    Permission to use, copy, and modify this software and its documentation, with
 *    or without modification, for any purpose and without fee or royalty is hereby
 *    granted, provided that you include the following on ALL copies of the software
 *    and documentation or portions thereof, including modifications, that you make:
 *
 *    1. The full text of this NOTICE in a location viewable to users of the
 *       redistributed or derivative work.
 *    2. Notice of any changes or modifications to the OGC files, including the
 *       date changes were made.
 *
 *    THIS SOFTWARE AND DOCUMENTATION IS PROVIDED "AS IS," AND COPYRIGHT HOLDERS MAKE
 *    NO REPRESENTATIONS OR WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 *    TO, WARRANTIES OF MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE OR THAT
 *    THE USE OF THE SOFTWARE OR DOCUMENTATION WILL NOT INFRINGE ANY THIRD PARTY
 *    PATENTS, COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS.
 *
 *    COPYRIGHT HOLDERS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL OR
 *    CONSEQUENTIAL DAMAGES ARISING OUT OF ANY USE OF THE SOFTWARE OR DOCUMENTATION.
 *
 *    The name and trademarks of copyright holders may NOT be used in advertising or
 *    publicity pertaining to the software without specific, written prior permission.
 *    Title to copyright in this software and any associated documentation will at all
 *    times remain with copyright holders.
 */
package org.opengis.tools.doclet;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.tools.Diagnostic;
import jdk.javadoc.doclet.Reporter;
import jdk.javadoc.doclet.Doclet.Option;
import jdk.javadoc.doclet.DocletEnvironment;
import jdk.javadoc.doclet.StandardDoclet;


/**
 * A doclet which delegates the work to the standard doclet, except for the {@code -stylesheet} option.
 * Rather than overwriting the standard stylesheet with the given one, this keep both the standard and
 * the specified stylesheets as separated files. The standard stylesheet will be renamed {@code standard.css}.
 * The stylesheet provided by the user shall contains an import statement for the standard stylesheet.
 *
 * <p>This class presumes that all CSS files are encoded in UTF-8.</p>
 *
 * <p><b>Source:</b> this class is a copy of Apache SIS doclet, relicensed to OGC by the Doclet author.</p>
 *
 * @author  Martin Desruisseaux (Geomatys)
 * @since   3.1
 * @version 3.1
 */
public final class Doclet extends StandardDoclet {
    /**
     * The name of the standard stylesheet file generated by Javadoc.
     */
    private static final String STYLESHEET = "stylesheet.css";

    /**
     * The name of the standard stylesheet after renaming by this doclet.
     */
    private static final String RENAMED_CSS = "standard.css";

    /**
     * The encoding to use for reading and writing CSS files.
     */
    private static final String ENCODING = "UTF-8";

    /**
     * The directory where HTML pages will be written.
     */
    private String outputDirectory;

    /**
     * Path to the stylesheet to copy.
     */
    private String stylesheetFile;

    /**
     * Where to report warnings, or {@code null} if unknown.
     */
    Reporter reporter;

    /**
     * Invoked by the Javadoc tools for instantiating the custom doclet.
     */
    public Doclet() {
    }

    /**
     * Returns a name identifying this doclet.
     *
     * @return "GeoAPI".
     */
    @Override
    public String getName() {
        return "GeoAPI";
    }

    /**
     * Invoked by the Javadoc tools for initializing the doclet.
     *
     * @param locale    the locale to use for formatting HTML content.
     * @param reporter  where to report warnings and errors.
     */
    @Override
    public void init(final Locale locale, final Reporter reporter) {
        super.init(locale, reporter);
        this.reporter = reporter;
    }

    /**
     * Forwards all method to the given option except {@link #process(String, List)},
     * which is first forwarded to {@link #define(String)}.
     */
    private static abstract class OptionWrapper implements Option {
        private final Option opt;
        OptionWrapper(final Option op) {opt = op;}
        protected abstract void define(String value);

        @Override public final int          getArgumentCount() {return opt.getArgumentCount();}
        @Override public final String       getDescription()   {return opt.getDescription();}
        @Override public final Option.Kind  getKind()          {return opt.getKind();}
        @Override public final List<String> getNames()         {return opt.getNames();}
        @Override public final String       getParameters()    {return opt.getParameters();}
        @Override public final boolean      process(String option, List<String> arguments) {
            define(arguments.get(0));
            return opt.process(option, arguments);
        }
    }

    /**
     * Returns the options supported by the standard doclet.
     *
     * @return all the supported options.
     */
    @Override
    public Set<Option> getSupportedOptions() {
        final Set<Option> options = new LinkedHashSet<>();
        for (Option op : super.getSupportedOptions()) {
            final List<String> names = op.getNames();
            if (names.contains("-d")) {
                op = new OptionWrapper(op) {
                    @Override protected void define(final String value) {
                        outputDirectory = value;
                    }
                };
            } else if (names.contains("-stylesheet") || names.contains("-stylesheetfile")) {
                op = new OptionWrapper(op) {
                    @Override protected void define(final String value) {
                        stylesheetFile = value;
                    }
                };
            }
            options.add(op);
        }
        return options;
    }

    /**
     * Invoked by Javadoc for starting the doclet.
     *
     * @param  environment  the Javadoc environment.
     * @return {@code true} on success, or {@code false} on failure.
     */
    @Override
    @SuppressWarnings("CallToPrintStackTrace")
    public boolean run(final DocletEnvironment environment) {
        final boolean status = super.run(environment);
        if (stylesheetFile != null && outputDirectory != null) try {
            final File input  = new File(stylesheetFile);
            final File output = new File(outputDirectory);
            copyStylesheet(input, output);
            copyResources(input.getParentFile(), output);
        } catch (IOException e) {
            if (reporter != null) {
                final StringWriter buffer = new StringWriter();
                final PrintWriter p = new PrintWriter(buffer);
                e.printStackTrace(p);
                reporter.print(Diagnostic.Kind.ERROR, buffer.toString());
            } else {
                e.printStackTrace();
            }
            return false;
        }
        return status;
    }

    /**
     * Opens a CSS file for reading.
     */
    private static BufferedReader openReader(final File file) throws IOException {
        return new BufferedReader(new InputStreamReader(new FileInputStream(file), ENCODING));
    }

    /**
     * Opens a CSS file for writing.
     */
    private static BufferedWriter openWriter(final File file) throws IOException {
        return new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), ENCODING));
    }

    /**
     * Copies the standard CSS file, then copies the custom CSS file.
     *
     * @param  inputFile        the standard CSS file generated by the standard doclet.
     * @param  outputDirectory  the directory where to copy the CSS file.
     * @throws IOException      if an error occurred while reading or writing.
     */
    private static void copyStylesheet(final File inputFile, final File outputDirectory) throws IOException {
        final File stylesheetFile = new File(outputDirectory, STYLESHEET);
        final File standardFile   = new File(outputDirectory, RENAMED_CSS);
        /*
         * Copy the standard CSS file, skipping the import of DejaVu font
         * since our custom CSS file does not use it.
         */
        BufferedReader in  = openReader(stylesheetFile);
        BufferedWriter out = openWriter(standardFile);
        try {
            String line;
            while ((line = in.readLine()) != null) {
                if (!line.equals("@import url('resources/fonts/dejavu.css');")) {
                    out.write(line);
                    out.newLine();
                }
            }
        } finally {
            out.close();
            in.close();
        }
        /*
         * Copy the custom CSS file, skipping comments for more compact file.
         */
        in  = openReader(inputFile);
        out = openWriter(stylesheetFile);
        try {
            String line;
            while ((line = in.readLine()) != null) {
                if (line.length() < 2 || line.charAt(1) != '*') {
                    out.write(line);
                    out.newLine();
                }
            }
        } finally {
            out.close();
            in.close();
        }
    }

    /**
     * Creates links to Javadoc resources in the top-level directory (not from "{@code doc-files}" subdirectories).
     * While the Maven documentation said that the "{@code src/main/javadoc}" directory is copied by default, or a
     * directory can be specified with {@code <javadocResourcesDirectory>}, I have been unable to make it work even
     * with absolute paths.
     *
     * @param  inputFile        the directory containing resources.
     * @param  outputDirectory  the directory where to copy the resource files.
     * @throws IOException      if an error occurred while reading or writing.
     */
    private static void copyResources(final File inputDirectory, final File outputDirectory) throws IOException {
        final File[] inputFiles = inputDirectory.listFiles((final File dir, final String name) ->
                !name.startsWith(".") &&
                !name.equals("README.txt") &&
                !name.equals("overview.html") &&
                !name.equals(STYLESHEET));
        final byte[] buffer = new byte[4096];
        for (final File input : inputFiles) {
            try (FileInputStream  in  = new FileInputStream(input);
                 FileOutputStream out = new FileOutputStream(new File(outputDirectory, input.getName())))
            {
                int c;
                while ((c = in.read(buffer)) >= 0) {
                    out.write(buffer, 0, c);
                }
            }
        }
    }
}
