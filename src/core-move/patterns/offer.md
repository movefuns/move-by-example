# Offer

The `Offer` pattern is used to transfer new objects to others, such as capability delegation, etc. 

This pattern is intraoduced because the restriction that in Move, `move_to` requires a `signer`, which means that an account cannot directly send an object to another account. So we need to use the `Offer` pattern to achieve this.

```move
{{#include ../examples/sources/patterns/offer.move:4:}}
```