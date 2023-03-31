import 'package:flutter/material.dart';
import 'package:notestaker/model/user.dart';
import 'package:notestaker/screens/adduser.dart';
import 'package:notestaker/screens/edituser.dart';
import 'package:notestaker/screens/viewuser.dart';

import 'db/database_connection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes Taker',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ToDoApp(),
    );
  }
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Notes Taker')),
        ),
        body: FutureBuilder<List<User>>(
            future: DatabaseConnection.fetchMemos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<User>? data = snapshot.data;
                if (data!.isEmpty) {
                  return const Center(child: Text("Data is empty"));
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    User user = data[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewUser(
                                    user: data[index],
                                  )),
                        );
                      },
                      leading: const Icon(Icons.person),
                      title: Text(user.name.toString()),
                      subtitle: Text(user.contact.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditUser(
                                          user: data[index],
                                        )),
                              );
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                DatabaseConnection.deleteMemo(user.id!);
                              });
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                          )
                        ],
                      ),
                    );
                  },
                );
              }
              return const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 10,
              ));
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const AddUser()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
