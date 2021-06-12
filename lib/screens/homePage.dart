import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/models/order.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canteen_food_ordering_app/models/food.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> cartIds = new List<String>();
  List<Food> _foodItems = new List<Food>();
  //DropDownWidget createState() => DropDownWidget();
  String matin = 'matin';
  String soir = 'Après midi';
  var dropdownValue;
  DateTime pickedDate;
  String nomPrenom,adresLivraison,quartiers,autreDetail,value,dateLivraison,nbrePoul, tel;
  bool periode;
     String bulbColor = '';
  List<String> spinnerItems = <String>[
    'Abobo',
    'Adjamé',
    'Anyama',
    'Attécoubé',
    'Bingerville',
    'Cocody',
    'Koumassi',
    'Marcory',
    'Plateau',
    'Port bouët',
    'Treichville',
    'Songon',
    'Yopougon'
  ];
  /*Order _order = new Order(nomPrenom, nbreDePoulets, tel, adresseLivraison,
      commune, quartier, autreDetail, dateLivraison, periode);*/

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getUserDetails(authNotifier);
    getCart(authNotifier.userDetails.uuid);
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Commande'),
        ),
        // ignore: unrelated_type_equality_checks
        body: (authNotifier.userDetails.uuid == Null)
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text("No Items to display"),
              )
            : userHome(context));
  }

  Widget userHome(context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: 
            Text(
                  nomPrenom =  authNotifier.userDetails.displayName+" "+authNotifier.userDetails.displayLastName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'MuseoModerno',
                      fontWeight: FontWeight.bold,
                    ),
                  )
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              validator: (String value) {
                return null;
              },
              onSaved: (String value) {
                //_user.displayName = value;
              },
              decoration: InputDecoration(
                  labelText: "Nombre de poulets",
                  fillColor: Colors.white,
                  focusedBorder: outlineInputBorder(
                      /*borderSide:BorderSide(color: Colors.blue,
                                    width: 2.0)*/
                      )),
              onChanged: (String nbrP) {
                getNombrePoulets(nbrP);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              validator: (String value) {
                return null;
              },
              onSaved: (String value) {
                //_user.displayName = value;
              },
              decoration: InputDecoration(
                  labelText: "Numero du récipiendaire",
                  fillColor: Colors.white,
                  focusedBorder: outlineInputBorder(
                      /*borderSide:BorderSide(color: Colors.blue,
                                                    width: 2.0)*/
                      )),
              onChanged: (String tele) {
                getTelephone(tele);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              keyboardType: TextInputType.name,
              validator: (String value) {
                return null;
              },
              onSaved: (String value) {
                //_user.displayName = value;
              },
              decoration: InputDecoration(
                  labelText: "Adresse de livraison",
                  fillColor: Colors.white,
                  focusedBorder: outlineInputBorder(
                      /*borderSide:BorderSide(color: Colors.blue,
                                                                    width: 2.0)*/
                      )),
              onChanged: (String adLivraison) {
                getAdresseLivraison(adLivraison);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                items: spinnerItems
                    .map((value) => DropdownMenuItem(
                          child: Text(
                            value,
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                          value: value,
                        ))
                    .toList(),
                onChanged: (selectedAccountType) {
                  setState(() {
                    dropdownValue = selectedAccountType;
                  });
                },
                value: dropdownValue,
                isExpanded: false,
                hint: Text('Choisissez votre commune'),
                style: TextStyle(color: Color(0xff11b719)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              keyboardType: TextInputType.name,
              validator: (String value) {
                return null;
              },
              onSaved: (String value) {
                //_user.displayName = value;
              },
              decoration: InputDecoration(
                  labelText: "Quartier",
                  fillColor: Colors.white,
                  focusedBorder: outlineInputBorder(
                      /*borderSide:BorderSide(color: Colors.blue,
                                                                                                    width: 2.0)*/
                      )),
              onChanged: (String quartier) {
                getQuartier(quartier);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              keyboardType: TextInputType.name,
              validator: (String value) {
                return null;
              },
              onSaved: (String value) {
                //_user.displayName = value;
              },
              decoration: InputDecoration(
                  labelText: "Autres détails",
                  fillColor: Colors.white,
                  focusedBorder: outlineInputBorder(
                      /*borderSide:BorderSide(color: Colors.blue,
                                                                                                                    width: 2.0)*/
                      )),
              onChanged: (String autreDet) {
                getAutreDetails(autreDet);
              },
            ),
          ),
          ListTile(
            title: Text(
                "Date de livraison : ${pickedDate.day}/ ${pickedDate.month}/ ${pickedDate.year}"),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: _pickerDate,
          ),
          Text(
            " Sélectionner votre periode de livraison !",
          ),
          
                          Container(
                            width: 280,
                            child: Row(
                              children: <Widget>[
                                Radio(
                                    value: matin,
                                    groupValue: bulbColor,
                                    onChanged: (val) {
                                      bulbColor = val;
                                      setState(() {});
                                    }),
                                Text('Matin (7H30 - 12H30)')
                              ],
                            ),
                          ),
                          Container(
                            width: 280,
                            child: Row(
                              children: <Widget>[
                                Radio(
                                    value: soir,
                                    groupValue: bulbColor,
                                    onChanged: (val) {
                                      bulbColor = val;
                                      setState(() {});
                                    }),
                                Text('Aprés midi (13H00 - 18H00)')
                              ],
                            ),
                          ),

          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                color: Color.fromRGBO(1, 70, 134, 1.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text('Valider'),
                textColor: Colors.white,
                onPressed: () {
                  createData();
                },
              )
            ],
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
      /*child: Column(
                                                                                                                                              children: <Widget>[
                                                                                                                                                Card(
                                                                                                                                                  child: TextField(
                                                                                                                                                    decoration: InputDecoration(
                                                                                                                                                        prefixIcon: Icon(Icons.search), hintText: 'Search...'),
                                                                                                                                                    onChanged: (val) {
                                                                                                                                                      setState(() {
                                                                                                                                                        name = val;
                                                                                                                                                      });
                                                                                                                                                    },
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                                StreamBuilder<QuerySnapshot>(
                                                                                                                                                stream: Firestore.instance.collection('items').where('total_qty', isGreaterThan: 0).snapshots(),
                                                                                                                                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                                                                                                  if (snapshot.hasData && snapshot.data.documents.length > 0 ) {
                                                                                                                                                    _foodItems = new List<Food>();
                                                                                                                                                    snapshot.data.documents.forEach((item) {
                                                                                                                                                      _foodItems.add(Food(item.documentID, item['item_name'], item['total_qty'], item['price']));
                                                                                                                                                    });
                                                                                                                                                    List<Food> _suggestionList = (name == '' || name == null) ? _foodItems
                                                                                                                                                      : _foodItems.where((element) => element.itemName.toLowerCase().contains(name.toLowerCase())).toList();
                                                                                                                                                    if(_suggestionList.length > 0){
                                                                                                                                                      return Container(
                                                                                                                                                        margin: EdgeInsets.only(top: 10.0),
                                                                                                                                                        child:ListView.builder(
                                                                                                                                                          shrinkWrap: true,
                                                                                                                                                          physics: const NeverScrollableScrollPhysics(),
                                                                                                                                                          itemCount: _suggestionList.length,
                                                                                                                                                          itemBuilder: (context, int i) {
                                                                                                                                                          return ListTile(
                                                                                                                                                            title: Text(_suggestionList[i].itemName ?? ''),
                                                                                                                                                            subtitle: Text('cost: ${_suggestionList[i].price.toString()}'),
                                                                                                                                                            trailing: IconButton(
                                                                                                                                                              icon: cartIds.contains(_suggestionList[i].id)? new Icon(Icons.remove):new Icon(Icons.add),
                                                                                                                                                              onPressed: () async{
                                                                                                                                                                cartIds.contains(_suggestionList[i].id)? 
                                                                                                                                                                await removeFromCart(_suggestionList[i], context) : await addToCart(_suggestionList[i], context);
                                                                                                                                                                setState(() {
                                                                                                                                                                  getCart(authNotifier.userDetails.uuid);
                                                                                                                                                                });
                                                                                                                                                              },
                                                                                                                                                            )
                                                                                                                                                          );
                                                                                                                                                        }),
                                                                                                                                                      );
                                                                                                                                                    } else {
                                                                                                                                                      return Container(
                                                                                                                                                        padding: EdgeInsets.symmetric(vertical: 20),
                                                                                                                                                        width: MediaQuery.of(context).size.width * 0.6,
                                                                                                                                                        child: Text("No Items to display"),
                                                                                                                                                      );
                                                                                                                                                    }
                                                                                                                                                  } else {
                                                                                                                                                    return Container(
                                                                                                                                                      padding: EdgeInsets.symmetric(vertical: 20),
                                                                                                                                                      width: MediaQuery.of(context).size.width * 0.6,
                                                                                                                                                      child: Text("No Items to display"),
                                                                                                                                                    );
                                                                                                                                                  }
                                                                                                                                                },
                                                                                                                                              ),
                                                                                                                                            ],
                                                                                                                                          ),*/
    );
  }

  void _pickerDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      helpText: "Selectionnez une date de livraison",
      cancelText: "Annuler",
      confirmText: "Ok",
    );
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  void getCart(String uuid) async {
    List<String> ids = new List<String>();
    QuerySnapshot snapshot = await Firestore.instance
        .collection('carts')
        .document(uuid)
        .collection('items')
        .getDocuments();
    var data = snapshot.documents;
    for (var i = 0; i < data.length; i++) {
      ids.add(data[i].documentID);
    }
    setState(() {
      cartIds = ids;
    });
  }

  /*void getUserNam(name) {
   /* name =  authNotifier.userDetails.displayName +
                    " " +
                    authNotifier.userDetails.displayLastName;*/
    this.nomPrenom = name;
  }*/

  void getNombrePoulets(nbrP) {
    this.nbrePoul = nbrP;
  }

  void getTelephone(tele) {
    this.tel = tele;
  }

  void getAdresseLivraison(adLivraison) {
    this.adresLivraison = adLivraison;
  }

  void getQuartier(quartier) {
    this.quartiers = quartier;
  }

  void getAutreDetails(autreDet) {
    this.autreDetail = autreDet;
  }

  void createData() {
   /* if(tel != 10){
      toast("Contact number length must be 10");
    } else if(tel == null){
      toast("Contact number must be a number");
    } else if(nbrePoul == 1500){
      toast("Nombre limite de commande ne doit pas être supérieure : 1500");
    } else {*/
      print("mozart est la");
    DocumentReference documentReference =
        Firestore.instance.collection("commande").document();
    // create Map
    Map<String, dynamic> commande = {
      "nomPrenom": nomPrenom,
      "adresLivraison": adresLivraison,
      "quartiers": quartiers,
      "autreDetail": autreDetail,
      "nbrePoul": nbrePoul,
      "tel": tel,
      "commune": dropdownValue,
      "dateLivraison": pickedDate,
      "periode": bulbColor
    };

    documentReference.setData(commande).whenComplete(() {
            toast("La commande de $nomPrenom a étè effectué avec success");
    });
    /*}*/
  }
 void updateData() {
   /* if(tel != 10){
      toast("Contact number length must be 10");
    } else if(tel == null){
      toast("Contact number must be a number");
    } else if(nbrePoul == 1500){
      toast("Nombre limite de commande ne doit pas être supérieure : 1500");
    } else {*/
      print("mozart update est la");
    DocumentReference documentReference =
        Firestore.instance.collection("commande").document();
    // create Map
    Map<String, dynamic> commande = {
      "nomPrenom": nomPrenom,
      "adresLivraison": adresLivraison,
      "quartiers": quartiers,
      "autreDetail": autreDetail,
      "nbrePoul": nbrePoul,
      "tel": tel,
      "commune": dropdownValue,
      "dateLivraison": pickedDate,
      "periode": bulbColor
    };

    documentReference.setData(commande).whenComplete(() {
            toast("La commande de $nomPrenom a étè modifier avec success");
    });
    /*}*/
  }

}
