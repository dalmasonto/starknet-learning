# Day 10
## Read about

- Generic functions
- Traits In cairo

## CHALLENGE (Online Shopping Cart Enhancement)

You are a developer working on an online shopping platform. The platform currently allows users to
add items of various types (such as electronics, clothing, and groceries) to their shopping carts. The
management wants to improve the cart functionality by introducing a generic approach.


Design a solution that utilizes generic structs, traits, and methods to enhance the shopping cart system.

Consider the following requirements:
### 1. Level 1

**Generic Cart Item:** Create a generic struct called CartItem<T> that can hold an item of any
type T. Include fields for the item's name, price, and quantity.

**Trait for Pricing:** Implement a trait called Priced with a method calculate_price that
calculates the total price of a cart item based on its price and quantity.

### 2. Level 2
   
**Trait for Display:** Create a trait DisplayItem with a generic method display that
displays the cart item's name, price, and quantity in a user-friendly format.

**Enums for Item Categories:** Define an enum ItemCategory with variants for different
types of items (Electronics, Clothing, Groceries, etc.).

### 3. Level 3
   
**Generic Cart Functions:** Develop functions to add items to the cart and calculate the total
price of all items in the cart. These functions should utilize the CartItem, Priced, and
DisplayItem traits appropriately.

**Example Usage:** Provide an example usage of your solution. Create instances of cart items with
different types, display their information, calculate their prices, and calculate the total cart
value.


Ensure that your implementation enforces constraints like implementing required traits for pricing and
displaying.


### References

- https://book.cairo-lang.org/ch07-01-generic-data-types.html
  
- https://book.cairo-lang.org/ch07-02-traits-in-cairo.html