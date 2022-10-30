# Patterns

Move patterns are the best practice in Move smart contracts. They are widely used in Move, some of which can exist only in Move.

These patterns are closely related to the following Move language features:

- Resource oriented
  - Resource can only be stored, transfered, destroyed or dropped restricted to the abilities.
  - Resource can only be created, readed field, modified field in the module where it is defined.

- The global storage mechanism
  - The global storage can only be accessed through the `move_to`, `move_from`, `borrow_global`, `borrow_global_mut` functions.
  - Objects in the global storage can only be accessed in the module where it is defined.

- The ability feature
  - key: Allows the type to serve as a key for global storage operations.
  - store: Allows values of types with this ability to exist inside a struct in global storage.
  - copy: Allows values of types with this ability to be copied.
  - drop: Allows values of types with this ability to be popped/dropped.
