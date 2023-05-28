import 'package:flutter/material.dart';
import 'package:flutter_crud/data/content_details.dart';
import 'package:flutter_crud/data/cruds.dart';
import 'package:flutter_crud/data/database.dart';
import 'package:flutter_crud/data/model.dart';

class DataList extends StatefulWidget {
  const DataList({super.key});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Data list')),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 34),
            child: FutureBuilder(
                future: CRUDS.fetchMemos(tableName: 'memos'),
                builder: (context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              snapshot.data?[index]?.title ?? 'loading...'),
                          subtitle: Text(
                              snapshot.data?[index]?.content.toString() ??
                                  'loading...'),
                          trailing: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContentDetails(
                                      memoModel: MemoModel(
                                          id: snapshot.data?[index]?.id ?? '',
                                          title: snapshot.data?[index]?.title ??
                                              '',
                                          content:
                                              snapshot.data?[index]?.content ??
                                                  ''),
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Edit")),
                        );
                      });
                }),
          ),
        ));
  }
}
