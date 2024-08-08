# Python "To Do" List
## OOP branch
- [x] Conform to PEP8; reflect ISO inheritance patterns
    - [x] geometry
        - [x] primitive
    - [x] metadata
        - [x] aquisition
        - [x] base
        - [x] citation
        - [x] constraints
        - [x] content
        - [x] distribution
        - [x] extension
        - [x] extent
        - [x] identification
        - [x] lineage
        - [x] maintenance
        - [x] naming
        - [x] quality
        - [x] representation
        - [x] service
    - [x] referencing
        - [x] crs
        - [x] cs
        - [x] datum
        - [x] operation
- [ ] Add Python mappings to [documentation](https://www.metanorma.org/author/ogc/)
    - src > main > metanorma
    - [ ] 7.1.3.1 Departures from ISO model
    - [ ] 7.2.1 Primitive types
        - [ ] LanguageCode
        - [ ] CharacterSetCode
    - [ ] 7.2.2 Date and Time mappings (ISO 19103:2015 §7.2.2 to 7.2.4)
        - [ ] Date
        - [ ] Time
        - [ ] Update documentation
    - [ ] 7.2.3 Collections  (ISO 19103:2015 §7.3)
- [ ] Fix `referencing` subpackage to match ISO 19111 UML
    - [ ] Add ISO 19111:2019 updates
    - [ ] `datum.Datum` object
    - [ ] `operation` module
        - [ ] `MathTransform` vs. `Transform`
- [ ] Deconflict `identification.Identifier` and `citation.Identifier`: `identification.Identifier` was actually `identification.Identification`
- [ ] Fix any circular import problems
- [ ] Rewrite classes to use composition in place of inheritance (ADFs?)
- [ ] Fix data types for unannotated objects and attributes
- [ ] Fix data types for units listed in ISO/TS 19103:2005
    - [ ] `metadata.quality.QuantitativeResult.value_unit`: `UnitOfMeasure`
- [ ] Add code documentation to indicate which attributes/properties/fields are mandatory for ISO 19115-1:2014
- [ ] Deal with minimum and maximum occurences of objects, as specified in in ISO standards
    - [ ] 0 or more
    - [ ] maximum length > 1?
- [ ] Finish incomplete code documentation
    - [ ] Add missing class and attribute descriptions
    - [ ] Add definition for each CodeList value.

## Functional branch
- [x] Convert GeopAPI classes to python dataclasses for functional programming style
- [x] Conform to PEP8; reflect ISO inheritance patterns
    - [x] geometry
        - [x] primitive
    - [x] metadata
        - [x] aquisition
        - [x] base
        - [x] citation
        - [x] constraints
        - [x] content
        - [x] distribution
        - [x] extension
        - [x] extent
        - [x] identification
        - [x] lineage
        - [x] maintenance
        - [x] naming
        - [x] quality
        - [x] representation
        - [x] service
    - [x] referencing
        - [x] crs
        - [x] cs
        - [x] datum
        - [x] operation
- [ ] Add Python mappings to [documentation](https://www.metanorma.org/author/ogc/)
    - src > main > metanorma
    - [ ] 7.1.3.1 Departures from ISO model
        - In the Python API composition has replaced inheritance to adopt a functional style of programming. The choice of a functional style of programming was adopted to facilitate distributed, parallel, and concurrent data processing, while minimizing.
    - [ ] 7.2.1 Primitive types
        - [ ] LanguageCode
        - [ ] CharacterSetCode
    - [ ] 7.2.2 Date and Time mappings (ISO 19103:2015 §7.2.2 to 7.2.4)
        - [ ] Date
        - [ ] Time
        - [ ] Update documentation
    - [ ] 7.2.3 Collections  (ISO 19103:2015 §7.3)
- [ ] Fix `referencing` subpackage to match ISO 19111 UML
    - [ ] Add ISO 19111:2019 updates
    - [ ] `datum.Datum` object
    - [ ] `operation` module
        - [ ] `MathTransform` vs. `Transform`
- [x] Deconflict `identification.Identifier` and `citation.Identifier`: `identification.Identifier` was actually `identification.Identification`
- [ ] Fix any circular import problems
- [ ] Rewrite classes to use composition in place of inheritance (ADFs?)
- [ ] Fix data types for unannotated objects and attributes
- [ ] Fix data types for units listed in ISO/TS 19103:2005
    - [ ] `metadata.quality.QuantitativeResult.value_unit`: `UnitOfMeasure`
- [ ] Add code documentation to indicate which attributes/properties/fields are mandatory for ISO 19115-1:2014
- [ ] Deal with minimum and maximum occurences of objects, as specified in in ISO standards
    - [ ] 0 or more
    ```python
    from dataclasses import dataclass
    from typing import Optional

    @dataclass
    class CampingEquipment:
        knife: bool
        fork: bool | None = None
        missing_flask_size: Optional[int] = None
    ```
    - [ ] maximum length > 1?
- [ ] Finish incomplete code documentation
    - [ ] Add missing class and attribute descriptions
    - [ ] Add definition for each CodeList value.
