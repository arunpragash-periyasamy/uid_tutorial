import 'package:flutter/material.dart';
import 'package:notestaker/model/user.dart';

class ViewUser extends StatefulWidget {
  final User user;
  const ViewUser({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes Taker'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Full Details',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                    fontSize: 20.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                        fontSize: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      widget.user.name!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  const Text(
                    'Contact',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                        fontSize: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.user.contact!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                'Description',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                    fontSize: 16.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                widget.user.description!,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
