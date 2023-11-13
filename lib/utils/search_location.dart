// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_place/google_place.dart';

// import '../../../../constants/app_colors.dart';
// import '../../../../constants/app_fonts.dart';
// import '../../../../constants/app_images.dart';
// import '../components/buttons.dart';

// class SearchLocation extends StatefulWidget {
//   SearchLocation({Key? key}) : super(key: key);

//   @override
//   State<SearchLocation> createState() => _SearchLocationState();
// }

// class _SearchLocationState extends State<SearchLocation> {
//   Position? _currentPosition;
//   bool switchView = true;
//   String _currentAddress = 'Search Location';
//   late GooglePlace googlePlace;
//   List<AutocompletePrediction> predictions = [];
//   Timer? _debounce;
//   DetailsResult? startPosition;
//   DetailsResult? endPosition;
//   FocusNode? startFocusNode;
//   autocompleteSerach(String value) async {
//     var result = await googlePlace.autocomplete.get(value);
//     if (result != null && result.predictions != null && mounted) {
//       print(result.predictions!.last.id);
//       setState(() {
//         predictions = result.predictions!;
//       });
//     }
//   }

//   TextEditingController? _startController;
//   @override
//   void initState() {
//     super.initState();
//     startFocusNode = FocusNode();
//     String apiKey = 'AIzaSyDDoqKe4wbiEHDCT-GsCE8bgddeY4z6qZ4';
//     googlePlace = GooglePlace(apiKey);
//     _getAddressFromLatLng();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             BackButtonWithHeader(text: 'Your Route'),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(children: [
//                 Search2(
//                     icon: Container(
//                       width: 8,
//                       child: SvgPicture.asset(
//                         AppImages.search,
//                         color: Pallete.hintColor,
//                       ),
//                     ),
//                     text: TextField(
//                       focusNode: startFocusNode,
//                       controller: _startController,
//                       onTap: () {
//                         switchView = false;
//                       },
//                       onChanged: (value) {
//                         if (_debounce?.isActive ?? false) _debounce!.cancel();
//                         _debounce =
//                             Timer(const Duration(milliseconds: 1000), () {
//                           if (value.isNotEmpty) {
//                             autocompleteSerach(value);
//                           } else {
//                             switchView = true;
//                           }
//                         });
//                       },
//                       decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(4),
//                           border: InputBorder.none,
//                           hintStyle: const TextStyle(
//                               fontWeight: FontWeight.w300,
//                               fontSize: 12,
//                               color: Pallete.hintColor),
//                           hintText: _currentAddress),
//                     ),
//                     colors: Pallete.hintColor),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Divider(height: 0.1, color: Pallete.primaryColor),
//                 Container(
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: predictions.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           leading: CircleAvatar(child: Icon(Icons.abc)),
//                           title:
//                               Text(predictions[index].description.toString()),
//                           onTap: () async {
//                             //this is to access the predictions of the place
//                             final placeId = predictions[index].placeId!;

//                             //this is to access the google place id
//                             final details =
//                                 await googlePlace.details.get(placeId);

//                             if (details != null &&
//                                 details.result != null &&
//                                 mounted) {
//                               setState(() {
//                                 startPosition = details.result;
//                                 _startController!.text = details.result!.name!;
//                                 predictions = [];
//                                 switchView = false;
//                               });
//                             } else {}
//                           },
//                         );
//                       }),
//                 ),
//               ]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _getAddressFromLatLng() async {
//     // final _locationData = await getUserLocation();
//     // setState(() {
//     //   _currentAddress = _locationData;
//     // });
//   }
// }

