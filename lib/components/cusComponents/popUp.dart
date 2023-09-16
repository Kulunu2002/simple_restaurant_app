import 'package:flutter/material.dart';
import 'package:food_app/controllers/cusController.dart';
import 'package:get/get.dart';

class PopUpForm extends StatefulWidget {
  const PopUpForm({super.key});

  @override
  State<PopUpForm> createState() => _PopUpFormState();
}

class _PopUpFormState extends State<PopUpForm> {
  CustomerController customerController = Get.find<CustomerController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void update() async {
    String? id = customerController.customerM.value.id;
    var result = await customerController.updateDetails(
        id: id, name: nameController.text, mobile: mobileController.text ,email:emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            controller: mobileController,
            decoration: const InputDecoration(labelText: 'Mobile'),
          ),
          ElevatedButton(
            onPressed: () {
              update();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
    ;
  }
}
