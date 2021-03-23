class ListItem{
  int id;
  int idList;
  String name;
  String quantity;


  ListItem(this.id, this.idList, this.name, this.quantity);

  Map<String, dynamic> toMap(){
    return {
      'id' : (id==0)?null: id,
      'idList': idList,
      'name': name,
      'quantity': quantity,
    };
  }
}