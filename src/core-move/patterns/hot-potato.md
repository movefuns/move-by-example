# Hot Potato

Hot Potato is a name for a struct that has no abilities, hence it can only be packed and unpacked in its module. In this struct, you must call function B after function A in the case where function A returns a potato and function B consumes it.

```Move
{{#include ../examples/sources/patterns/hot-potato.move:4:}}
```