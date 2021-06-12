class OrderItem {
  String itemName;
  int price;
  String id;
  int count;

  OrderItem(this.id, this.itemName, this.count, this.price);
  
}

class Order{
  //List<OrderItem> items;

  String nomPrenom;
  int nbreDePoulets;
  int tel;
  String adresseLivraison;
  String commune;
  //List<>
  String quartier;
  String autreDetail;
  String dateLivraison;
  bool periode;

  Order(this.nomPrenom, this.nbreDePoulets, this.tel,
   this.adresseLivraison, this.commune, this.quartier, this.autreDetail, this.dateLivraison, this.periode);

}
