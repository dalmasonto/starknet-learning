use debug::PrintTrait;

#[derive(Drop, Copy)]
struct Contact{ 
    name: felt252,
    phone: felt252,
    email: felt252
}

// trait Printable {
//     fn print(self: @Contact);
// }


impl ContactImpl of PrintTrait<Contact>  {
    fn print(self: Contact) {
        self.name.print();
        self.phone.print();
        self.email.print();
    }
}


fn main(){
    let contact = Contact {
        name: 'Dalmas',
        phone: '070000000',
        email: 'mail@gmail.com'
    };

    contact.print();
}