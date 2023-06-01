import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view_model/controller.dart';

class GetxTest extends GetWidget<Controller> {
  var controller = Get.put(Controller());

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    controller.dec();
                  },
                  child: Icon(Icons.remove)),
              Text('${controller.x}'),
              ElevatedButton(
                  onPressed: () {
                    controller.inc();
                  },
                  child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }
}
//GetBuilder
//Getx
//Obx
