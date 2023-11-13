class PharmItem {
//this is to declare the variables
  final String title;

  final String image;

//class constructor
  const PharmItem({required this.title, required this.image});
}

class PharmItems {
  //put all onboarding data model in a list
  static List<PharmItem> loadItems() {
    //this is an object of all the items
    const obj = <PharmItem>[
       PharmItem(
         title: "Purchase your energy from a stable means of exchange",
            image: "assets/images/images/job2.png"),
      PharmItem(
          title: "Analytic monitor of all your power usage from the grid",
          image: "assets/images/images/job.jpeg"),
        PharmItem(
         title: "Purchase your energy from a stable means of exchange",
       image: "assets/images/images/job3.png"),
      PharmItem(
          title: "Analytic monitor of all your power usage from the grid",
             image: "assets/images/images/job.jpeg"),
    ];
    return obj;
  }
}
