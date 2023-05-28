class MemoModel {
  final dynamic id;
  final dynamic title;
  final dynamic content;

  MemoModel({this.id, this.title, this.content});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "id": id,
      "title": title,
      "content": content,
    };
  }

  factory MemoModel.toJson(Map<String, dynamic> json) {
    return MemoModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
}
