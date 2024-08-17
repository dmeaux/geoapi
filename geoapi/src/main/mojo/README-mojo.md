# GeoAPI - Mojo🔥
**NOTE**: Mojo🔥 is still a very young language and is still missing some key parts, noteably basic Date and Time functionality (as of 2024-08-17). Please **do not use this library for production** environments and be aware that *it is subject to frequent **breaking** changes*.

## Issues to discuss with GeoAPI committee:
- [ ] GenericName.parsedName : Sequence<LocalName>
    - but LocalName is a descendent ot GenericName, so it creates a recursive reference to the declaration
- [ ] Source: Recursive declaration (SourceCollectionElement)
 
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
     fn function_two[T: CustomTraitCollection](self) -> Tuple[T]:
         ...
```
