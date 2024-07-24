import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp_plat1/main.dart';
import 'package:tp_plat1/models/produc_model.dart';
import 'package:tp_plat1/models/read_image.dart';
import 'package:tp_plat1/services/service.dart';
import 'package:tp_plat1/widgets/custom_text_field.dart';

class UpdateProduct extends StatefulWidget {
  ShoppingCartItem itemProduct;
  UpdateProduct({Key? key, required this.itemProduct}) : super(key: key);

  @override
  _updateProductState createState() => _updateProductState();
}

class _updateProductState extends State<UpdateProduct> {
  void _updateItem() async {
    await ProductDatabase.instance.updateProduct(widget.itemProduct);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 5), // Changement d'offset pour l'ombre
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          labelText: "Product Name",
                          hintText: widget.itemProduct.productName,
                          onChanged: (data) {
                            widget.itemProduct.productName =
                                data ?? widget.itemProduct.productName;
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          labelText: "Product Price",
                          hintText: '${widget.itemProduct.unitPrice}',
                          textInputType: TextInputType.numberWithOptions(
                              decimal: true), // Permet les valeurs décimales
                          onChanged: (data) {
                            try {
                              final doublePrice = double.parse(data);
                              setState(() {
                                widget.itemProduct.unitPrice = doublePrice;
                              });
                            } catch (e) {
                              print("Erreur de conversion en double: $e");
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          labelText: "Product Quantity",
                          hintText: '${widget.itemProduct.quantity}',
                          textInputType: TextInputType.number,
                          onChanged: (data) {
                            try {
                              final intQuantity = int.parse(data);
                              setState(() {
                                widget.itemProduct.quantity = intQuantity;
                              });
                            } catch (e) {
                              print("Erreur de conversion en int: $e");
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          labelText: "Product Descrption",
                          hintText: widget.itemProduct.productDescription,
                          onChanged: (data) {
                            widget.itemProduct.productDescription =
                                data ?? widget.itemProduct.productDescription;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            ImagePicker()
                                .pickImage(source: ImageSource.gallery)
                                .then(
                              (imgFile) async {
                                if (imgFile != null) {
                                  widget.itemProduct.productImage =
                                      Utility.base64String(
                                              await imgFile.readAsBytes()) ??
                                          widget.itemProduct.productImage;
                                  setState(() {});
                                }
                              },
                            );
                          },
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.solidImage,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            _updateItem();
                            Navigator.pop(context);

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProductsScreen();
                            }));
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
