class Vehiculo {
  int id;
  String tipo;
  String marca;
  String modelo;
  double kilometraje;
  String imagen;
  String placa;
  String color;

  Vehiculo(this.id, this.tipo, this.marca, this.modelo, this.kilometraje,
      this.imagen, this.placa, this.color);

  Map<String, dynamic> toMap() {
    return {
      "tipo": tipo,
      "marca": marca,
      "modelo": modelo,
      "kilometraje": kilometraje,
      "imagen": imagen,
      "placa": placa,
      "color": color,
    };
  }

  Vehiculo.fromMap(Map<String, dynamic> map) {
    this.tipo = map["tipo"];
    this.marca = map["marca"];
    this.modelo = map["modelo"];
    this.kilometraje = map["kilometraje"];
    this.imagen = map["imagen"];
    this.placa = map["placa"];
    this.color = map["color"];
  }
}
