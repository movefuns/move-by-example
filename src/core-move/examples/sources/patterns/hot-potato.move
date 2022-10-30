// Copyright (c) 2022, MoveFunsDAO.
// SPDX-License-Identifier: Apache-2.0

module examples::hot_potato {

    /// Without any capability, the `sender` can only call `consume_potato`.
    struct Potato {}

    /// When calling this function, the `sender` will receive a `Potato` object.
    /// The `sender` can do nothing with the `Potato` such as store, drop, except
    /// passing it to `consume_potato` function.
    public fun get_potato(_sender: &signer): Potato {
        Potato {}
    }

    public fun consume_potato(_sender: &signer, potato: Potato) {
        // do nothing
        let Potato {} = potato;
    }
}
