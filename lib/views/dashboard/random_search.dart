import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/resources.dart';
import '../../../network/alldrugs.dart';
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
    _fetchItems();
  }

  _fetchItems() async {
    setState(() {
      query = searchQuery;
    });

    loadingDrugs = true;
    await Future.delayed(Duration(seconds: 1));
    print('searchfromdashoard ${searchQuery}');
    // Make the API call using the page and limit parameters
    var jsonData = await StoreAPI.getProductByName(searchQuery);
    var itemData = jsonData['products'];
    print('here ${itemData}');
    if (itemData.length == 0) {
      print('heres ${itemData}');
      loadingDrugs = false;
      setState(() {
        items;
         query = searchQuery;
      });
    } else {
      setState(() {
        dataList = itemData.map((item) {
          item['counts'] = counts;
          item['added'] = false;
          return item;
        }).toList();
        items = dataList;
        loadingDrugs = false;
        searchQuery = "";
        print(searchQuery);
      });
    }
  }

  _fetchwithSearch() async {
    setState(() {
      loadingDrugs = true;
    });

    items = [];

    await Future.delayed(Duration(seconds: 1));
    print('aya ${query}');
    // Make the API call using the page and limit parameters
    var jsonData = await StoreAPI.getProductByName(query);
    var itemData = jsonData['products'];
    print('here ${itemData}');
    if (itemData.length == 0) {
      print('heres ${itemData}');
      loadingDrugs = false;
      setState(() {
        loadingDrugs;
        items;
        
      });
    } else {
      loadingDrugs = false;
      setState(() {
        dataList = itemData.map((item) {
          item['counts'] = counts;
          item['added'] = false;
          return item;
        }).toList();
        items = dataList;

        searchQuery = "";
        loadingDrugs;
      });
    }
  }

  List<Map<String, dynamic>> cartDrugs = [];
  bool loaded = false;
  getCartItems() async {
    var cartItemsString = await showCartItem();
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
          saveCartItem(cartItems);
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
      saveCartItem(cartItems);
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
                                    _fetchwithSearch();
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
                                                SizedBox(
                                                  height: getSize.height * 0.65,
                                                  child: NotificationListener<
                                                      ScrollNotification>(
                                                    onNotification:
                                                        (ScrollNotification
                                                            scrollInfo) {
                                                      if (scrollInfo
                                                              .metrics.pixels ==
                                                          scrollInfo.metrics
                                                              .maxScrollExtent) {}
                                                      return true;
                                                    },
                                                    child: GridView.builder(
                                                        itemCount: items.length,
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 4.0,
                                                          mainAxisSpacing: 4.0,
                                                        ),
                                                        itemBuilder:
                                                            (context, index) {
                                                          // if (index == items.length) {
                                                          //   return Container(
                                                          //     color: Colors.greenAccent,
                                                          //     child: GestureDetector(
                                                          //       child: Text("Loading..."),
                                                          //       onTap: () {
                                                          //         // loadMores();
                                                          //       },
                                                          //     ),
                                                          //   );
                                                          // } else {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Container(
                                                              height:
                                                                  getSize.height *
                                                                      0.1,
                                                              width:
                                                                  getSize.width *
                                                                      0.4,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Pallete
                                                                    .whiteColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Color(
                                                                        0xFFD7D7D7),
                                                                    blurRadius:
                                                                        7.0,
                                                                    spreadRadius:
                                                                        0.5,
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      5.0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    height: getSize
                                                                            .height *
                                                                        0.1,
                                                                    width: getSize
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(5),
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage(items[index]
                                                                                [
                                                                                'imageurl'] ??
                                                                            imgHolder),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left: 4,
                                                                      right: 4,
                                                                    ),
                                                                    child: Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: getSize.width * 0.25,
                                                                                  child: Text(
                                                                                    items[index]['productname'],
                                                                                    maxLines: 1,
                                                                                    style: AppFonts.bodyText,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Text(
                                                                              // items[index]['price'].toString(),
                                                                              '$ngn ${customFormatCurrency(int.parse(items[index]['price'].toString())).toString()}',
                                                                              style:
                                                                                  AppFonts.bodyText.copyWith(
                                                                                fontSize: 14,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      if (items[index]["added"]) if (items[index]['counts'] == 1) {
                                                                                      } else {
                                                                                        setState(() {
                                                                                          items[index]['counts']--;
    
                                                                                          reduceItem(items[index], items[index]['price'].toString());
                                                                                        });
                                                                                      }
                                                                                    },
                                                                                    child: ClipOval(
                                                                                      child: Container(
                                                                                        width: 32,
                                                                                        height: 32,
                                                                                        color: Pallete.whiteColor,
                                                                                        child: const Center(
                                                                                          child: Icon(
                                                                                            Icons.chevron_left_rounded,
                                                                                            size: 32,
                                                                                            color: Pallete.secondaryColor,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 8,
                                                                                  ),
                                                                                  Text(items[index]['counts'].toString()),
                                                                                  const SizedBox(
                                                                                    width: 8,
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      if (items[index]["added"])
                                                                                        setState(() {
                                                                                          items[index]['counts']++;
                                                                                          addToCart(items[index]);
                                                                                        });
                                                                                    },
                                                                                    child: ClipOval(
                                                                                      child: Container(
                                                                                        width: 32,
                                                                                        height: 32,
                                                                                        color: Pallete.whiteColor,
                                                                                        child: const Center(
                                                                                          child: Icon(
                                                                                            Icons.chevron_right_rounded,
                                                                                            size: 32,
                                                                                            color: Pallete.secondaryColor,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              !items[index]["added"]
                                                                                  ? Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: Pallete.primaryColor,
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                        boxShadow: const [
                                                                                          BoxShadow(
                                                                                            color: Color(0xFFD7D7D7),
                                                                                            blurRadius: 7.0,
                                                                                            spreadRadius: 0.5,
                                                                                            offset: Offset(
                                                                                              0.0,
                                                                                              5.0,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          setState(() {
                                                                                            items[index]["added"] = true;
    
                                                                                            var item = {
                                                                                              "drug": items[index]["productname"],
                                                                                              "price": items[index]["price"],
                                                                                              'counts': items[index]["counts"],
                                                                                            };
    
                                                                                            cartItems.add(item);
                                                                                            saveCartItem(cartItems);
                                                                                            // addToCart(item);
                                                                                            sumAll(cartItems);
                                                                                          });
                                                                                        },
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.symmetric(
                                                                                            vertical: 4.0,
                                                                                            horizontal: 8,
                                                                                          ),
                                                                                          child: Text(
                                                                                            '+ Add',
                                                                                            style: AppFonts.bodyText.copyWith(
                                                                                              fontSize: 14,
                                                                                              color: Color.fromARGB(255, 255, 255, 255),
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  : GestureDetector(
                                                                                      onTap: () {
                                                                                        items[index]["added"] = false;
                                                                                        items[index]["counts"] = 1;
                                                                                        removeFromCart(items[index]["productname"]);
                                                                                      },
                                                                                      child: Text(
                                                                                        'Remove',
                                                                                        style: AppFonts.body1.copyWith(color: Colors.red, fontWeight: FontWeight.w600),
                                                                                      ))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        //},
                                                        ),
                                                  ),
                                                ),
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
