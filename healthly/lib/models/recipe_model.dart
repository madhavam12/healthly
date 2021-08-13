class Recipe {
  final String spoonacularSourceUrl;
  final String sourceUrl;

  Recipe({
    this.spoonacularSourceUrl,
    this.sourceUrl,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      sourceUrl: map['sourceUrl'],
      spoonacularSourceUrl: map['spoonacularSourceUrl'],
    );
  }
}
