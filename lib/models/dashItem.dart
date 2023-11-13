class DashboardItem {
//this is to declare the variables
  final String title;

  final String image;

//class constructor
  const DashboardItem({required this.title, required this.image});
}

class DashItems {
  //put all onboarding data model in a list
  static List<DashboardItem> loadItems() {
    //this is an object of all the items
    const obj = <DashboardItem>[
       DashboardItem(
         title: "Purchase your energy from a stable means of exchange",
            image: "assets/images/images/pharm plug_1.jpeg"),
      DashboardItem(
          title: "Analytic monitor of all your power usage from the grid",
          image: "assets/images/images/pharm plug_2.jpeg"),
        DashboardItem(
         title: "Purchase your energy from a stable means of exchange",
       image: "assets/images/images/pharm plug_3.jpeg"),
     
    ];
    return obj;
  }
}
