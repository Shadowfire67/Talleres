class Meal {
  final String id;
  final String name;
  final String? thumbnail;
  final String? category;
  final String? area;
  final String? instructions;

  Meal({
    required this.id,
    required this.name,
    this.thumbnail,
    this.category,
    this.area,
    this.instructions,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      thumbnail: json['strMealThumb'] as String?,
      category: json['strCategory'] as String?,
      area: json['strArea'] as String?,
      instructions: json['strInstructions'] as String?,
    );
  }
}
