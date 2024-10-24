class ProductModel {
  String? status;
  List<ProductListModel>? productList;

  ProductModel({this.status, this.productList});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      productList = <ProductListModel>[];
      json['data'].forEach((v) {
        productList!.add(new ProductListModel.fromJson(v));
      });
    }
  }

}

class ProductListModel {
  String? sId;
  String? productName;
  int? productCode;
  String? img;
  int? qty;
  int? unitPrice;
  int? totalPrice;

  ProductListModel(
      {this.sId,
      this.productName,
      this.productCode,
      this.img,
      this.qty,
      this.unitPrice,
      this.totalPrice});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    img = json['Img'];
    qty = json['Qty'];
    unitPrice = json['UnitPrice'];
    totalPrice = json['TotalPrice'];
  }

}
