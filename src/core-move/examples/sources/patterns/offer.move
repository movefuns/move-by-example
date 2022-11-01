// Copyright (c) 2022, MoveFunsDAO.
// SPDX-License-Identifier: Apache-2.0

module examples::offer {
    use std::signer;

    const ENotPublisher: u64 = 0;
    const ENotOwner: u64 = 1;
    const ENotReceipt: u64 = 2;
    const ENotGrantor: u64 = 3;

    struct OwnerCapability has key, store {}

    struct AdminCapability has key, store {}

    struct Offer<T: key + store> has key, store {
        receipt: address,
        offer: T,
    }

    public entry fun init(sender: signer) {
        assert!(signer::address_of(&sender) == @examples, ENotPublisher);
        move_to(&sender, OwnerCapability {})
    }

    public fun grant_role_with_capability(to: address, _cap: &OwnerCapability): Offer<AdminCapability> {
        Offer<AdminCapability> {
            receipt: to,
            offer: AdminCapability {},
        }
    }

    /// The owner can grant the admin role to another address `to`
    public entry fun grant_role_offer(sender: &signer, to: address) acquires OwnerCapability {
        assert!(exists<OwnerCapability>(signer::address_of(sender)), ENotOwner);
        let cap = borrow_global<OwnerCapability>(signer::address_of(sender));
        let offer = grant_role_with_capability(to, cap);
        move_to<Offer<AdminCapability>>(sender, offer);
    }

    /// Entry function for `receiptor` to accept an offer from `grantor` and save it in their account.
    public entry fun accept_role(receiptor: &signer, grantor: address)
    acquires Offer {
        assert!(exists<Offer<AdminCapability>>(grantor), ENotGrantor);
        let Offer<AdminCapability> { receipt, offer: admin_cap } = move_from<Offer<AdminCapability>>(grantor);
        assert!(receipt == signer::address_of(receiptor), ENotReceipt);
        move_to<AdminCapability>(receiptor, admin_cap);
    }
}