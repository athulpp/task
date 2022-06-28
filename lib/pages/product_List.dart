import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shop/model/product_model.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future<ProductModel> getProductsApi() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    Map<String, dynamic> data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(data);
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductModel>(
        future: getProductsApi(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('No data'),
              ),
            );
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
