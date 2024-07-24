import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp_plat1/main.dart';
import 'package:tp_plat1/models/produc_model.dart';
import 'package:tp_plat1/models/read_image.dart';
import 'package:tp_plat1/services/service.dart';
import 'package:tp_plat1/widgets/custem_text_form_field.dart';

class addProduct extends StatefulWidget {
  ShoppingCartItem itemProduct;
  addProduct({Key? key, required this.itemProduct}) : super(key: key);

  @override
  _addProductState createState() => _addProductState();
}

class _addProductState extends State<addProduct> {
  void _addItem() async {
    await ProductDatabase.instance.insertProduct(widget.itemProduct);
    setState(() {});
  }

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('add Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                          CustemTextFormField(
                            labelText: "Product Name",
                            hintText: widget.itemProduct.productName,
                            onChanged: (data) {
                              widget.itemProduct.productName =
                                  data ?? widget.itemProduct.productName;
                            },
                          ),
                          SizedBox(height: 10),
                          CustemTextFormField(
                            labelText: "Product Price",
                            textInputType: TextInputType.number,
                            hintText: '${widget.itemProduct.unitPrice}',
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
                          CustemTextFormField(
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
                          CustemTextFormField(
                            labelText: "Product Desccription",
                            hintText: widget.itemProduct.productDescription,
                            onChanged: (data) {
                              widget.itemProduct.productDescription =
                                  data ?? widget.itemProduct.productDescription;
                            },
                          ),
                          SizedBox(height: 10),
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
                              if (formKey.currentState!.validate()) {
                                _addItem();
                                print(widget.itemProduct);
                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProductsScreen();
                                }));
                              }
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
      ),
    );
  }
}
