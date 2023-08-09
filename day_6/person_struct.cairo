use debug::PrintTrait;

#[derive(Drop)]
struct Person {
    name: felt252,
    age: u32
}

fn modify_person_take_ownership(mut person: Person, name: felt252, age: u32) -> Person {

    person.name = name;
    person.age = age;

    person
}

fn modify_person_with_ref(ref person: Person, name: felt252, age: u32) {

    person.name = name;
    person.age = age;
}

fn main(){
    let mut person: Person = Person {
        name: 'dalmas',
        age: 25
    };

    modify_person_with_ref(ref person, 'other name', 3);
    person.name.print();
    person.age.print();

    let person_2: Person = Person {
        name: 'name',
        age: 4
    };

    let modified_person_2 = modify_person_take_ownership(person_2, 'new name', 7);
    modified_person_2.name.print();
    modified_person_2.age.print();

}