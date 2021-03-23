class ShoppingList {
  int id;
  String name;
  int priority;

  ShoppingList(this.id, this.name, this.priority);
  ShoppingList.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["name"];
    this.priority = map["priority"];
  }

  Map<String, dynamic> toMap() {
    return {'id': (id == 0) ? null : id, 'name': name, 'priority': priority};
  }
}
