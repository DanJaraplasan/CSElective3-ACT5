import 'package:flutter/material.dart';
import 'meal_service.dart';
import 'package:url_launcher/url_launcher.dart';
// For next button
// class MealScreen extends StatefulWidget {
//   @override
//   _MealScreenState createState() => _MealScreenState();
// }

// class _MealScreenState extends State<MealScreen> {
//   final MealService _mealService = MealService();
//   List<dynamic> _meals = [];
//   int _currentMealIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _loadMeals();
//   }

//   Future<void> _loadMeals() async {
//     List<dynamic> meals = await _mealService.fetchMeals('p');
//     setState(() {
//       _meals = meals;
//     });
//   }

//   void _nextMeal() {
//     setState(() {
//       _currentMealIndex = (_currentMealIndex + 1) % _meals.length;
//     });
//   }

//   Future<void> launchUrl(Uri url) async {
//     if (!await launch(url.toString())) throw 'Could not launch $url';
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_meals.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Meals'),
//         ),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     final meal = _meals[_currentMealIndex];

//     // Extract ingredients
//     List<String> ingredients = [];
//     for (int i = 1; i <= 20; i++) {
//       final ingredient = meal['strIngredient$i'];
//       final measure = meal['strMeasure$i'];
//       if (ingredient != null && ingredient.isNotEmpty) {
//         ingredients.add('$ingredient - ${measure ?? ''}');
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Meals'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Top: Image
//             Container(
//               height: 250, // Set a height for the image
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                 image: DecorationImage(
//                   image: NetworkImage(meal['strMealThumb'] ?? ''),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16), // Space between image and details
//             // Bottom: Details
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Meal Name
//                   Text(
//                     meal['strMeal'] ?? 'No meal name',
//                     style: TextStyle(
//                       fontSize:
//                           22, // Increased font size for better readability
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   // Category
//                   Text(
//                     'Category: ${meal['strCategory'] ?? 'N/A'}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   // Area
//                   Text(
//                     'Area: ${meal['strArea'] ?? 'N/A'}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   // Ingredients Section
//                   Text(
//                     'Ingredients:',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   ...ingredients
//                       .map((ingredient) =>
//                           Text(ingredient, style: TextStyle(fontSize: 14)))
//                       .toList(),
//                   SizedBox(height: 8),
//                   // Instructions Section
//                   Text(
//                     'Instructions:',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     meal['strInstructions'] ?? 'No instructions available',
//                     style: TextStyle(fontSize: 14),
//                   ),
//                   // YouTube Button
//                   if (meal['strYoutube'] != null)
//                     ElevatedButton.icon(
//                       onPressed: () {
//                         launchUrl(Uri.parse(meal['strYoutube']));
//                       },
//                       icon: Icon(Icons.play_circle_filled),
//                       label: Text('Watch on YouTube'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.redAccent,
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 16,
//                         ),
//                       ),
//                     ),
//                   // Next Button
//                   SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton(
//                       onPressed: _nextMeal,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueAccent,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       ),
//                       child: Text('Next Meal'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MealScreen extends StatefulWidget {
  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  final MealService _mealService = MealService();
  List<dynamic> _meals = [];

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    List<dynamic> meals = await _mealService.fetchMeals('p');
    setState(() {
      _meals = meals;
    });
  }

  Future<void> launchUrl(Uri url) async {
    if (!await launch(url.toString())) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    if (_meals.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
      ),
      body: ListView.builder(
        itemCount: _meals.length,
        itemBuilder: (context, index) {
          final meal = _meals[index];

          // Extract ingredients
          List<String> ingredients = [];
          for (int i = 1; i <= 20; i++) {
            final ingredient = meal['strIngredient$i'];
            final measure = meal['strMeasure$i'];
            if (ingredient != null && ingredient.isNotEmpty) {
              ingredients.add('$ingredient - ${measure ?? ''}');
            }
          }

          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            elevation: 4, // Adds shadow to the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Meal Image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    meal['strMealThumb'] ?? '',
                    height: 200, // Height of the meal image
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Meal Name
                      Text(
                        meal['strMeal'] ?? 'No meal name',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Category
                      Text(
                        'Category: ${meal['strCategory'] ?? 'N/A'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      // Area
                      Text(
                        'Area: ${meal['strArea'] ?? 'N/A'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      // Ingredients Section
                      Text(
                        'Ingredients:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...ingredients
                          .map((ingredient) =>
                              Text(ingredient, style: TextStyle(fontSize: 14)))
                          .toList(),
                      SizedBox(height: 8),
                      // Instructions Section
                      Text(
                        'Instructions:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        meal['strInstructions'] ?? 'No instructions available',
                        style: TextStyle(fontSize: 14),
                      ),
                      // YouTube Button
                      if (meal['strYoutube'] != null)
                        ElevatedButton.icon(
                          onPressed: () {
                            launchUrl(Uri.parse(meal['strYoutube']));
                          },
                          icon: Icon(Icons.play_circle_filled),
                          label: Text('Watch on YouTube'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
