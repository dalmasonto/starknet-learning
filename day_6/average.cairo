use debug::PrintTrait;
use array::ArrayTrait;

fn calculate_average(array: @Array<u32>) -> u32 {
    let mut sum: u32 = 0;
    let len = array.len();
    let mut counter = 0;

    loop {
        if (counter == len){
            break;
        }
        sum += *array[counter];
        counter += 1;
    };
    sum / len

}

fn main(){
    let mut arr: Array<u32> = ArrayTrait::new();
    arr.append(2);
    arr.append(3);
    arr.append(4);
    arr.append(5);

    calculate_average(@arr).print();
}