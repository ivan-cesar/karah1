class Commande {
  String adresLivraison;
  String autreDetail;
  String commune;
  String dateLivraison;
  String nbrePoul;
  String nomPrenom;
  String periode;
  String quatiers;
  String tel;
  String cmdID;
  Commande(
      {this.cmdID,
      this.adresLivraison,
      this.autreDetail,
      this.commune,
      this.dateLivraison,
      this.nbrePoul,
      this.nomPrenom,
      this.periode,
      this.quatiers,
      this.tel});

  @override
  String toString() {
    return 'Commande{cmdID:$cmdID, adresLivraison: $adresLivraison, autreDetail: $autreDetail, commune: $commune, dateLivraison: $dateLivraison, nbrePoul: $nbrePoul, nomPrenom: $nomPrenom, periode: $periode, quatiers: $quatiers, tel: $tel}';
  }
  
}
