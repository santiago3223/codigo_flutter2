class ListItem{
  int id;
  int idList;
  String name;
  String quantity;


  ListItem(this.id, this.idList, this.name, this.quantity);

  ListItem.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.idList = map["idList"];
    this.name = map["name"];
    this.quantity = map["quantity"];
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : (id==0)?null: id,
      'idList': idList,
      'name': name,
      'quantity': quantity,
    };
  }
}