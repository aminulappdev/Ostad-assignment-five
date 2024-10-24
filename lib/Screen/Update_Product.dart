import 'package:api_assignment/Data/Models/Network_Response.dart';
import 'package:api_assignment/Data/Services/Network_Caller.dart';
import 'package:api_assignment/Data/Utils/Urls.dart';
import 'package:api_assignment/Widget/Custom_AppBar.dart';
import 'package:flutter/material.dart';

import '../Widget/showSnackberMessage.dart';

class UpdateProductScreen extends StatefulWidget {
  UpdateProductScreen({
    super.key,
    required this.product_id,
    required this.productName,
    required this.productCode,
    required this.productQuantity,
    required this.productUnitPrice,
    required this.productTotalPrice,
  });
  String product_id;
  String productName;
  String productCode;
  String productQuantity;
  String productUnitPrice;
  String productTotalPrice;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController pdtNameCtrl = TextEditingController();
  final TextEditingController pdtCodeCtrl = TextEditingController();
  final TextEditingController pdtQntyCtrl = TextEditingController();
  final TextEditingController pdtUnPriceCtrl = TextEditingController();
  final TextEditingController pdtTlPriceCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pdtNameCtrl.text = widget.productName;
    pdtCodeCtrl.text = widget.productCode;
    pdtQntyCtrl.text = widget.productQuantity;
    pdtUnPriceCtrl.text = widget.productUnitPrice;
    pdtTlPriceCtrl.text = widget.productTotalPrice;

  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool updateInprogress = false;
  bool refressUpdatePreviousPage = false;

  

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(didPop)
        {
          return;
        }
        Navigator.pop(context, refressUpdatePreviousPage);
      },
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(child: UpdateProductForm()),
        ),
      ),
    );
  }

  Widget UpdateProductForm() {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Update product',
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
          Visibility(
            visible: !updateInprogress,
            replacement: const Center(child: CircularProgressIndicator(),),
            child: ElevatedButton(onPressed: updateProductBTN, child: const Text('Update')))
        ],
      ),
    );
  }

  void updateProductBTN() {
    if (_formkey.currentState!.validate()) {
      updateProduct();
    }
  }

  Future<void> updateProduct() async {
    updateInprogress = true;
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
        await NetworkCaller.updateRequest('${Urls.updateProduct}/${widget.product_id}', requestBody);

    updateInprogress = false;
    setState(() {});

    if (response.isSuccess) {
      refressUpdatePreviousPage = true;
      clearTextField();
      showSnackBarMessage(context, 'Product successfully Updated!');
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
