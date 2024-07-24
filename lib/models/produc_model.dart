class ShoppingCartItem {
  int? id; // Modifier en int? pour permettre l'auto-incrémentation
  String productName;
  String productDescription;
  String productImage;
  double unitPrice;
  bool isBuy;
  int quantity;

  ShoppingCartItem({
    this.id, // Modifier en int? pour permettre l'auto-incrémentation
    required this.productName,
    required this.productDescription,
    required this.productImage,
    required this.unitPrice,
    required this.quantity,
    this.isBuy = false,
  });

  Map<String, dynamic> toMap() {
    return {
      // Ne pas inclure le productId lors de l'insertion pour permettre l'auto-incrémentation
      'productName': productName,
      'productDescription': productDescription,
      'productImage': productImage,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'isBuy': isBuy ? 1 : 0,
    };
  }

  static ShoppingCartItem fromMap(Map<String, dynamic> map) {
    return ShoppingCartItem(
      id: map['id'],
      productName: map['productName'],
      productDescription: map['productDescription'],
      productImage: map['productImage'],
      unitPrice: map['unitPrice'],
      quantity: map['quantity'],
      isBuy: map['isBuy'] == 1,
    );
  }
}




/*


 List<ShoppingCartItem> itemsList1 = [
    ShoppingCartItem(
      productName: 'Fried Fish Burger',
      productDescription: 'Served with fries & coleslaw',
      productImage:
          'https://taytocafe.com/delivery/assets/products/642da78b9bac1_Double-Tangy-B.png',
      unitPrice: 30,
      quantity: 40,
      isBuy: true,
    ),
    ShoppingCartItem(
        productName: 'Loaded Beef Jalapeno',
        productDescription: '200g Premium beef with jalapeno sauce',
        productImage:
            'https://taytocafe.com/delivery/assets/products/642da91abab43_Loaded-Chicken-Jalapeno-B.png',
        unitPrice: 30,
        quantity: 40),
    ShoppingCartItem(
        productId: 3,
        productName: 'Crispy Penny Pasta',
        productDescription:
            'Creamy mushroom sauce with three types of bell pepper mushrooms & fried breast fillet',
        productImage:
            'https://taytocafe.com/delivery/assets/products/1671690922.png',
        unitPrice: 50,
        quantity: 40),
    ShoppingCartItem(
        productName: 'Moroccan Fish',
        productDescription:
            "Fried filet of fish served with Moroccan sauce sided by veggies & choice of side",
        productImage:
            'https://taytocafe.com/delivery/assets/products/1671691271.png',
        unitPrice: 20,
        quantity: 40),
    ShoppingCartItem(
        productName: 'Creamy Chipotle',
        productDescription: 'Grilled chicken fillet topped with chipotle sauce',
        productImage:
            'https://taytocafe.com/delivery/assets/products/6569bee77d7c2_12.png',
        unitPrice: 40,
        quantity: 40),
    ShoppingCartItem(
        productName: 'Onion Rings',
        productDescription:
            '10 imported crumbed onion rings served with chilli garlic sauce',
        productImage:
            'https://taytocafe.com/delivery/assets/products/1671634436.png',
        unitPrice: 5,
        quantity: 40),
    ShoppingCartItem(
        productName: 'Pizza Fries',
        productDescription:
            'French fries topped with chicken chunks & pizza sauce with Nachos & cheese',
        productImage:
            'https://taytocafe.com/delivery/assets/products/1671634207.png',
        unitPrice: 10,
        quantity: 40),
  ];

  Future<void> addList() async {
    ProductDatabase.instance.insertItemsList(itemsList1);
  }

*/