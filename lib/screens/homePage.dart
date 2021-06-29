import 'dart:math';

import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/models/commande.dart';
import 'package:canteen_food_ordering_app/models/food.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/cartPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_util/date_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:localization/localization.dart';
import 'constants.dart';
class HomePage extends StatefulWidget {
  final Commande commande;
  int btnModifier;
  HomePage({Key key, this.commande,this.btnModifier}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String adrL;
  Commande _commande = new Commande();
  List<String> cartIds = new List<String>();
  List<Food> _foodItems = new List<Food>();
  //DropDownWidget createState() => DropDownWidget();
  String matin = 'matin';
  String soir = 'Après midi';
  var rng = new Random();
  TextEditingController adresLivraisonController = TextEditingController();
  TextEditingController autredetailsController = TextEditingController();
  TextEditingController communeController = TextEditingController();
  TextEditingController dateLivraisonController = TextEditingController();
  TextEditingController nbrepoulController = TextEditingController();
  TextEditingController nomprenomController = TextEditingController();
  TextEditingController periodeController = TextEditingController();
  TextEditingController documentidController = TextEditingController();
  TextEditingController quartiersController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController userIdController = TextEditingController();


  var cmdID;
  bool statutLivraison;
  var dropdownValue;
  DateTime pickedDate,pickedDateN;
  String nomPrenom, adresLivraison, quartiers, autreDetail, value, dateLivraison, nbrePoul, tel, periode, commune, bulbColor;
  List<String> spinnerItems = <String>['Abobo', 'Adjamé', 'Anyama', 'Attécoubé','Bassam','Bingerville', 'Cocody', 'Koumassi', 'Marcory',
    'Plateau', 'Port bouët', 'Treichville', 'Songon', 'Yopougon'];

  @override
  void initState() {
    AuthNotifier authNotifier =
    Provider.of<AuthNotifier>(context, listen: false);
    getUserDetails(authNotifier);
    getCart(authNotifier.userDetails.uuid);
    super.initState();
    pickedDate = DateTime.now().add(new Duration(days: 1));
    pickedDateN = DateTime.now().add(new Duration(days: 2));
    //cmdID = cmdID +1;
    statutLivraison = false;
    //On donne la valeur de variable global commande a la variable locale, qu'on utilisera pour afficher les valeurs
    _commande = widget.commande;
    print('initState: Homepage: ${widget.commande}');
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
    Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Commande'),
          automaticallyImplyLeading: false,

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

  Future gettingCommandeData(String _commandeId) {
    if (_commandeId != null && _commandeId != '1')
      return Firestore.instance
          .collection('commande')
          .document(_commandeId)
          .get();
    else
      return null;
  }

  Widget userHome(context) {
    AuthNotifier authNotifier =
    Provider.of<AuthNotifier>(context, listen: false);
    return FutureBuilder<DocumentSnapshot>(
        future:
        gettingCommandeData(_commande != null ? _commande.documentId : '1'),
        builder: (context, snapshot) {
          String commune = "";
          if (snapshot == null || snapshot.data == null) {}
          if (snapshot.data != null && snapshot != null) {
            adresLivraison = adresLivraisonController.text = snapshot.data.data['adresLivraison'];
            autreDetail    = autredetailsController.text = snapshot.data.data['autreDetail'];
            //dropdownValue  =   communeController.selection = snapshot.data.data['commune'];
            //pickedDate     = dateLivraisonController.text = snapshot.data.data['dateLivraison'];
            nbrePoul       = nbrepoulController.text = snapshot.data.data['nbrePoul'].toString();
            nomPrenom      = nomprenomController.text = snapshot.data.data['nomPrenom'];
            //bulbColor      = periodeController.text = snapshot.data.data['periode'].toString();
            tel=  telController.text = snapshot.data.data['tel'];
            quartiers = quartiersController.text = snapshot.data.data['quartiers'];
            //documentId = userIdController.text = snapshot.data.data[''];

          }
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: nomprenomController,
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Nom et prénoms",
                          fillColor: Colors.white,
                          focusedBorder: outlineInputBorder(
                            /*borderSide:BorderSide(color: Colors.blue,
                                        width: 2.0)*/
                          )),
                      onChanged: (String nomPrenom) {
                        getnomPrenom(nomPrenom);
                      },
                    )),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: nbrepoulController,
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      return null;
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
                    controller: telController,
                    keyboardType: TextInputType.number,
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
                    controller: adresLivraisonController,
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
                          nomPrenom = nomprenomController.value.text;
                        });
                      },
                      value: dropdownValue != "" ? dropdownValue : commune,
                      isExpanded: false,
                      hint: Text('Choisissez votre commune'),
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: quartiersController,
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
                    controller: autredetailsController,
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      color: Color.fromRGBO(1, 70, 134, 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Valider'),
                      textColor: Colors.white,
                      onPressed: () {
                        if(widget.btnModifier ==1){
                          print("Mozart est la : .......${widget.btnModifier}");
                          updateData(_commande.documentId);
                        }else{
                          createData();
                          print("Mozart est la : .......${widget.btnModifier}");
                        }
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
                                                                                                                                                  children: <Widget>[                                                                                                                                     ),*/
          );
        });
  }

  void _pickerDate() async {
    var dateUtility = DateUtil();
    int anneEnCours = DateTime.now().year;
    int jourEnCours = DateTime.now().day;
    int moisEnCours = DateTime.now().month;
    int heur = DateTime.now().hour;
    var nbrJourPass = dateUtility.daysPastInYear(moisEnCours, jourEnCours, anneEnCours) ;
    var nbrJourPas = dateUtility.daysPastInYear(moisEnCours, jourEnCours, anneEnCours) +1;
    var rest = (365 - nbrJourPass) - 5;
    var rest1 = (365 - nbrJourPas) - 5;
    DateTime date = await showDatePicker(
      context: context,
      initialDate: heur>=20?pickedDateN:pickedDate,
      firstDate: heur>=20?pickedDateN.subtract(Duration(days: 0)):pickedDate.subtract(Duration(days: 0)),
      lastDate: heur>=20?DateTime(DateTime.now().year+1).subtract(Duration(days: rest)):DateTime(DateTime.now().year+1).subtract(Duration(days: rest1)),
      helpText: "Selectionnez une date de livraison",
      cancelText: "Annuler",
      confirmText: "Ok",
    );
    print("La date restante by mozart :::${rest}");
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

  void getCommune(dropdownValue) {
    this.dropdownValue = dropdownValue;
  }

  void getPeriode(bulbColor) {
    this.bulbColor = bulbColor;
  }
  void getnomPrenom(String nomPrenom) {
    this.nomPrenom = nomPrenom!=""?nomPrenom:nomprenomController.value.text;
  }
  Future<void> createData() async {
    if ((adresLivraison == null) &&
        (autreDetail == null) &&
        (dateLivraison == null) &&
        (quartiers == null) &&
        (bulbColor.toString() == null) &&
        (dropdownValue.toString() == null)) {
      toast("Tous les champs doivent être remplis!!!");
    } else if (int.parse(tel) == null) {
      toast("Le numéro de téléphone doit être un nombre");
    } else if (int.parse(nbrePoul) >= 1500) {
      toast("Nombre limite de commande ne doit pas être supérieure : 1500");
    } else if (tel.length != 10) {
      toast("La longueur du numéro de téléphone doit être 10");
    } else {
      var uuid = Uuid();var documentId = uuid.v4();
      DocumentReference documentReference =
      Firestore.instance.collection("commande").document(documentId);
      FirebaseUser auth = await FirebaseAuth.instance.currentUser();
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
        "periode": bulbColor,
        "userId": auth.uid,
        "cmdID": cmdID,
        "statutLivraison": statutLivraison,
        "documentId": documentId
      };
      documentReference.setData(commande).whenComplete(() {
        toast("La commande de $nomPrenom a étè effectué avec success");
        /*Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return CartPage();
          },   
        ));*/
      });
    }
  }

 Future <void> updateData(String documentId) async {
    print("mozart update est la");
    DocumentReference documentReference =
    Firestore.instance.collection("commande").document(documentId);
    Map<String, dynamic> data = {
      "nomPrenom": nomprenomController,
      "adresLivraison": adresLivraisonController,
      "quartiers": quartiersController,
      "autreDetail": autredetailsController,
      "nbrePoul": nbrepoulController,
      "tel": telController,
      "commune": dropdownValue,
      "dateLivraison": pickedDate,
      "periode": bulbColor,
    };
    documentReference.updateData(data).whenComplete(() {
      toast("La commande de ${nomprenomController.value.text} a étè modifier avec success");
    });
  }
  void tousController(){
    nomPrenom = nomprenomController.value.text;

  }


}
