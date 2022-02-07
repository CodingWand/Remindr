class Reminder {
  String name; //nom d'identification du Rappel
  DateTime nextRem; //La date du rappel à venir (où en cour)
  int remID; //Le numéro du rappel variant de 0 à maxReminder - 1
  int maxRem; //Variant de 3 à 7
  String
      docRef; //Référence du document de firestore qui contient les données du rappel
  bool succeed; //Le rappel a été réussi ou non

  Reminder(this.name, this.nextRem, this.remID, this.maxRem, {this.docRef}) {
    succeed = true;
    if (maxRem > 7) {
      maxRem = 7;
    } else if (maxRem < 3) {
      maxRem = 3;
    }
  }

//Indique si le rappel est passé.
  bool isPast() {
    DateTime today = DateTime.now();
    return (nextRem.difference(today) <= Duration(days: -1));
  }

  bool remindToday(DateTime today) {
    return (nextRem.year == today.year) &&
        (nextRem.month == today.month) &&
        (nextRem.day == today.day);
  }

//Renvoie false si il n'y a pas de prochain rappel
  bool toNextReminder() {
    if (succeed) remID++;

    if (remID >= maxRem) return false;

    nextRem = (remID == 0 || (!succeed))
        ? nextRem.add(Duration(days: 1))
        : nextRem.add(Duration(days: remID));

    return true;
  }
}
