import 'package:cartzy/data/models/wished_product.dart';

class WishList {
  String? msg;
  List<WishedProduct>? products;

  WishList({this.msg, this.products});

  WishList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      products = <WishedProduct>[];
      json['data'].forEach((v) {
        products!.add(WishedProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['msg'] = msg;
    if (products != null) {
      data['data'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



