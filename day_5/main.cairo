use dict::Felt252DictTrait;
use debug::PrintTrait;

fn get_student_grade(ref marks: Felt252Dict<u64>, name: felt252 )-> u64{
    marks.get(name)
}

// fn get_student_grade_2(marks: @Felt252Dict<u64>, name: felt252 )-> felt252{
//     marks.get(name)
// }

fn main() {
    let mut marks: Felt252Dict<u64> = Default::default();

    marks.insert('Alex', 100);
    marks.insert('Maria', 2);

    // let alex_balance = marks.get('Alex');
    // assert(alex_balance == 100, 'Balance is not 100');

    // let maria_balance = marks.get('Maria');
    // maria_balance.print();
    // assert(maria_balance == 200, 'Balance is not 200');

    let alex = get_student_grade(ref marks, 'Alex');
    alex.print();

    marks.insert('John', 2);
}
