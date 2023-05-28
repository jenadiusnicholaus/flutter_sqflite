import 'package:flutter/material.dart';
import 'package:flutter_crud/data/cruds.dart';
import 'package:flutter_crud/data/database.dart';
import 'package:flutter_crud/data/model.dart';
import 'package:flutter_crud/main.dart';
import 'package:flutter_crud/screens/data_list.dart';

class ContentDetails extends StatefulWidget {
  MemoModel? memoModel;
  ContentDetails({super.key, this.memoModel});

  @override
  State<ContentDetails> createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _titleController =
        TextEditingController(text: widget.memoModel?.title);
    final _contentController =
        TextEditingController(text: widget.memoModel?.content);
    return Scaffold(
      appBar: AppBar(title: const Text("Content list")),
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
                  decoration: const InputDecoration(hintText: "Enter  content"),
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
                          await CRUDS.deleteMemo(
                            db: db,
                            tableName: 'memos',
                            id: widget.memoModel?.id,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  '${widget.memoModel?.title} is deleted')));
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DataList()));
                        },
                        child: const Text(
                          'Detete',
                          style: TextStyle(color: Colors.red),
                        )),
                    OutlinedButton(
                        onPressed: () async {
                          var db = await DatabaseHelper.instance.database;
                          await CRUDS.updateMemo(
                            item: MemoModel(
                              id: widget.memoModel?.id,
                              title: _titleController.text,
                              content: _contentController.text,
                            ),
                            db: db,
                            tableName: 'memos',
                            id: widget.memoModel?.id,
                          );

                          print('  ${_contentController.text}');
                          print('  ${_titleController.text}');

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('${widget.memoModel?.title} Updated')));
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DataList()));
                        },
                        child: const Text('Update')),
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
