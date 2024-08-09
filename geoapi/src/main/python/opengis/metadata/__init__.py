# ===-----------------------------------------------------------------------===
#    GeoAPI - Python interfaces (abstractions) for OGC/ISO standards
#    Copyright © 2013-2024 Open Geospatial Consortium, Inc.
#    http: //www.geoapi.org
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http: //www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
# ===-----------------------------------------------------------------------===
"""This is the metadata subpackage.

This subpackage contains geographic metadata structures derived from the
ISO 19115-1:2014 international standard.
"""

__author__ = "Martin Desruisseaux(Geomatys), David Meaux (Geomatys)"

abbreviated_terms = [
    {
        "abbreviation": "OCL",
        "term": "Object Constraint Language",
    },
    {
        "abbreviation": "OGC",
        "term": "Open Geospatial Consortium",
    },
    {
        "abbreviation": "UML",
        "term": "Unified Modelling Language",
    },
    {
        "abbreviation": "XML",
        "term": "Extensible Markup Language",
    },
]

abbreviated_terms_packages = [
    {
        "abbreviation": "CI",
        "term": "Citation",
        "stadard": "ISO 19115-1",
    },
    {
        "abbreviation": "DQ",
        "term": "Data Quality",
        "stadard": "ISO 19157",
    },
    {
        "abbreviation": "DS",
        "term": "Dataset",
        "stadard": "ISO 19115-1",
    },
    {
        "abbreviation": "EX",
        "term": "Extent",
        "stadard": "ISO 19115-1",
    },
    {
        "abbreviation": "FC",
        "term": "Feature Catalog",
        "stadard": "ISO 19110",
    },
    {
        "abbreviation": "GF",
        "term": "General Feature",
        "stadard": "ISO 19109",
    },
    {
        "abbreviation": "GM",
        "term": "Geometry",
        "stadard": "ISO 19107",
    },
    {
        "abbreviation": "LI",
        "term": "Lineage",
        "stadard": "ISO 19115-1",
    },
    {
        "abbreviation": "LE",
        "term": "Lineage Extended",
        "stadard": "ISO 19115-2",
    },
    {
        "abbreviation": "MD",
        "term": "Metadata",
        "stadard": "ISO 19115-1",
    },
    {
        "abbreviation": "PT",
        "term": "Polylinguistic text",
        "stadard": "ISO/TS 19103",
    },
    {
        "abbreviation": "RS",
        "term": "Reference System",
        "stadard": "ISO 19115-1",
    },
    {
        "abbreviation": "SC",
        "term": "Spatial Coordinates",
        "stadard": "ISO 19111",
    },
    {
        "abbreviation": "SV",
        "term": "Metadata for Services",
        "stadard": "ISO 19115-1",
    },
    {
        "abbreviation": "TM",
        "term": "Temporal",
        "stadard": "ISO 19108",
    },
]
