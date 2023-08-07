use debug::PrintTrait;
use array::ArrayTrait;
use box::BoxTrait;

// Creating the Data enum
#[derive(Copy, Drop)]
enum Data {
    Integer: u128,
    Felt: felt252,
    Tuple: (u32, u32),
}

fn main() {
    let mut data_array: Array<Data> = ArrayTrait::new();
    // Appending different Data enum
    data_array.append(Data::Felt('hello'));
    data_array.append(Data::Tuple((9, 4))); // 2
    data_array.append(Data::Integer(3)); // Index 0

    // Get the array len and use it to read the last element - (len - 1)
    let arr_len = data_array.len();

    // Reading the last element using `get` method
    let popped_element = data_array.get(arr_len - 1);
    let second_element = data_array.get(1);

    // Using match, try to check the kind of last element in the `Data enum`
    let res = match popped_element {
        Option::Some(x) => {
            *x.unbox()
        },
        Option::None(_) => {
            Data::Integer(0)
        }
    };
    

    // Use the match statement again to print the result, match using the Data::Integer, Data::Felt, Data::Tuple
    match res {
        Data::Integer(x) => {
            x.print();
        },
        Data::Felt(x) => {
            x.print();
        },
        Data::Tuple(x) => {
            let (num1, num2) = x;
            num1.print();
        }
    };

    // Using indexing, read the first, second, third elements from the `data_array`
    let first_el = data_array[0];
    let sec_el = data_array[1];
    let third_el = data_array[2];
    
    // Create a new array to help with Swap
    let mut new_array: Array<Data> = ArrayTrait::new();
    // Use desnap because the first_el, sec_el, third_el are snapshots
    new_array.append(*sec_el);
    new_array.append(*first_el);
    new_array.append(*third_el);

    // Read the first element from the array using `get` so that we can check whether the swap took place.
    let first_el_check = new_array.get(0);
    
    // Use match again to read the `Option` from `get` since `get` returns an option
    let first_el_check_data = match first_el_check {
        Option::Some(x) => {
            *x.unbox()
        },
        Option::None(_) => {
            // If `None` panic
            let mut arr = ArrayTrait::new();
            arr.append('Not Found');
            panic(arr)
        }
    };
    // Match the `first_el_check_data` to see whether the swap happened
    match first_el_check_data {
        Data::Integer(x) => {
            x.print();
        },
        Data::Felt(x) => {
            x.print();
        },
        Data::Tuple(x) => {
            let (num1, num2) = x;
            num1.print();
        }
    };


}