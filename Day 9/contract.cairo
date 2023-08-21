
#[starknet::interface]
trait ISimpleStorage<TContractState> {
    fn set(ref self: TContractState, x: u128);
    fn get(self: @TContractState) -> u128;
}

#[starknet::contract]
mod SimpleStorage {

    #[storage]
    struct Storage {
        stored_data: u128
    }

    #[init]
    fn init() -> Storage {
        Storage { stored_data: 0,  }
    }

    #[event]
    struct NumberSet {
        value: u128, 
    }

    #[external]
    impl SimpleStorage of super::ISimpleStorage<ContractState> {
        fn set(ref self: ContractState, x: u128) {
            self.stored_data.write(x);
            NumberSet { value: x,  }.emit();
        }
        fn get(self: @ContractState) -> u128 {
            self.stored_data.read()
        }
    }

}

