import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_order/models/cuisine.dart';
import 'package:restaurant_order/models/order.dart';
import 'package:restaurant_order/services/database_services.dart';

import '../../models/category.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  TextEditingController searchController = TextEditingController();
  List<Category> categories = [];
  List<Cuisine> cuisines = [];
  List<Cuisine> filteredCuisines = [];
  List<Cuisine> selectedCuisines = [];
  List<Cuisine> cart = [];
  String searchText = '';
  String selectedCategory = '';

  _CustomerHomeState() {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          searchText = '';
        });
      } else {
        setState(() {
          searchText = searchController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        appBar: AppBar(
          title: Text('Piyaplas Cuisine'),
          actions: [
            Badge(
              position: BadgePosition.topEnd(top: 3, end: 18),
              animationDuration: Duration(milliseconds: 200),
              animationType: BadgeAnimationType.fade,
              badgeContent: Text(
                '${cart.length}',
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(icon: Icon(Icons.shopping_cart), padding: EdgeInsets.only(right: 30.0), onPressed: () {

              }),
            ),
          ],
        ),
        body: StreamBuilder<List<Category>>(
            stream: DatabaseServices().getCategories(),
            builder: (context, catgoriesSnap) {
              categories = [Category(category: 'All', veg: false)];
              if (catgoriesSnap.hasData) {

                categories.addAll(catgoriesSnap.data!);
                // categories.insert(0, Category(category: 'All', veg: false));
              }
              return StreamBuilder<List<Cuisine>>(
                  stream: DatabaseServices().getCuisines(),
                  builder: (context, cuisineSnap) {
                    if (cuisineSnap.hasData) {
                      cuisines = cuisineSnap.data!;
                      selectedCuisines = (selectedCategory.isEmpty || selectedCategory == 'All')
                          ? cuisines.where((element) => (element.visibility)).toList()
                          : cuisines.where((element) => (element.category.category == selectedCategory)&&(element.visibility)).toList();
                      filteredCuisines =
                          (searchText.isEmpty) ? selectedCuisines : selectedCuisines.where((element) => element.name.contains(searchText)).toList();
                    }

                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        children: [
                          TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                                labelText: 'Search',
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                          ),
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
                                          onTap: () {
                                            setState(() {
                                              selectedCategory = categories[index].category;
                                            });
                                          },
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
                                            color:
                                                (cart.map((e) => e.name).contains(filteredCuisines[index].name)) ? Colors.orangeAccent : Colors.white,
                                            child: ListTile(
                                              title: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    filteredCuisines[index].name,
                                                    style: TextStyle(fontSize: 19),
                                                  ),
                                                  Text('₹${filteredCuisines[index].price.toString()}'),
                                                ],
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  print(cart);
                                                  if (cart.map((e) => e.name).contains(filteredCuisines[index].name)) {
                                                    print('remove');
                                                    cart.removeWhere((element) => filteredCuisines[index].name == element.name);
                                                  } else {
                                                    print('add');
                                                    cart.add(filteredCuisines[index]);
                                                  }
                                                });
                                              },
                                            ),
                                          );
                                        },
                                        itemCount: filteredCuisines.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.large(
              onPressed: () async{
                if(cart.isNotEmpty){
                  Order order = Order(cuisines: cart, orderTime: DateTime.now(),status: 'placed',orderNum: 0);
                  await DatabaseServices().placeOrders(order);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order Placed')));
                  setState((){
                    cart=[];
                  });
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Select an item to place order')));
                }
              },
              child: const Icon(Icons.dining_outlined),
            ),
          ],
        ));
  }
}
