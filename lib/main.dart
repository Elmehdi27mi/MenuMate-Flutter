import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tp_plat1/models/read_image.dart';
import 'package:tp_plat1/pages/update_product_page.dart';
import 'package:tp_plat1/models/produc_model.dart';
import 'package:tp_plat1/pages/add_product_page.dart';
import 'package:tp_plat1/services/service.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: ProductsScreen(),
    ),
  );
}

class ProductsScreen extends StatefulWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isDarkModeEnabled = false;
  List<ShoppingCartItem> itemsList = [];
  int? itemTaille;

  void toggleTheme() {
    setState(() {
      isDarkModeEnabled = !isDarkModeEnabled;
    });
  }

  @override
  void initState() {
    super.initState();
    //addList();
    _loadItems();
  }

  List<List<bool>> isStarFilledList =
      List.generate(1000, (_) => [false, false, false, false, false]);

  void _removeItem(int id) async {
    await ProductDatabase.instance.deleteProduct(id);
    _loadItems();
  }

  void _loadItems() async {
    itemsList = await ProductDatabase.instance.getAllItems();

    setState(() {});
    List<dynamic> items = await ProductDatabase.instance.getAllItems();
    setState(() {
      itemsList = items as List<ShoppingCartItem>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ',
      debugShowCheckedModeBanner: false,
      themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(FontAwesomeIcons
                .barsStaggered), // L'icône du bouton du tiroir latéral
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Ouverture du tiroir latéral
            },
          ),
          title: Text(
            'Dishes',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Josefin Sans',
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: toggleTheme,
              icon: Icon(FontAwesomeIcons.solidMoon),
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return addProduct(
                      itemProduct: ShoppingCartItem(
                          productName: "",
                          productDescription: "",
                          productImage: "",
                          unitPrice: 0.0,
                          quantity: 0,
                          isBuy: false),
                    );
                  }));
                },
                icon: Icon(FontAwesomeIcons.solidSquarePlus,
                    color: Color(0xffF36944)),
              ),
            ),
            const SizedBox(width: 10.0)
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  child: Utility.imageFromBase64String(
                                      itemsList[index].productImage),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      itemsList[index].productName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      itemsList[index].productDescription,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      r"$" +
                                          itemsList[index].unitPrice.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children:
                                              List.generate(5, (starIndex) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isStarFilledList[index]
                                                          [starIndex] =
                                                      !isStarFilledList[index]
                                                          [starIndex];
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 3),
                                                child: Icon(
                                                  isStarFilledList[index]
                                                          [starIndex]
                                                      ? FontAwesomeIcons
                                                          .solidStar
                                                      : FontAwesomeIcons.star,
                                                  size: 15,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                        SizedBox(width: 10),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateProduct(
                                                      itemProduct:
                                                          itemsList[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.squarePen,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () async {
                                                _removeItem(
                                                    itemsList[index].id as int);
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.trash,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
