import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Controllers/CalculatorController.dart';

class AttendanceCalc extends StatelessWidget {
  final String total;
  final String present;
  // final Size size;
  AttendanceCalc({
    Key? key,
    required this.total,
    required this.present,
  }) : super(key: key);

  final controller = Get.put(CalcController());

  @override
  Widget build(BuildContext context) {
    controller.total.value = int.parse(total);
    controller.present.value = int.parse(present);
    controller.calculate();
    return Column(
      children: [
        Obx(
          () => inputRow(
            context,
            controller.isError.value,
            'Total',
            controller.total.value.toString(),
            controller.totalEditing,
            (value) {
              controller.total.value =
                  int.parse(value.isEmpty || value == "" ? '0' : value);
              if (controller.total.value < controller.present.value) {
                controller.present.value = controller.total.value;
                controller.presentEditing.text =
                    controller.total.value.toString();
                controller.isError.value = true;
              } else {
                controller.isError.value = false;
              }
              controller.calculate();
            },
          ),
        ),
        Obx(
          () => inputRow(
            context,
            controller.isError.value,
            'Present',
            controller.present.value.toString(),
            controller.presentEditing,
            (value) {
              controller.present.value =
                  int.parse(value.isEmpty || value == "" ? '0' : value);
              if (controller.present.value > controller.total.value) {
                controller.isError.value = true;
                controller.present.value = controller.total.value;
                // value = controller.total.value.toString();
              } else {
                controller.isError.value = false;
              }
              if (controller.total.value == 0) {
                controller.isError.value = true;
                controller.presentEditing.text = '0';
              }
              controller.calculate();
            },
          ),
        ),
        Container(
            margin: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Absent",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      // padding: const EdgeInsets.all(5),
                      height: 50,
                      child: Obx(
                        () => Center(
                          child: Text(
                            controller.total.value - controller.present.value >
                                    0
                                ? (controller.total.value -
                                        controller.present.value)
                                    .toString()
                                : '0',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )),
                ])),
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.center,
            child: Obx(
              () => Text(
                "${controller.isBankable.value ? "Canbunk:" : "Required:"} ${controller.result.value}",
                style: TextStyle(
                  fontSize: 20,
                  color:
                      controller.isBankable.value ? Colors.green : Colors.red,
                ),
              ),
            )),
      ],
    );
  }

  Container inputRow(
    BuildContext context,
    bool isError,
    String label,
    String initial,
    TextEditingController txtcontroller,
    void Function(String)? onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.35,
              // padding: const EdgeInsets.all(5),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isError ? Colors.red : Colors.black,
                  width: 1,
                ),
              ),
              child: TextFormField(
                controller: txtcontroller,
                cursorHeight: 25,
                cursorWidth: 1,
                cursorColor: Colors.black,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                ],

                // controller: totalEditing,

                onEditingComplete: () {},
                // onSaved: (value) {
                //   controller.total.value = int.parse(
                //       value!.isEmpty || value == "" ? '0' : value);
                // },
                onChanged: onChanged,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              )),
        ],
      ),
    );
  }
}
