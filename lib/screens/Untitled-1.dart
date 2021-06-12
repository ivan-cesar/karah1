if (snapshot1.hasData && snapshot1.data.documents.length > 0 ) {
                  return ListView.builder(
                    itemCount: snapshot1.data.documents.length,
                   itemBuilder:(context, index){
                    DocumentSnapshot documentSnapshot
                    = snapshot1.data.documents[index];
                    return Row(
                      children:<Widget>[
                        Expanded(
                          child:Text(documentSnapshot["nomPrenom"]),
                        ),
                        Expanded(
                          child:Text(documentSnapshot["nbrePoul"].toString()),
                        ),
                        Expanded(
                          child:Text(documentSnapshot["tel"].toString()),
                        ),
                        Expanded(
                          child:Text(documentSnapshot["adresLivraison"].toString()),
                        ),
                        Expanded(
                          child:Text(documentSnapshot["commune"]),
                        ),
                        Expanded(
                          child:Text(documentSnapshot["quartiers"]),
                        ),
                        Expanded(
                          child:Text(documentSnapshot["autreDetail"]),
                        ),
                        Expanded(
                          child:Text(documentSnapshot["dateLivraison"]),
                        ),
                        Expanded(
                          child:Text(documentSnapshot["periode"]),
                        )
                      ],
                    );
                  });
                }else{
                  return Align(
                    alignment:FractionalOffset.
                    bottomCenter,
                    child:CircularProgressIndicator(),
                  );
                }