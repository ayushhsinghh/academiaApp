import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'CalculatorController.dart';

class Calculator extends StatelessWidget {
  Calculator({Key? key}) : super(key: key);

  final controller = Get.put(CalcController());
  // var presentEditing = TextEditingController();
  // var totalEditing = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Calculator'),
      ),
      backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                        width: 200,
                        padding: EdgeInsets.all(5),
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          initialValue: '0',
                          cursorHeight: 25,
                          cursorWidth: 1,
                          cursorColor: Colors.black,
                          maxLength: 2,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          // controller: totalEditing,

                          onEditingComplete: () {},
                          onSaved: (value) async {
                            if (value == "") {
                              controller.total.value = int.parse('0');
                              controller.calculate();
                            }
                            controller.total.value = int.parse(value!);
                            controller.calculate();
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Present",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                        width: 200,
                        height: 60,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          initialValue: '0',
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          // maxLengthEnforcement:
                          //     MaxLengthEnforcement.enforced,
                          onSaved: (value) {
                            if (value == "") {
                              controller.present.value = int.parse('0');
                              controller.calculate();
                            }
                            controller.present.value = int.parse(value!);
                            controller.calculate();
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: Obx(
                    () => Text(
                      "${controller.result.value}",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red[700],
            // maximumSize: Size.fromHeight(double.infinity),
          ),
          child: Text(
            "Calculate",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onPressed: () {
            controller.calculate();
          },
        ),
      ),
    );
  }
}
