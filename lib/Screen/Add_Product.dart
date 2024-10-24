import 'package:api_assignment/Data/Models/Network_Response.dart';
import 'package:api_assignment/Data/Services/Network_Caller.dart';
import 'package:api_assignment/Data/Utils/Urls.dart';
import 'package:api_assignment/Widget/Custom_AppBar.dart';
import 'package:api_assignment/Widget/showSnackberMessage.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController pdtNameCtrl = TextEditingController();
  final TextEditingController pdtCodeCtrl = TextEditingController();
  final TextEditingController pdtQntyCtrl = TextEditingController();
  final TextEditingController pdtUnPriceCtrl = TextEditingController();
  final TextEditingController pdtTlPriceCtrl = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool addProductInprogress = false;
  bool refressPreviousPage = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, refressPreviousPage);
      },
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(child: AddProductForm()),
        ),
      ),
    );
  }

  Widget AddProductForm() {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Add product',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: pdtNameCtrl,
            decoration: InputDecoration(
              hintText: 'Product name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter product name';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: pdtCodeCtrl,
            decoration: InputDecoration(
              hintText: 'Product code',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter product code';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: pdtQntyCtrl,
            decoration: InputDecoration(
              hintText: 'Quantity',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter quantity';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: pdtUnPriceCtrl,
            decoration: InputDecoration(
              hintText: 'Unit Price',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter unit price';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: pdtTlPriceCtrl,
            decoration: InputDecoration(
              hintText: 'Total price',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter total price';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: addProductBTN, child: Text('Add Product'))
        ],
      ),
    );
  }

  void addProductBTN() {
    if (_formkey.currentState!.validate()) {
      addProduct();
    } else {}
  }

  Future<void> addProduct() async {
    addProductInprogress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "ProductName": pdtNameCtrl.text.trim(),
      "ProductCode": pdtCodeCtrl.text,
      "Img": "ss",
      "Qty": pdtQntyCtrl.text,
      "UnitPrice": pdtUnPriceCtrl.text,
      "TotalPrice": pdtTlPriceCtrl.text
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.createProduct, requestBody);

    addProductInprogress = true;
    setState(() {});
    if (response.isSuccess) {
      refressPreviousPage = true;
      clearTextField();
      showSnackBarMessage(context, 'Product successfully added!');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  clearTextField() {
    pdtNameCtrl.clear();
    pdtCodeCtrl.clear();
    pdtQntyCtrl.clear();
    pdtUnPriceCtrl.clear();
    pdtTlPriceCtrl.clear();
  }

  @override
  void dispose() {
    super.dispose();

    pdtNameCtrl.dispose();
    pdtCodeCtrl.dispose();
    pdtQntyCtrl.dispose();
    pdtUnPriceCtrl.dispose();
    pdtTlPriceCtrl.dispose();
  }
}
