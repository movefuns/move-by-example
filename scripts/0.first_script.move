script {
    // Import the debug module published at the named account address std.
    // The address of std is defined in Move.toml `[addresses]` section.
    use std::debug;
    use std::signer;
    use move_by_example::first_module;

    const ONE: u64 = 1;

    /// The main function can have any name (i.e., it need not be called main), 
    /// is the only function in a script block, can have any number of arguments, 
    /// and must not return a value. 
    fun main(sender: signer, x: u64) {
        let addr = signer::address_of(&sender);
        debug::print(&addr);
        let sum = first_module::add(x, ONE);
        debug::print(&sum);
    }
}