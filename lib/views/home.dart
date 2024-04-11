import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:food_app_api/models/model1.dart';
import 'package:food_app_api/models/model2.dart';
import 'package:food_app_api/providers/foodprovider.dart';
import 'package:food_app_api/providers/mealsprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<Mealsprovider>(context, listen: false);

    final foodprovider = Provider.of<FoodProvider>(context, listen: false);
    provider.getDataFromApi();
    foodprovider.getDataFromApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<Mealsprovider>(context);
    //final foodproviders = Provider.of<FoodProvider>(context);

    return Scaffold(
      //appBar: AppBar(leading: i,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 13,
          ),
          Text("Today meals"),
          Consumer<Mealsprovider>(builder: (context, provider, index) {
            return provider.isloading
                ? getLoadingUi()
                : provider.error.isNotEmpty
                    ? getErrorUI(provider.error)
                    : getBody(provider.meals
                        //foodproviders.food
                        );
          }),
          SizedBox(
            height: 5,
          ),
          const Text(
            "Popular meals",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Consumer<FoodProvider>(builder: (context, providers, index) {
            return providers.isloading
                ? getLoadingUi()
                : providers.error.isNotEmpty
                    ? getErrorUI(providers.error)
                    : getCategoryBodey(providers.food);
          })
        ],
      ),
    );
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

  Widget getCategoryBodey(Categoryitem food) {
    return Column(
      children: [
        SizedBox(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: food.categories.length,
                itemBuilder: (context, index) {
                  // return Text("hello");
                  return Column(
                    children: [
                      Container(
                        width: 80,
                        margin: EdgeInsets.all(10),
                        height: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  food.categories[index].strCategoryThumb
                                  //"https://images.unsplash.com/photo-1710115929211-ae9646071f6b?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                  ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Text(food.categories[index].strCategory)
                    ],
                  );
                })),
      ],
    );
  }

  Widget getBody(
    Meals items,
    //Categoryitem foods
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: items.meals.length,
            itemBuilder: (context, index, realindex) {
              final uriImage = items.meals[index]["strMealThumb"];
              final name = items.meals[index]["strMeal"];
              return buildImage(uriImage, index, name);
            },
            options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 0.4,
                height: 200),
          ),
        ),
        const SizedBox(
          height: 12,
        ),

        // Container(
        //   height: 200,
        //   width: double.infinity,
        //   child: ListView.builder(
        //       itemCount: foods.categories.length,
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (context, index) {
        //         //final images = foods.categories[index].strCategoryThumb;
        //         // final name = foods.categories[index].strCategory;
        //         return Text("hello");

        //         //foodappsitems(images, name, index);
        //       }),
        // )
      ],
    );
  }

  Widget foodappsitems(String images, String names, int index) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 150,
            width: 100,
            child: Image.network(images),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            names,
            style: TextStyle(fontSize: 19),
          )
        ],
      ),
    );
  }

  Widget buildImage(String uriImage, int index, String name) => Container(
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              uriImage,
            ),
            fit: BoxFit.cover),
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                name,
                style: const TextStyle(color: Colors.white),
              )),
        ],
      ));
}
