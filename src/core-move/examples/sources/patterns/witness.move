// Copyright (c) 2022, MoveFunsDAO.
// SPDX-License-Identifier: Apache-2.0

module examples::framework {

    /// Phantom parameter T can only be initialized in the `create_guardian`
    /// function. But the types passed here must have `drop`.
    struct Coin<phantom T: drop> has key, store {
        value: u128,
    }

    /// The first argument of this function is an actual instance of the
    /// type T with `drop` ability. It is dropped as soon as received.
    public fun publish_coin<T: drop>(_witness: T) {
        // register this coin to the registry table
    }
}

/// Custom module that makes use of the `guardian`.
module examples::xcoin {

    // Use the `guardian` as a dependency.
    use examples::framework;

    struct X has drop {}

    /// Only this module defined X can call framework::publish_coin<X>
    public fun publish() {
        framework::publish_coin<X>(X {});
    }
}
