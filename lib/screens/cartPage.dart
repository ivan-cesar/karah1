import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/models/cart.dart';
import 'package:canteen_food_ordering_app/models/commande.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/widgets/customRaisedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double sum = 0;
  int itemsCount = 0;
  Commande commande = new Commande();
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getUserDetails(authNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Tableau de bord'),
        ),
        // ignore: unrelated_type_equality_checks
        body: (authNotifier.userDetails.uuid == Null)
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text("No Items to display"),
              )
            : cartList(context));
  }

  Widget cartList(context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    // String userId;
    // Future.delayed(const Duration(milliseconds: 500), () async {
    //   FirebaseAuth.instance.currentUser().then((value) {
    //     // setState(() {
    //     print(userId);
    //     userId = value.uid;
    //     // });
    //   });
    // });

    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('commande')
            .where("userId", isEqualTo: authNotifier.user.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //print("${snapshot.data.documents.toString()}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Commande> mesCommande = [];
          if (snapshot != null && snapshot.data != null)
            snapshot.data.documents.forEach((element) {
              Commande maCommande = Commande(
                adresLivraison: element['adresLivraison'],
                autreDetail: element['autreDetail'],
                commune: element['commune'],
                dateLivraison: DateFormat('dd-MM-yyyy')
                    .format(element['dateLivraison'].toDate()),
                nbrePoul: element['nbrePoul'].toString(),
                nomPrenom: element['nomPrenom'],
                periode: element['periode'],
                quatiers: element['quartiers'],
                tel: element['tel'].toString(),
              );
              mesCommande.add(maCommande);
            });
          return ListView.builder(
              // shrinkWrap: true,
              itemCount: mesCommande.length,
              itemBuilder: (BuildContext context, int index) {
                // DocumentSnapshot documentSnapshot =
                //     snapshot.data.documents[index];
                // print('${snapshot.data.documents[index]["periode"]}');
                print(mesCommande.toString());
                print(mesCommande.length);
                var b = 134;
                return Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            color: Color.fromRGBO(255, 0, 0, 0.8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text('Supprimer'),
                            textColor: Colors.white,
                            onPressed: () {
                              print(
                                  "Mozart est la , merci Seigneur!!!!!!!!!!!!!!!");
                              deleteData(commande);
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            color: Color.fromRGBO(0, 255, 0, 0.8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text('Modifier'),
                            textColor: Colors.white,
                            onPressed: () {
                              // ignore: unnecessary_statements
                              //deleteData;
                              print(
                                  "Mozart est la , merci Seigneur!!!!!!!!!!!!!!!");
                              deleteData(commande);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Adresse de Livraison: " +
                                  mesCommande[index].adresLivraison !=
                              null
                          ? mesCommande[index].adresLivraison
                          : "null"),
                      Text(mesCommande[index].autreDetail != null
                          ? mesCommande[index].autreDetail
                          : "null"),
                      Text(mesCommande[index].commune != null
                          ? mesCommande[index].commune
                          : "null"),
                      Text(mesCommande[index].dateLivraison.toString() != null
                          ? mesCommande[index].dateLivraison.toString()
                          : "null"),
                      Text(mesCommande[index].nbrePoul != null
                          ? mesCommande[index].nbrePoul
                          : "null"),
                      Text(mesCommande[index].nomPrenom != null
                          ? mesCommande[index].nomPrenom
                          : "null"),
                      Text(mesCommande[index].periode != null
                          ? mesCommande[index].periode
                          : "null"),
                      Text(mesCommande[index].quatiers != null
                          ? mesCommande[index].quatiers
                          : "null"),
                      Text(mesCommande[index].tel != null
                          ? mesCommande[index].tel
                          : "null"),
                    ],
                  ),
                );
              });
        });
  }

  Widget dataDisplay(BuildContext context, String uid, List<String> foodIds,
      Map<String, int> count) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('items')
          .where(FieldPath.documentId, whereIn: foodIds)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data.documents.length > 0) {
          List<Cart> _cartItems = new List<Cart>();
          snapshot.data.documents.forEach((item) {
            _cartItems.add(Cart(
                item.documentID,
                count[item.documentID],
                item.data['item_name'],
                item.data['total_qty'],
                item.data['price']));
          });
          if (_cartItems.length > 0) {
            sum = 0;
            itemsCount = 0;
            _cartItems.forEach((element) {
              if (element.price != null && element.count != null) {
                sum += element.price * element.count;
                itemsCount += element.count;
              }
            });
            return Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _cartItems.length,
                        itemBuilder: (context, int i) {
                          return ListTile(
                            title: Text(_cartItems[i].itemName ?? ''),
                            subtitle:
                                Text('cost: ${_cartItems[i].price.toString()}'),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  (_cartItems[i].count == null ||
                                          _cartItems[i].count <= 1)
                                      ? IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              foodIds
                                                  .remove(_cartItems[i].itemId);
                                            });
                                            await editCartItem(
                                                _cartItems[i].itemId,
                                                0,
                                                context);
                                          },
                                          icon: new Icon(Icons.delete),
                                        )
                                      : IconButton(
                                          onPressed: () async {
                                            await editCartItem(
                                                _cartItems[i].itemId,
                                                (_cartItems[i].count - 1),
                                                context);
                                          },
                                          icon: new Icon(Icons.remove),
                                        ),
                                  Text(
                                    '${_cartItems[i].count ?? 0}',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  IconButton(
                                    icon: new Icon(Icons.add),
                                    onPressed: () async {
                                      await editCartItem(_cartItems[i].itemId,
                                          (_cartItems[i].count + 1), context);
                                    },
                                  )
                                ]),
                          );
                        }),
                    Text("Total ($itemsCount items): $sum INR"),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        showAlertDialog(
                            context, "Total ($itemsCount items): $sum INR");
                      },
                      child: CustomRaisedButton(buttonText: 'Proceed to buy'),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ));
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
    );
  }

  showAlertDialog(BuildContext context, String data) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Place Order"),
      onPressed: () {
        placeOrder(context, sum);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Proceed to checkout?"),
      content: Text(data),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
