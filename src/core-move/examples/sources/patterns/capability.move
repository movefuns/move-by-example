// Copyright (c) 2022, MoveFunsDAO.
// SPDX-License-Identifier: Apache-2.0

module examples::capability {
    use std::signer;

    const ENotPublisher: u64 = 0;
    const ENotOwner: u64 = 1;

    struct OwnerCapability has key, store {}

    public entry fun init(sender: signer) {
        assert!(signer::address_of(&sender) == @examples, ENotPublisher);
        move_to(&sender, OwnerCapability {})
    }

    public fun grant_role_with_capability(_to: address, _cap: &OwnerCapability) {
        // grant role to address
    }

    public entry fun grant_role(sender: &signer, to: address) acquires OwnerCapability {
        assert!(exists<OwnerCapability>(signer::address_of(sender)), ENotOwner);
        let cap = borrow_global<OwnerCapability>(signer::address_of(sender));
        grant_role_with_capability(to, cap);
    }
}