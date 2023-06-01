import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:stockat/model/drinks/soft_drinks_model.dart';
import 'package:stockat/service/products_service.dart';

class SoftDrinksViewModel extends GetxController {
  List<SoftDrinksModel> softDrinksModel = [];

  SoftDrinksViewModel() {
    getSoftDrinks();
  }

  getSoftDrinks() async {
    ProductService().getSoftDeinks().then((value) {
      for (int i = 0; i < value.length; i++) {
        softDrinksModel.add(SoftDrinksModel.fromjson(value[i].data()));
      }
      update();
    });
  }
}
