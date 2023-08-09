use debug::PrintTrait;
use array::ArrayTrait;

fn add_element(array: Array<u32>) -> usize{
    // array.append(3);
    array.len()
}

fn main(){

    let mut x = 'hello world';
    let mut array: Array<u32> = ArrayTrait::new();
    array.append(1);

    
    // add_element(array).print();
    
    // array.len().print();
}