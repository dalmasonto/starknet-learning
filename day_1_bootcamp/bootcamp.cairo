use debug::PrintTrait;

fn get_data(data: felt252){
    data.print();
}

fn main(){
    let num1 = 10;
    let num2 = 10;
    let res = num1 - num2;

    res.print();
    get_data('data');
}
