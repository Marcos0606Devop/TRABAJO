import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/meal_model.dart';
import 'meal_detail_screen.dart';

class MealListScreen extends StatelessWidget {
  final String category;
  MealListScreen({required this.category});

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              category,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: 'Pacifico',
            ),
          ),
          centerTitle: true

      ),
      body: FutureBuilder<List<Meal>>(
        future: _apiService.fetchMealsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load meals'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No meals found in this category'));
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Número de columnas
              childAspectRatio: 0.9, // Cambiar el aspecto para hacer las tarjetas más largas
              crossAxisSpacing: 10.0, // Espacio horizontal entre tarjetas
              mainAxisSpacing: 10.0, // Espacio vertical entre tarjetas
            ),
            padding: EdgeInsets.all(10.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final meal = snapshot.data![index];
              return Card(
                elevation: 5, // Sombra de la tarjeta
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailScreen(mealId: meal.id),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 120, // Altura fija para la imagen
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                          child: Image.network(
                            meal.thumbnail,
                            fit: BoxFit.cover, // Ajusta la imagen al tamaño de la tarjeta
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          meal.name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center, // Centra el texto
                          maxLines: 2, // Limitar el número de líneas
                          overflow: TextOverflow.ellipsis, // Agregar puntos suspensivos si el texto es muy largo
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
