import 'package:flutter/material.dart';
import 'package:healthly/models/meal_model.dart';
import 'package:healthly/models/meal_plan_model.dart';
import 'package:healthly/models/recipe_model.dart';
import 'package:healthly/recipePages/recipe_screen.dart';
import 'package:healthly/services/receipeService.dart';
import 'package:healthly/covidDS/config/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class MealsScreen extends StatefulWidget {
  final MealPlan mealPlan;
  MealsScreen({this.mealPlan});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  _buildTotalNutrientsCard() {
    return Container(
      height: 200,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Total Nutrients',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            children: <Widget>[
              Text(
                'Calories: ${widget.mealPlan.calories.toString()} cal',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Protein: ${widget.mealPlan.protein.toString()} g',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fat: ${widget.mealPlan.fat.toString()} g',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Carb: ${widget.mealPlan.carbs.toString()} cal',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildMealCard(Meal meal, int index) {
    String mealType = _mealType(index);

    return GestureDetector(
      onTap: () async {
        Recipe recipe =
            await ApiService.instance.fetchRecipe(meal.id.toString());
        print(recipe.spoonacularSourceUrl);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RecipeScreen(
                      mealType: mealType,
                      recipe: recipe,
                    )));
      },
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Container(
          height: 220,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(meal.imgURL),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
              ]),
        ),
        Container(
          margin: EdgeInsets.all(60),
          padding: EdgeInsets.all(10),
          color: Colors.white70,
          child: Column(
            children: <Widget>[
              Text(
                _mealType2(index),
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              Text(
                meal.title,
                maxLines: 5,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
      ]),
    );
  }

  _mealType2(int index) {
    switch (index) {
      case 0:
        return 'Breakfast 🍎';
      case 1:
        return 'Lunch 🍞';
      case 2:
        return 'Dinner 🥘';
      default:
        return 'Breakfast 🍎';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          'Today\'s Meal Plan',
          style: TextStyle(color: Colors.black, fontFamily: "QuickSand"),
        ),
      ),
      body: ListView.builder(
          itemCount: 1 + widget.mealPlan.meals.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return NutrientCard(
                mealPlan: widget.mealPlan,
              );
            }

            Meal meal = widget.mealPlan.meals[index - 1];
            print(meal.id);
            // return _buildMealCard(
            //   meal,
            //   index - 1,
            // );
            return MealType(
              meal: meal,
              mealIndex: index - 1,
            );
          }),
    );
  }
}

class MealType extends StatelessWidget {
  final Meal meal;
  final int mealIndex;
  const MealType({Key key, @required this.mealIndex, @required this.meal})
      : super(key: key);

  _mealType2(int index) {
    switch (index) {
      case 0:
        return 'For Breakfast 🍎';
      case 1:
        return 'For Lunch 🍞';
      case 2:
        return 'For Dinner 🥘';
      default:
        return 'For Breakfast 🍎';
    }
  }

  _mealEmoji(int index) {
    switch (index) {
      case 0:
        return '🍎';
      case 1:
        return '🍞';
      case 2:
        return '🥘';
      default:
        return '🍎';
    }
  }

  _mealImage(int index) {
    switch (index) {
      case 0:
        return 'assets/images/breakfast.png';
      case 1:
        return 'assets/images/lunch.png';
      case 2:
        return 'assets/images/dinner.png';
      default:
        return 'assets/images/breakfast.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 25.0,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        image: DecorationImage(
          image: AssetImage(_mealImage(mealIndex)),
        ),
        color: Colors.blue,
      ),
      alignment: Alignment.center,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              gradient: new LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.8),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.1, 1.0],
                  tileMode: TileMode.clamp)),
          child: Align(
            alignment: Alignment.center,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Flexible(
                    child: Text(
                      _mealType2(mealIndex),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "QuickSand",
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FlatButton(
                    onPressed: () async {
                      // String mealType = _mealType(mealIndex);
                      Recipe recipe = await ApiService.instance
                          .fetchRecipe(meal.id.toString());
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => RecipeScreen(
                      //               mealType: mealType,
                      //               recipe: recipe.spoonacularSourceUrl,
                      //             )));
                      print(recipe.spoonacularSourceUrl);
                      print(recipe.spoonacularSourceUrl);

                      if (recipe.spoonacularSourceUrl == null &&
                          recipe.sourceUrl == null) {
                        showInSnackBar(
                            context: context,
                            value:
                                "Spooncular daily API quota reached, please try after some time or setup billing.",
                            color: Colors.red,
                            sec: 12);
                        return 0;
                      }
                      if (recipe.spoonacularSourceUrl != null &&
                          recipe.sourceUrl != null) {
                        await canLaunch(recipe.spoonacularSourceUrl)
                            ? await launch(recipe.spoonacularSourceUrl)
                            : showInSnackBar(
                                context: context,
                                value:
                                    "Couldn't launch the URL, an unknown error occured",
                                color: Colors.red,
                                sec: 8);
                        return 0;
                      }
                      if (recipe.spoonacularSourceUrl != null &&
                          recipe.sourceUrl == null) {
                        await canLaunch(recipe.spoonacularSourceUrl)
                            ? await launch(recipe.spoonacularSourceUrl)
                            : showInSnackBar(
                                context: context,
                                value:
                                    "Couldn't launch the URL, an unknown error occured",
                                color: Colors.red,
                                sec: 8);
                        return 0;
                      }
                      if (recipe.spoonacularSourceUrl == null &&
                          recipe.sourceUrl != null) {
                        await canLaunch(
                          recipe.sourceUrl,
                        )
                            ? await launch(
                                recipe.sourceUrl,
                              )
                            : showInSnackBar(
                                context: context,
                                value:
                                    "Couldn't launch the URL, an unknown error occured",
                                color: Colors.red,
                                sec: 8);
                        return 0;
                      }

                      await canLaunch(recipe.spoonacularSourceUrl)
                          ? await launch(
                              recipe.spoonacularSourceUrl,
                            )
                          : showInSnackBar(
                              context: context,
                              value:
                                  "Couldn't launch the URL, an unknown error occured",
                              color: Colors.red,
                              sec: 8);
                    },
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'View ${_mealEmoji(mealIndex)}',
                      style: Styles.buttonTextStyle
                          .copyWith(fontFamily: "QuickSand"),
                    ),
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NutrientCard extends StatelessWidget {
  final MealPlan mealPlan;
  const NutrientCard({Key key, @required this.mealPlan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 25.0,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        // image: DecorationImage(
        //   image: AssetImage('assets/images/covid.png'),
        // ),
        color: Colors.orange.withOpacity(0.89),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Center(
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 80,
                      margin: EdgeInsets.only(
                          bottom: 40, top: 1, right: 5, left: 5),
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bowl.png"),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nutrients Information",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "QuickSand",
                            fontSize: 20.0,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Calories: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "QuickSand",
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${mealPlan.calories.toString()} cal',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Fat: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "QuickSand",
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${mealPlan.fat.toString()} g',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Carbs: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "QuickSand",
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${mealPlan.carbs.toString()} cal',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Protein: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "QuickSand",
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${mealPlan.protein.toString()} g',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showInSnackBar(
    {String value, Color color, int sec = 3, @required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    content: new Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
    ),
    backgroundColor: color,
    duration: Duration(seconds: sec),
  ));
}

_mealType(int index) {
  switch (index) {
    case 0:
      return 'Breakfast';
    case 1:
      return 'Lunch';
    case 2:
      return 'Dinner';
    default:
      return 'Breakfast';
  }
}
