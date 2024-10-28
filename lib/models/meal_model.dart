class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String instructions;
  final String youtube;
  final List<String> ingredients; // Lista de ingredientes
  final List<String> measures; // Lista de medidas
  final String source; // Enlace a la receta

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.instructions,
    required this.youtube,
    required this.ingredients,
    required this.measures,
    required this.source,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    // Crear listas de ingredientes y medidas
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      if (json['strIngredient$i'] != null && json['strIngredient$i'] != '') {
        ingredients.add(json['strIngredient$i']);
        measures.add(json['strMeasure$i']);
      }
    }

    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
      instructions: json['strInstructions'] ?? '',
      youtube: json['strYoutube'] ?? '',
      ingredients: ingredients,
      measures: measures,
      source: json['strSource'] ?? '',
    );
  }
}

class MealCategory {
  final String id;
  final String name;
  final String thumbnail;
  final String description;


  MealCategory({required this.id, required this.name, required this.thumbnail,required this.description});

  factory MealCategory.fromJson(Map<String, dynamic> json) {
    return MealCategory(
      id: json['idCategory'],
      name: json['strCategory'],
      thumbnail: json['strCategoryThumb'],
      description:json['strCategoryDescription'],
    );
  }
}
