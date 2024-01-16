import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/resources.dart';
import '../../../utils/local_storage.dart';
import '../../components/buttons.dart';
import '../../utils/app_utils.dart';


class RandomSearchItem extends StatefulWidget {
  const RandomSearchItem({Key? key}) : super(key: key);

  @override
  _RandomSearchItemState createState() => _RandomSearchItemState();
}

class _RandomSearchItemState extends State<RandomSearchItem> {
  var product;
  List<Map<String, dynamic>> cartItems = [];
  var ngn = getCurrency();
  List<dynamic> dataList = [];
  int counts = 1;

 
 
   var locate = "";
  String searchQuery = ''; // Add this line
  String query = ''; // Add this line
  bool loadingDrugs = true;
  bool valuesecond = false;
  List<dynamic> items = [];
  removeProductsWithNullPrice(dynamic products) {
    return products.where((product) => product.price != null).toList();
  }

  @override
  void initState() {
    super.initState();
    getCartItems();
  
  }


  List<Map<String, dynamic>> cartDrugs = [];
  bool loaded = false;
  getCartItems() async {
    var cartItemsString = await showPropertyItem();
    cartDrugs = List<Map<String, dynamic>>.from(jsonDecode(cartItemsString));
    if (cartDrugs.isEmpty) {
      loaded = false;
    } else {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        print(cartDrugs);
        loaded = true;
      });
    }
  }

  int totalPrice = 0;


  void deductAll(List<Map<String, dynamic>> medicineList) {
    for (var medicine in medicineList) {
      int counter = int.parse(medicine['counts'].toString());
      int price = int.parse(medicine['price'].toString());

      int totalMedicinePrice = 0;
      totalMedicinePrice = counter * price;
      totalPrice -= totalMedicinePrice;
      print(totalPrice);
    }

    print('Total Price: $totalPrice');
  }

  filterPrice(enteredKeyword) {
    // Filter the categories based on the entered keyword
    List<dynamic> results = items.where((item) {
      final productName = product.price.toLowerCase();
      return productName.contains(enteredKeyword.toLowerCase());
    }).toList();

    // Refresh the UI with the filtered results
    setState(() {
      items = results;
    });
  }

  void filterCompany(enteredKeyword) {
    // Filter the categories based on the entered keyword
    List<dynamic> results = items.where((item) {
      final productName = product.companyname.toLowerCase();
      return productName.contains(enteredKeyword.toLowerCase());
    }).toList();

    // Refresh the UI with the filtered results
    setState(() {
      items = results;
    });
  }

  addToCart(newItem) {
    print(newItem);
    for (var drug in cartItems) {
      if (drug["drug"] == newItem['productname']) {
        drug["counts"] = newItem['counts'];
        setState(() {
          sumAll(cartItems);
          savePropertyItem(cartItems);
        });
        break;
      }
    }
  }

  reduceItem(newItem, newPrice) {
    print(newItem);
    for (var drug in cartItems) {
      if (drug["drug"] == newItem['productname']) {
        drug["counts"] = newItem['counts'];

        setState(() {
          sumAll(cartItems);
        });
        break;
      }
    }
  }
