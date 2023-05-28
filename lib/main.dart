import 'package:flutter/material.dart';
import 'package:flutter_crud/data/cruds.dart';
import 'package:flutter_crud/data/database.dart';
import 'package:flutter_crud/data/model.dart';
import 'package:flutter_crud/screens/data_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: "Enter title"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This fied is required';
                      }
                    },
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.amber,
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration:
                        const InputDecoration(hintText: "Enter  content"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This fied is required';
                      }
                    },
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                          onPressed: () async {
                            var db = await DatabaseHelper.instance.database;
                            var tableName = 'memos';
                            var item = MemoModel(
                              title: _titleController.text,
                              content: _contentController.text,
                            );
                            await CRUDS.addItem(
                              item: item,
                              db: db,
                              tableName: tableName,
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("added"),
                            ));
                          },
                          child: const Text('Add')),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataList()));
                          },
                          child: const Text('View data list'))
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
