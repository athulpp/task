import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shop/model/product_model.dart';

class ProductList extends StatelessWidget {
  ProductList({Key? key}) : super(key: key);

  Future<ProductModel> getProductsApi() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print();
      return ProductModel.fromSnap(data);
    } else {
      return ProductModel(products: []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductModel>(
        future: getProductsApi(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          print(snapshot.data!.products!.length);
          return ListView.separated(
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: Text(snapshot.data!.products!.length.toString()),
                );
              }),
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: snapshot.data!.products!.length);
        });
  }
}
