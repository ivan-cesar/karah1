import 'package:date_util/date_util.dart';

void main(){
  var dateUtility = DateUtil();
  int anneEnCours = DateTime.now().year;
  int jourEnCours = DateTime.now().day;
  int moisEnCours = DateTime.now().month;
  int heur = DateTime.now().hour;
  var nbrJourPass = dateUtility.daysPastInYear(moisEnCours, jourEnCours, anneEnCours) +1;
  var nbrJourPas = dateUtility.daysPastInYear(moisEnCours, jourEnCours, anneEnCours);
  var nbrJourAnnee = dateUtility.yearLength(365);
  var rest = (365 - nbrJourPass) - 5;
  var rest1 = (365 - nbrJourPas) - 5;

  print("La date restante by mozart :::${nbrJourPass}");
  print("La date restante by mozart :::${nbrJourAnnee}");
  print("La date restante by heure :::${heur}");
 if(heur==20){
   print("La date jour +1 :::${rest}");
   print("La date jour -1 :::${rest1}");
 }else{
   print("La date jour +1 :::${rest}");
   print("La date jour -1 :::${rest1}");
 }
}