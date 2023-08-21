
use debug::PrintTrait;
use array::ArrayTrait;

// #[derive()]
fn swap<T, impl TDrop:Drop<T>>(x: T, y: T)->Array<T>{

    let temp_val = y;
    let y = x;
    let x = temp_val;
    let mut arr = ArrayTrait::new();
    arr.append(x);
    arr.append(y);

    arr

}
fn main(){
    let x: felt252 = 'X here is 1';
    let y: felt252 = 'Y here is 2';
    let res = swap(x, y);

    res.len().print();
    let x1 = *res.at(0);
    let y1 = *res.at(1);
    x1.print();
    y1.print();

}


