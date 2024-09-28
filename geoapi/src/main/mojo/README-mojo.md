# GeoAPI - Mojo🔥
**NOTE**: Mojo🔥 is still a very young language and is still missing some key parts, noteably basic Date and Time functionality (as of 2024-08-17). Please **do not use this library for production** environments and be aware that *it is subject to frequent **breaking** changes*.

## Mojo Specific Notable Points
**Noted key missing data types** from Mojo:
- datatime

The Mojo implementaiton primarily takes advantage of `trait`s and `struct`s.

### Workaround for current inability to specify a function returns any type that implements a certain `trait`:
```mojo
trait CustomTrait():
     fn function_one(self):
         ...

trait CustomTraitCollection(CollectionElement, CustomTrait):
     """
     Abstract collection element conforming to the CustomTrait trait.
     """
     ...

trait CustomTraitTwo():
     fn function_two[ElementType: CustomTraitCollection](self) -> Tuple[ElementType]:
         ...
```

## Python to Mojo Refactoring TODO
- [x] Make sure [Mojo Style Guide](https://github.com/modularml/mojo/blob/nightly/stdlib/docs/style-guide.md) is followed
    - [x] Package
    - [x] Subpackages
    - [x] Modules
    - [x] Traits
    - [x] Structs
    - [x] Aliases
    - [x] functions
    - [x] parameter names (T -> ElementType)
    - [ ] [docstrings](https://github.com/modularml/mojo/blob/nightly/stdlib/docs/docstring-style-guide.md)
        - [x] Remove \n immediately after opening docstring quotes
        - [x] Add missing docstrings
        - [ ] Add parameter types
        - [ ] Add return types
- [x] verify all `traits` an `structs` up to date
- [x] add `Optional` imports
- [x] change `Sequence` to `Tuple`
- [x] add ...
- [ ] add code header comments
- [ ] add custom CollectionElements for types in `Tuple`
- [ ] Replace `AnyType` with a specific type where able
- [ ] add datetime package from [forge-tools](https://github.com/martinvuyk/forge-tools)
- remove recursive references
    - [ ] GenericName.parsedName : Sequence<LocalName>
        - but LocalName is a descendent ot GenericName, so it creates a recursive reference to the declaration
    - [ ] Source: Recursive declaration (SourceCollectionElement)

### Refactorization Completed
- [ ] geometry
    - [x] `__init__`
    - [ ] primitive
- [ ] metadata
    - [x] `__init__`
    - [ ] acquisition
    - [ ] base
    - [ ] citation
    - [ ] constraints
    - [ ] content
    - [ ] distribution
    - [ ] extension
    - [ ] extent
    - [ ] identification
    - [ ] lineage
    - [ ] maintenance
    - [ ] naming
    - [ ] quality
    - [ ] representation
    - [ ] service
- [ ] referencing
    - [x] `__init__`
    - [ ] common
    - [ ] coordinate
    - [ ] crs
    - [ ] cd
    - [ ] datum
    - [ ] operation
- [ ] util
    - [x] `__init__`
    - [ ] measure
 
## Specifications
### ISO Standards
- [ ] **19103**
- [ ] 19107
- [ ] 19108
- [ ] 19109
- [ ] 19111
- [ ] 19112
- [ ] 19115
- [ ] **19115-1:2014**
    - ***Start on Table B.18.1*** (PT_Locale related) then continue with addendums.
    - [ ] 19115-1 A1 (2018)
    - [ ] 19115-1 A2 (2020)
    - metadata.lineage
        - ProcessStep
- [x] 19115-2:2019
    - [x] 19115-2 A1 (2022)
    - modules
        - metadata.aquisition
        - metadata.lineage
        - metadata.representation
        - metadata.content
        - CodeLists
- [ ] 19115-3
- [ ] 19115-4
- [ ] 19157
### OGC Standards
- [ ] 01009
- [ ] Filter
- [ ] Moving Feature

## Library of `trait`s and `struct`s of `alias`es
- [ ] Add code documentation to indicate which functions are mandatory for ISO 19115-1:2014
- [ ] ***Replace Python `Sequence` type with Custom Trait Collection***
- [ ] reflect ISO inheritance patterns
- [x] __str__ overrides
    - [x] metadata.naming.LocalName
    - [x] metadata.naming.ScopedName
    - [x] metadata.naming.TypeName
    - [x] metadata.naming.MemberName
- [ ] `PT_Locale`
    - [x] ISO 639-2 codes as Mojo 🔥 `struct`
    - [ ] ISO 3166-1 country codes as Mojo 🔥 `struct`
    - [ ] IANA Character Sets as Mojo 🔥 `struct`
    - [ ] `metadata.InstrumentEventList.locale`
    - [ ] `metadata.base.Metadata`
        - [ ] default_locale
        - [ ] other_locale
    - [ ] `metadata.identification.DataIdentification`
        - [ ] default_locale
        - [ ] other_locale
- [ ] `PT_LocaleContainer` -> InternationalString
    - [ ] to_string(Locale)
- [ ] `URI`
    - [ ] `metadata.identification.KeywordClass.concept_identifier`
- [ ] Fix data types for units listed in ISO/TS 19103:2005
    - [ ] `UnitOfMeasure`
        - [ ] `metadata.quality.QuantitativeResult.value_unit`
    - [ ] `Direct Position`
        - [ ] `metadata.representation.GCP.geographic_coordinates`
    - [ ] `Distance`
        - [ ] `metadata.identification.Resolution`
            - [ ] distance
            - [ ] vertical
        - [ ] `metadata.lineage.NominalResolution`
            - [ ] scanning_resolution
            - [ ] ground_resolution
    - [ ] `Angle`
        - [ ] `metadata.identification.Resolution`
            - [ ] angular_distance
- [ ] `GM_Object`
     - [ ] `metadata.extent.BoundingPolygon`
        - [ ] polygon
- [ ] `GM_Point`
    - [ ] `metadata.representation.Georectified`
        - [ ] corner_points
        - [ ] cetre_point
- [ ] Recursive references
    - metadata.quality.Element.derived_element -> `CustomTraitCollection`[Element]
- [ ] Fix any circular import problems
- [ ] Fix data types for unannotated objects and attributes
- [ ] Add Mojo 🔥 mappings to [documentation](https://www.metanorma.org/author/ogc/)
    - src > main > metanorma
    - [ ] 7.1.3.1 Departures from ISO model
    - [ ] 7.2.1 Primitive types
        - [ ] LanguageCode
        - [ ] CharacterSetCode
    - [ ] 7.2.2 Date and Time mappings (ISO 19103:2015 §7.2.2 to 7.2.4)
        - Use [Martin Vuyk forge_tools.datetime](https://github.com/martinvuyk/forge-tools) until Mojo🔥 implements datetime package.
        - [ ] Date: **???**
        - [ ] Time: **???**
        - [ ] DateTime: **???**
        - [ ] TM_Duration: **???**
        - [ ] TM_PeriodDuration: **???**
        - [ ] TM_Primitive: **???**
        - [ ] Update documentation
    - [ ] 7.2.3 Collections  (ISO 19103:2015 §7.3)
    - [ ] 7.3.2 ReferenceSystem
        - MD_ReferenceSystem -> `referencing.crs.ReferenceSystem`
            - [ ] added
                - `reference_system_identifier`
                - `reference_system_type`
- [ ] Fix `referencing` subpackage to match ISO 19111 UML
    - [ ] Add ISO 19111:2019 updates
    - [ ] `datum.Datum` object
    - [ ] `operation` module
        - [ ] `MathTransform` vs. `Transform`
- [ ] Finish incomplete code documentation
    - [ ] Add missing `trait`, `struct`, `alias`, `function`, `parameter`, `argument`, `return type` descriptions with *examples*.
    - [ ] Add definition for each CodeList value in its corresponding Enum class.
    - [ ] Change references in docstrings from MD_SomeObject (e.g., GM_Object, SV_OperationMetadata) to the Mojo 🔥 object
