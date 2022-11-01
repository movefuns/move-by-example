// Copyright (c) 2022, MoveFunsDAO.
// SPDX-License-Identifier: Apache-2.0

module examples::wrapper {
    use std::signer;
    use extensions::table::{Self, Table};

    const ENotPublisher: u64 = 0;
    const ENotOwner: u64 = 1;
    const ENotReceipt: u64 = 2;
    const ENotGrantor: u64 = 3;
    const EOfferExisted: u64 = 4;

    struct OwnerCapability has key, store {}

    struct AdminCapability has key, store {}

    /// The wrapper pattern.
    struct OfferStore<phantom T> has key, store {
        offers: Table<address, T>,
    }

    public entry fun init(sender: signer) {
        assert!(signer::address_of(&sender) == @examples, ENotPublisher);
        move_to(&sender, OwnerCapability {})
    }

    /// The owner can grant the admin role to another address `to`
    public entry fun grant_admin_offer(sender: &signer, to: address)
    acquires OfferStore {
        assert!(exists<OwnerCapability>(signer::address_of(sender)), ENotOwner);
        if (!exists<OfferStore<AdminCapability>>(signer::address_of(sender))) {
            move_to<OfferStore<AdminCapability>>(sender, OfferStore<AdminCapability> {
                offers: table::new(),
            });
        };

        let offer_store = borrow_global_mut<OfferStore<AdminCapability>>(signer::address_of(sender));
        assert!(!table::contains<address, AdminCapability>(&offer_store.offers, to), EOfferExisted);
        table::add(&mut offer_store.offers, to, AdminCapability {});
    }

    /// Entry function for `sender` to accept an offer from `grantor` and save it in their account.
    public entry fun accept_role(sender: &signer, grantor: address)
    acquires OfferStore {
        assert!(exists<OfferStore<AdminCapability>>(grantor), ENotGrantor);
        let to = signer::address_of(sender);
        let store = borrow_global_mut<OfferStore<AdminCapability>>(grantor);
        assert!(table::contains<address, AdminCapability>(&store.offers, to), EOfferExisted);
        let admin_cap = table::remove(&mut store.offers, to);
        move_to<AdminCapability>(sender, admin_cap);
    }
}