#Design a recipe management system where users can create, view, and manage recipes.
#Requirements:
#Recipe Class:

#   Attributes: name, ingredients (a list of ingredient names), instructions.
#   Methods: add_ingredient(ingredient), recipe_info() (returns a string with recipe details).

#RecipeBook Class:

#   Attributes: recipes (a list of Recipe objects).
#   Methods: add_recipe(recipe), find_recipe(name) (returns the Recipe object with the given name), list_recipes() (returns a list of all recipe names).
#Challenges:

#   Ensure that recipes can be added, ingredients listed, and recipes found by name.


# Recipe Class
class Recipe:
    def __init__(self, name, instructions):
        self.name = name
        self.ingredients = []
        self.instructions = instructions
    
    def add_ingredient(self, ingredient):
        self.ingredients.append(ingredient)
        print(f"Added {ingredient} to {self.name}")
    
    def recipe_info(self):
        info = f"Recipe: {self.name}\n"
        info += "Ingredients:\n"
        for ingredient in self.ingredients:
            info += f"- {ingredient}\n"
        info += f"Instructions: {self.instructions}"
        return info


# RecipeBook Class
class RecipeBook:
    def __init__(self):
        self.recipes = []
    
    def add_recipe(self, recipe):
        self.recipes.append(recipe)
        print(f"Added {recipe.name} to the recipe book")
    
    def find_recipe(self, name):
        for recipe in self.recipes:
            if recipe.name.lower() == name.lower():
                return recipe
        return None
    
    def list_recipes(self):
        return [recipe.name for recipe in self.recipes]

# Example
if __name__ == "__main__":
    # Create a recipe book
    my_recipe_book = RecipeBook()

    # Create a recipe
    pancakes = Recipe("Pancakes", "Mix ingredients, cook on griddle until golden brown")
    pancakes.add_ingredient("250 g flour")  # 
    pancakes.add_ingredient("2 eggs")        
    pancakes.add_ingredient("240 ml milk")   
    pancakes.add_ingredient("25 g sugar")     

    # Add recipe to the book
    my_recipe_book.add_recipe(pancakes)

    # Create and add Banana Smoothie recipe
    smoothie = Recipe("Banana Smoothie", "Blend all ingredients until smooth")
    smoothie.add_ingredient("2 bananas")     
    smoothie.add_ingredient("250 g yogurt")   
    smoothie.add_ingredient("120 ml milk")    
    smoothie.add_ingredient("40 g honey")      
    my_recipe_book.add_recipe(smoothie)

    # Create a bread recipe
    bread = Recipe("Simple Bread", "Mix dry ingredients, add wet ingredients, knead, let rise, shape, bake at 190°C for 30-35 minutes")
    bread.add_ingredient("375 g all-purpose flour, type 500 in Poland")  
    bread.add_ingredient("5 g salt")                   
    bread.add_ingredient("3 g active dry yeast")       
    bread.add_ingredient("240 ml warm water")          
    bread.add_ingredient("20 ml olive oil")            
    my_recipe_book.add_recipe(bread)


    # List all recipes
    print("\nAll recipes:")
    for recipe_name in my_recipe_book.list_recipes():
        print(recipe_name)

    # Find and display a recipe
    recipe_to_find = "pancakes"
    found_recipe = my_recipe_book.find_recipe(recipe_to_find)
    if found_recipe:
        print(f"\nFound recipe for {recipe_to_find}:")
        print(found_recipe.recipe_info())
    else:
        print(f"\nRecipe for {recipe_to_find} not found")
