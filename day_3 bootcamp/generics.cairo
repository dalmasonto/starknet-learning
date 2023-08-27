use debug::PrintTrait;

#[derive(Copy, Drop)]
enum ItemCategory{
    Electronics: felt252,
    Clothing: felt252,
    Groceries: felt252,
}

trait ItemCategoryTrait<U> {
    fn display_category(self: @U);
}

impl ItemCategoryImpl of ItemCategoryTrait<ItemCategory> {
    fn display_category(self: @ItemCategory) {
        match *self {
            ItemCategory::Electronics(val) => {
                val.print();
            },
            ItemCategory::Clothing(val) => {
                val.print();
            },
            ItemCategory::Groceries(val) => {
                val.print();
            },
        };
    }
}

#[derive(Copy, Drop)]
struct CartItem<T, U> {
    name: T,
    price: T,
    quantity: T,
    category: U
}

#[generate_trait]
impl CartItemImpl<T, U, 
    impl TDrop: Drop<T>, 
    impl TCopy: Copy<T>, 
    impl TPrint: PrintTrait<T>,
    impl UItemCategory: ItemCategoryTrait<U>
    > 
of  CartItemTrait<T, U> {
    fn display_category_info(self: @CartItem<T, U>){
        self.category.display_category();
    }
}


fn main(){
    let mut item1 = CartItem {
        name: 'Product 1',
        price: 2500,
        quantity: 2,
        category: ItemCategory::Groceries('Fruits')
    };
    
    item1.category.display_category();
    item1.display_category_info();
}