/**
 * Increase the count when the user clicks on an item + button
 */ ///
  void sumAll(List<Map<String, dynamic>> medicineList) {
    totalPrice = 0;
    for (var medicine in medicineList) {
      int counter = int.parse(medicine['counts'].toString());
      int price = int.parse(medicine['price'].toString());

      int totalMedicinePrice = 0;
      totalMedicinePrice = counter * price;
   
      setState(() {
           totalPrice += totalMedicinePrice;
      });
      print(totalPrice);
    }

    print('Total Price: $totalPrice');
  }

  removeFromCart(itemName) {
    // Drug name to search for and remove
    String drugNameToRemove = itemName;

    // Remove the object with the matching drug name
    cartItems.removeWhere((drug) => drug["drug"] == drugNameToRemove);

    setState(() {
      cartItems;
      sumAll(cartItems);
      savePropertyItem(cartItems);
    });
  }

    locateCityData() async {
    locate = await showState();
    print('my state');
    print(locate);
  }
  @override
  Widget build(BuildContext context) {
    final getSize = MediaQuery.of(context).size;
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    searchQuery = dataFromRoute["search"];
    return WillPopScope(
      onWillPop: ()async{
          Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.dashboardScreen,
          (route) => false,
        );
        return true;
      },
      child: Scaffold(
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                BackButtonWithIcon(),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                            Text(
                              dataFromRoute["search"],
                              style: AppFonts.boldTextPrimary.copyWith(fontSize: getSize.height * 0.021,),
                            ),
                            Text(
                              "",
                              style: AppFonts.boldTextPrimary,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getSize.height * 0.025,
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: Container(
                            height: getSize.height * 0.055,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Color(0xFF949494),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: TextField(
                                      onChanged: (value) => {
                                        if (value.isEmpty)
                                          {items = dataList}
                                        else
                                          {
                                            setState(() {
                                              query = value;
                                              print(query);
                                            })
                                          }
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Search...',
                                        border: InputBorder.none,
                                      ),
                                      style:
                                          AppFonts.body1.copyWith(fontSize: 14),
                                      // Add any necessary event handlers for text changes or submission.
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                   
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Pallete.secondaryColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Icon(
                      //         Icons.tune_rounded,
                      //         size: 32,
                      //       ),
                      //       Row(
                      //         children: [
                      //           SizedBox(
                      //             width: getSize.width * 0.415,
                      //             height: getSize.height * 0.045,
                      //             child: TextField(
                      //               onChanged: (value) => {setState(() {})},
                      //               decoration: InputDecoration(
                      //                 hintText: 'filter by company',
                      //                 border: OutlineInputBorder(
                      //                     borderRadius: BorderRadius.circular(8)),
                      //               ),
                      //               style: AppFonts.body1.copyWith(fontSize: 14),
                      //               // Add any necessary event handlers for text changes or submission.
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 8,
                      //           ),
                      //           SizedBox(
                      //             width: getSize.width * 0.415,
                      //             height: getSize.height * 0.045,
                      //             child: TextField(
                      //               onChanged: (value) => {
                      //                 if (value.isEmpty)
                      //                   {
                      //                     setState(() {
                      //                       items = dataList;
                      //                     })
                      //                   }
                      //                 else
                      //                   {filterPrice(value)}
                      //               },
                      //               decoration: InputDecoration(
                      //                 hintText: 'filter by price',
                      //                 border: OutlineInputBorder(
                      //                     borderRadius: BorderRadius.circular(8)),
                      //               ),
                      //               style: AppFonts.body1.copyWith(fontSize: 14),
                      //               // Add any necessary event handlers for text changes or submission.
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text(
                      //           '${items.length.toString()} Items Found',
                      //           style: AppFonts.smallWhiteBold
                      //               .copyWith(color: Pallete.secondaryColor),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${items.length.toString()} Items Found',
                          style: AppFonts.smallWhiteBold
                              .copyWith(color: Pallete.secondaryColor),
                        ),
                      ),
                      SizedBox(
                        height: getSize.height * 0.01,
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            loadingDrugs
                                ? SizedBox(
                                    height: getSize.height * 0.6,
                                    child: const SpinKitChasingDots(
                                      size: 35,
                                      color: Pallete.secondaryColor,
                                    ))
                                : Column(
                                    children: [
                                      items.isEmpty
                                          ? GestureDetector(
                                              onTap: () {
                                             
                                              },
                                              child: SizedBox(
                                                  height: getSize.height * 0.6,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/icons/empty.png',
                                                          width: 48,
                                                          color:
                                                              Pallete.hintColor,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                                'This item was not found'),
                                                            SizedBox(
                                                              height:
                                                                  getSize.height *
                                                                      0.1,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: getSize
                                                                          .height *
                                                                      0.125,
                                                                  width: getSize
                                                                          .width *
                                                                      0.35,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            237,
                                                                            248,
                                                                            250),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                  ),
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .all(
                                                                            14.0),
                                                                    child: Image
                                                                        .asset(
                                                                      AppImages
                                                                          .boy,
                                                                      width: 48,
                                                                      color: Pallete
                                                                          .secondaryColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Pallete
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(5),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                        'Ask with our stores here!',
                                                                        style: AppFonts
                                                                            .smallWhiteBold
                                                                            .copyWith(
                                                                                fontSize: 12),
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            )
                                          : Column(
                                              children: [
                                               GestureDetector(
                                                  onTap: () {
                                                    if (cartItems.isEmpty) {
                                                      AppUtils.ErrorDialog(
                                                        context,
                                                        'Your cart is empty!',
                                                        'You need to pick some drugs before you can get to checkout',
                                                        'cancel',
                                                        const Icon(Icons
                                                            .error_rounded),
                                                      );
                                                    } else {
                                                      
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    89,
                                                                    217,
                                                                    225,
                                                                    228),
    
                                                            blurRadius:
                                                                7.0, // has the effect of softening the shadow
                                                            spreadRadius:
                                                                0.5, // has the effect of extending the shadow
                                                            offset: Offset(
                                                              0.0, // horizontal, move right 10
                                                              5.0, // vertical, move down 10
                                                            ), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 16.0,
                                                          horizontal: 12),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${cartItems.length} item(s)',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              color: Pallete
                                                                  .whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const Text(
                                                            'View Cart',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Pallete
                                                                  .whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            '$ngn ${totalPrice.toString()}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              color: Pallete
                                                                  .whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ]),
                  )))),
    );
  }
}
