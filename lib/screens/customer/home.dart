import 'package:flutter/material.dart';
import 'package:restaurant_order/models/cuisine.dart';
import 'package:restaurant_order/services/database_services.dart';

import '../../models/category.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  List<Category> categories = [];
  List<Cuisine> cuisines = [];

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Piyaplas Cuisine'),
      ),
      body: StreamBuilder<List<Category>>(
          stream: DatabaseServices().getCategories(),
          builder: (context, catgoriesSnap) {
            if (catgoriesSnap.hasData) {
              categories = catgoriesSnap.data!;
            }
            return StreamBuilder<List<Cuisine>>(
                stream: DatabaseServices().getCuisines(),
                builder: (context, cuisineSnap) {
                  if (cuisineSnap.hasData) {
                    cuisines = cuisineSnap.data!;
                  }
                  print(cuisines);
                  return Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: [
                        Text('Search'),
                        Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(categories[index].category),
                                      ),
                                    );
                                  },
                                  itemCount: categories.length,
                                )),
                            Expanded(
                                flex: 7,
                                child: Column(
                                  children: [
                                    GridView.builder(
                                      padding: const EdgeInsets.all(8),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: GridTile(child: Text(cuisines[index].name)),
                                        );
                                      },
                                      itemCount: cuisines.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount : (orientation==Orientation.portrait)?2:3
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
