import 'package:api_assignment/Data/Models/Network_Response.dart';
import 'package:api_assignment/Data/Models/ProductModel.dart';
import 'package:api_assignment/Data/Services/Network_Caller.dart';
import 'package:api_assignment/Data/Utils/Urls.dart';
import 'package:api_assignment/Screen/Add_Product.dart';
import 'package:api_assignment/Widget/ProductCard.dart';
import 'package:flutter/material.dart';

import '../Widget/Custom_AppBar.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool getProgressIndicator = false;
  List getProductList = [];

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return getProduct();
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Visibility(
          visible: !getProgressIndicator,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
              itemCount: getProductList.length,
              itemBuilder: (context, index) {
                return Productcard(
                  productListModel: getProductList[index],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: floatingBTN,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void floatingBTN() async {
    final bool? shouldRefresh = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddProductScreen(),
        ));

    if (shouldRefresh == true) {
      getProduct();
    }
  }

  Future<void> getProduct() async {
    getProgressIndicator = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(Urls.readProduct);
    if (response.isSuccess) {
      final ProductModel productModel =
          ProductModel.fromJson(response.responseData);
      getProductList = productModel.productList ?? [];
    }

    getProgressIndicator = false;
    setState(() {});
  }
}
