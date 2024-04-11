import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:food_app_api/models/model1.dart';
import 'package:food_app_api/providers/mealsprovider.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  @override
  void initState() {
    final provider = Provider.of<Mealsprovider>(context, listen: false);

    provider.getDataFromApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Mealsprovider>(context);
    //final foodproviders = Provider.of<FoodProvider>(context);

    return Scaffold(
        //appBar: AppBar(leading: i,),
        body: provider.isloading
            ? getLoadingUi()
            : provider.error.isNotEmpty
                ? getErrorUI(provider.error)
                : getBody(provider.meals
                    //foodproviders.food
                    ));
  }

  Widget getLoadingUi() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(
            color: Color.fromARGB(255, 204, 11, 11),
            size: 90.0,
          ),
          Text(
            "Loading....",
            style: TextStyle(fontSize: 20, color: Colors.amber),
          )
        ],
      ),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.orange, fontSize: 22),
      ),
    );
  }

  Widget getBody(
    Meals items,
    //Categoryitem foods
  ) {
    return GridView.builder(
      itemCount: items.meals.length,
      padding:const EdgeInsets.all(30),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemBuilder: (context, index) {
        final uriImage = items.meals[index]["strMealThumb"];
        final name = items.meals[index]["strMeal"];
        final data = items.meals[index]["strInstructions"];
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Meal Details'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Name: $name'),
                        Text('Instructions: $data'),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
                  ],
                );
              },
            );
          },
          child: SizedBox(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      // padding: EdgeInsets.all(20),
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(uriImage),
                              fit: BoxFit.cover)),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
