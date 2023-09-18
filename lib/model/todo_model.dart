class ToDo {
  String? id;
  String? tdtext;
  bool ischeck = false;
  ToDo({
    required this.id,
    required this.tdtext,
    this.ischeck = false,
  });
  static List<ToDo> todoList() {
    return [];
  }

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        id: json["id"],
        tdtext: json["tdtext"],
        ischeck: json["ischeck"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tdtext": tdtext,
        "ischeck": ischeck,
      };
}
