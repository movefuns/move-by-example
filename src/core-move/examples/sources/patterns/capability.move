// Copyright (c) 2022, MoveFunsDAO.
// SPDX-License-Identifier: Apache-2.0

module examples::capability {
    use std::signer;

    const ENotPublisher: u64 = 0;
    const ENotOwner: u64 = 1;

    struct OwnerCapability has key, store {}

    /// init and publish an OwnerCapability to the module owner.
    public entry fun init(sender: signer) {
        assert!(signer::address_of(&sender) == @examples, ENotPublisher);
        move_to(&sender, OwnerCapability {})
    }

    /// mint to `_to` with the OwnerCapability.
    public fun mint_with_capability(_amount: u64, _to: address, _cap: &OwnerCapability) {
        // mint and deposit to `_to`
    }

    /// mint entry function. Only signer with OwnerCapability can call this function.
    public entry fun mint(sender: &signer, to: address, amount: u64) acquires OwnerCapability {
        assert!(exists<OwnerCapability>(signer::address_of(sender)), ENotOwner);
        let cap = borrow_global<OwnerCapability>(signer::address_of(sender));
        mint_with_capability(amount, to, cap);
    }
}