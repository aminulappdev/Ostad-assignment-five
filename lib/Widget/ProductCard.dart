import 'package:api_assignment/Data/Models/Network_Response.dart';
import 'package:api_assignment/Data/Models/ProductModel.dart';
import 'package:api_assignment/Data/Services/Network_Caller.dart';
import 'package:api_assignment/Data/Utils/Urls.dart';
import 'package:api_assignment/Widget/showSnackberMessage.dart';
import 'package:flutter/material.dart';
import '../Screen/Update_Product.dart';

// ignore: must_be_immutable
class Productcard extends StatefulWidget {
  Productcard({super.key, required this.productListModel});

  ProductListModel productListModel;
  @override
  State<Productcard> createState() => _ProductcardState();
}

class _ProductcardState extends State<Productcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [product_image(), product_info()],
      ),
    );
  }

  Widget product_info() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.productListModel.productName ?? '',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Code : ${widget.productListModel.productCode}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
          Text("Quantity : ${widget.productListModel.qty} pics"),
          Text("Unit Price : ${widget.productListModel.unitPrice}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.productListModel.totalPrice} Taka",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Wrap(
                children: [
                  IconButton(
                    onPressed: editProductBTN,
                    icon: const Icon(Icons.edit),
                    color: const Color.fromARGB(255, 7, 131, 11),
                  ),
                  IconButton(
                    onPressed: deleteProductBTN,
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ));
  }

  Widget product_image() {
    return Container(
      height: 130,
      width: 150,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: widget.productListModel.img == "ss"
                  ? const AssetImage("assets/computer.jpg")
                  : NetworkImage(widget.productListModel.img.toString()),
              fit: BoxFit.fill),
          color: const Color.fromARGB(255, 132, 15, 27),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  void deleteProductBTN() async {
    NetworkResponse response = await NetworkCaller.deleteRequest(
        '${Urls.deleteProduct}/${widget.productListModel.sId}');
    if (response.isSuccess) {
      showSnackBarMessage(context, 'Deleted Success!');
      setState(() {});
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  void editProductBTN() async {
    bool? shouldRefress = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateProductScreen(
            product_id: widget.productListModel.sId.toString(),
            productName: widget.productListModel.productName.toString(),
            productCode: widget.productListModel.productCode.toString(),
            productQuantity: widget.productListModel.qty.toString(),
            productUnitPrice: widget.productListModel.unitPrice.toString(),
            productTotalPrice: widget.productListModel.totalPrice.toString(),
          ),
        ));

    if (shouldRefress == true) {
      setState(() {});
    }
  }
}
