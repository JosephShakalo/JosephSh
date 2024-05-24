#Evidencia Joseph Shakalo A01784107
# Fecha: 24/05/2024

# Function definition
def factorial(n):
    # Conditional and return statement
    if n == 0:
        return 1
    else:
        return n * factorial(n - 1)  # Recursion and operators

# Loop and flow control
for i in range(5):
    print(factorial(i))  # Function call and printing

# Operations with different types of literals
number = 123  # Integer
pi = 3.14159  # Float
name = "Python"  # String

# Logical operations and comparisons
is_python_ = name == "Python"
is_not_python = name != "C++"

# Lists and index access
my_list = [1, 2, 3, 4, 5]
first_element = my_list[0]

# Dictionaries and key access
my_dict = {'a': 1, 'b': 2}
value_a = my_dict['a']

# Usage of booleans and None
is_valid = True
no_value = None

# Exceptions
try:
    risky = 10 / 0
except ZeroDivisionError:
    print("Cannot divide by zero.")

# Classes and inheritance
class Animal:
    def __init__(self, name):
        self.name = name

class Dog(Animal):
    def bark(self):
        return "Woof!"

# Class instance and method access
my_dog = Dog("Buddy")
print(my_dog.bark())

# Examples with more operators and delimiters
sum_values = 1 + 2 - 3 * 4 / 5 % 6

# Examples of unidentifies or unknown characters
unknown = ª º Ç ` ·


