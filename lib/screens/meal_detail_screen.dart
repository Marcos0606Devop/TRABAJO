import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/meal_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MealDetailScreen extends StatelessWidget {
  final String mealId;
  MealDetailScreen({required this.mealId});

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('How to Make It?',
        style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: 'Pacifico',
      ),
      ),
      centerTitle: true
        ),
      body: FutureBuilder<Meal>(
        future: _apiService.fetchMealDetails(mealId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load meal details'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Meal details not available'));
          }
          final meal = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(meal.thumbnail),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      meal.name,
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Caveat'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Instrucciones:',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100, fontFamily: 'Pacifico'),
                  ),
                ),

                // Botones de YouTube y Google antes del texto de instrucciones
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton.icon(
                    onPressed: () {
                      launchUrl(Uri.parse(meal.youtube));
                    },
                    icon: Image.asset(
                      'img/Youtube_logo.png', // Cambia esta ruta por la ruta de tu logo de YouTube
                      height: 20,
                      width: 20,
                    ),
                    label: Text('Watch on YouTube'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton.icon(
                    onPressed: () {
                      launchUrl(Uri.parse(meal.source));
                    },
                    icon: Image.asset(
                      'img/google.png', // Cambia esta ruta por la ruta de tu logo de Google
                      height: 20,
                      width: 20,
                    ),
                    label: Text('Source'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                  ).animate().fadeIn(duration: 300.ms), // Añadiendo animación
                ),

                // Texto de instrucciones
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    meal.instructions,
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w100,fontFamily: 'Lobster'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Ingredientes:',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100, fontFamily: 'Pacifico'),
                  ),
                ),
                ...List.generate(meal.ingredients.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${meal.measures[index]} of ${meal.ingredients[index]}',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w100,fontFamily: 'Lobster'),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
