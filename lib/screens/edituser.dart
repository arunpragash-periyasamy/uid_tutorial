import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../db/database_connection.dart';
import '../main.dart';
import '../model/user.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var userNameController = TextEditingController();
  var userContactController = TextEditingController();
  var userDescriptionController = TextEditingController();
  var valiadtetext = false;
  var validatecontact = false;
  var validatedescritption = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      userNameController.text = widget.user.name!;
      userContactController.text = widget.user.contact!;
      userDescriptionController.text = widget.user.description!;
    });
  }

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
                  'Edit New Notes',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      color: Colors.teal),
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
                  keyboardType: TextInputType.number,
                  maxLength: 10,
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
                const VerticalDivider(),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          User model = User();
                          model.id = widget.user.id;
                          model.name = userNameController.text.toString();
                          model.contact = userContactController.text.toString();
                          model.description =
                              userDescriptionController.text.toString();
                          userNameController.text.isEmpty
                              ? valiadtetext = true
                              : valiadtetext = false;
                          userContactController.text.isEmpty
                              ? validatecontact = true
                              : validatecontact = false;
                          userDescriptionController.text.isEmpty
                              ? validatedescritption = true
                              : validatedescritption = false;

                          Map<String, dynamic> data = <String, dynamic>{};
                          if (valiadtetext == false &&
                              validatecontact == false &&
                              validatedescritption == false) {
                            data['id'] = model.id;
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
                          DatabaseConnection.updateQuantity(
                              data['id'],
                              data['name'],
                              data['contact'],
                              data['description']);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(17.0),
                                  bottomRight: Radius.circular(17.0)))),
                      child: const Text('Update Details'),
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
