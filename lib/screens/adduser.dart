import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notestaker/db/database_connection.dart';
import 'package:notestaker/model/user.dart';
import 'package:notestaker/main.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var userNameController = TextEditingController();
  var userContactController = TextEditingController();
  var userDescriptionController = TextEditingController();
  var valiadtetext = false;
  var validatecontact = false;
  var validatedescritption = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Center(
            child: Text('Notes Taker'),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New Notes',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      color: Colors.green),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Enter Name",
                    labelText: "Name",
                    errorText: valiadtetext ? "Name can't empty" : null,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: userContactController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Enter Contact",
                      labelText: "Contact",
                      errorText:
                          validatecontact ? "Contact can't empty" : null),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: userDescriptionController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Enter Description",
                      labelText: "Description",
                      errorText: validatedescritption
                          ? "Description can't empty"
                          : null),
                  maxLines: 5,
                  minLines: 1,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          userNameController.text.isEmpty
                              ? valiadtetext = true
                              : valiadtetext = false;
                          userContactController.text.isEmpty
                              ? validatecontact = true
                              : validatecontact = false;
                          userDescriptionController.text.isEmpty
                              ? validatedescritption = true
                              : validatedescritption = false;

                          User model = User();
                          model.name = userNameController.text.toString();
                          model.contact = userContactController.text.toString();
                          model.description =
                              userDescriptionController.text.toString();
                          Map<String, dynamic> data = <String, dynamic>{};
                          if (valiadtetext == false &&
                              validatecontact == false &&
                              validatedescritption == false) {
                            data['name'] = model.name;
                            data['contact'] = model.contact;
                            data['description'] = model.description;
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ToDoApp(),
                              ),
                              (Route route) => false,
                            );
                          }

                          DatabaseConnection.addUser(data).then((value) => {
                                debugPrint(
                                    'SHOW LOCAL DATABASE RECORD ADDED STATUS: $value')
                              });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(17.0),
                                  bottomRight: Radius.circular(17.0)))),
                      child: const Text('Save Details'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userNameController.text = '';
                        userContactController.text = '';
                        userDescriptionController.text = '';
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(17.0),
                                  bottomRight: Radius.circular(17.0)))),
                      child: const Text('Clear Details'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
