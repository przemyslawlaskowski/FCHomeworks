# Create a shopping cart system where users can add items, remove items, and view the total price.

# Requirements:
# Item Class:
# Attributes: name, price.
# Methods: item_info() (returns a string with item details).

# Cart Class:
#Attributes: items (a list of Item objects).
#Methods: add_item(item, quantity), remove_item(item_name), total_price() (calculates and returns the total price of all items in the cart).

#Challenges:
#Ensure that items can be added with a specified quantity.
#Implement functionality to remove items by name and adjust the quantity accordingly.


# Item Class
class Item:
    def __init__(self, name, price):
        self.name = name
        self.price = price

    def item_info(self):
        return f"Item: {self.name}, Price: ${self.price:.2f}"


# Cart Class
class Cart:
    def __init__(self):
        self.items = {}

    def add_item(self, item, quantity=1):
        if item.name in self.items:
            self.items[item.name]['quantity'] += quantity
        else:
            self.items[item.name] = {'item': item, 'quantity': quantity}
        print(f"Added {quantity} {item.name}(s) to the cart.")

    def remove_item(self, item_name, quantity=1):
        if item_name in self.items:
            if self.items[item_name]['quantity'] > quantity:
                self.items[item_name]['quantity'] -= quantity
                print(f"Removed {quantity} {item_name}(s) from the cart.")
            else:
                del self.items[item_name]
                print(f"Removed all {item_name}(s) from the cart.")
        else:
            print(f"{item_name} not found in the cart.")

    def total_price(self):
        total = 0
        for item_info in self.items.values():
            total += item_info['item'].price * item_info['quantity']
        return f"Total Price: ${total:.2f}"

    def display_cart(self):
        if not self.items:
            print("The cart is empty.")
        else:
            for item_name, item_info in self.items.items():
                print(f"{item_info['item'].item_info()}, Quantity: {item_info['quantity']}")
        print(self.total_price())


# Example
if __name__ == "__main__":
    # Creating some items
    apple = Item("Apple", 0.99)
    banana = Item("Banana", 0.59)
    orange = Item("Orange", 1.25)

    # Creating the cart
    my_cart = Cart()

    # Adding items to the cart with specified quantities
    my_cart.add_item(apple, 3)
    my_cart.add_item(banana, 2)
    my_cart.add_item(orange, 4)

    # Displaying the cart
    print("\nCart Contents:")
    my_cart.display_cart()

    # Removing items and adjusting quantities
    print("\nRemoving items:")
    my_cart.remove_item("Banana", 1)  
    my_cart.remove_item("Orange", 2)  
    my_cart.remove_item("Apple", 5)

    # Displaying the updated cart
    print("\nUpdated Cart Contents:")
    my_cart.display_cart()
