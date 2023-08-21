use array::ArrayTrait;
use debug::PrintTrait;


// felt252, u8-u256, bool, tuples, arrays

#[derive(Copy, Drop)]
struct Profile {
    dob: felt252,
    phone_no: u64,
}

#[derive(Copy, Drop)]
struct User {
    id: felt252,
    first_name: felt252,
    last_name: felt252,
    email: felt252,
    profile: Profile
}

#[derive(Copy, Drop)]
struct Blog {
    author: felt252,
    title: felt252,
    content: felt252
}

#[derive(Drop)]
struct Database {
    users: Array<User>,
    blogs: Array<Blog>,
}

trait UserTrait {
    fn get_full_name(self: User);
    fn get_phone_number(self: User) -> u64;
}

trait DatabaseTrait {
    fn add_new_user(ref self: Database, user: User);
    fn check_if_user_exists(self: @Database, id: felt252) -> bool;
    fn add_new_blog(ref self: Database, blog: Blog)-> felt252;
    fn get_stats(self: @Database);
}

impl UserImpl of UserTrait {
    fn get_full_name(self: User) {
        self.first_name.print();
    }

    fn get_phone_number(self: User) -> u64 {
        self.profile.phone_no
    }
}

impl DatabaseImpl of DatabaseTrait {
    fn add_new_user(ref self: Database, user: User) {
        self.users.append(user);
    }

    fn check_if_user_exists(self: @Database, id: felt252) -> bool {
        let mut i = 0;
        let mut found: bool = false;

        loop {
            let user: User = *self.users[i];
            if (user.id == id) {
                found = true;
                break;
            }
            i += 1;
        };
        found
    }

    fn add_new_blog(ref self: Database, blog: Blog) -> felt252{
        let user_found = self.check_if_user_exists(blog.author);
        if (user_found) {
            self.blogs.append(blog);
            return 'blog added successfully';
        }
        'author not found'
    }

    fn get_stats(self: @Database) {
        self.users.len().print();
        self.blogs.len().print();
    }
}

fn main() {
    let user = User {
        id: 1,
        first_name: 'dalmas',
        last_name: 'ogembo',
        email: 'dalmas@gmail.com',
        profile: Profile {
            dob: '1/1/2000', phone_no: 700000000
        }
    };

    let user2 = User {
        id: 2,
        first_name: 'john',
        last_name: 'doe',
        email: 'johndoe@gmail.com',
        profile: Profile {
            dob: '1/1/2000', phone_no: 700000000
        }
    };

    let mut database = Database {
        users: ArrayTrait::new(),
        blogs: ArrayTrait::new(),
    };

    database.add_new_user(user);
    database.add_new_user(user2);

    database.get_stats();
}
