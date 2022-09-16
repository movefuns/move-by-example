// Copyright (c) 2022, MoveFunsDAO.
// SPDX-License-Identifier: Apache-2.0

module move_by_example::first_module {

    // public function can be invoked by other modules and scripts
    public fun add(x: u64, y: u64): u64 {
        add_impl(x, y)
    }

    // private function can only be invoked in this module
    fun add_impl(x: u64, y: u64): u64 {
        x + y
    }
}