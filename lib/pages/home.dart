// import 'dart:convert';

// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:minor_app/camera.dart';
// import 'package:minor_app/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

// class HomePage extends StatefulWidget {
//   final token;
//   const HomePage({@required this.token, super.key});
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late String email;
//   List animalCategorylist = ["Dog", "Cow", "Cat", "Bird", "Goat", "Rabbit"];
//   List<dynamic> selectedAnimalImages = [];

//   @override
//   void initState() {
//     super.initState();
//     Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
//     email = jwtDecodedToken['email'];
//     fetchImages(animalCategorylist[_selectedIndex.value]);
//   }

//   Future<void> initializeCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CameraPage(camera: firstCamera)),
//     );
//   }

//   Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('token');
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => LoginPage()));
//   }

//   Future<void> fetchImages(String query) async {
//     final url =
//         'https://pixabay.com/api/?key=44047406-c815a6a2a9aca5d86609f49bb&q=' +
//             query;
//     final response = await http.get(Uri.parse(url));
//     final JsonResponse = jsonDecode(response.body);
//     setState(() {
//       selectedAnimalImages = JsonResponse['hits'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Hello, Kunal Verma'),
//           actions: [
//             IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
//           ],
//         ),
//         drawer: drawerWidget(),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 15,
//                 ),
//                 uploadMissingWedget(),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Text(
//                   "Categories",
//                   style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 petCategoriesWidget(),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 GridView.builder(
//                   // scrollDirection: Axis.vertical,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   dragStartBehavior: DragStartBehavior.down,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.7,
//                   ),
//                   itemCount: selectedAnimalImages.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Container(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(
//                                 0, 3), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Stack(
//                           children: [
//                             Image.network(
//                               // 'assets/dog/pet (${index + 1}).jpg',
//                               selectedAnimalImages[index]['largeImageURL'],
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               height: double.infinity,
//                             ),
//                             Positioned(
//                               bottom: 10,
//                               left: 10,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.5),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Text(
//                                   '${animalCategorylist[_selectedIndex.value]} ${index + 1}',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 10,
//                               right: 10,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 4),
//                                 // decoration: BoxDecoration(
//                                 //   color: Colors.black.withOpacity(0.5),
//                                 //   borderRadius: BorderRadius.circular(10),
//                                 // ),
//                                 child: Icon(
//                                   Icons.favorite,
//                                   color: Colors.white,
//                                   size: 25,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Drawer drawerWidget() {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Color.fromRGBO(234, 239, 239, 1),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage('assets/profile.jpg'),
//                   radius: 35,
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   "Kunal Verma",
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             title: const Text('Item 1'),
//             onTap: () {
//               // Update the state of the app.
//               // ...
//             },
//           ),
//           ListTile(
//             title: const Text('Item 2'),
//             onTap: () {
//               // Update the state of the app.
//               // ...
//             },
//           ),
//           ListTile(
//             title: const Text('Item 3'),
//             onTap: () {
//               // Update the state of the app.
//               // ...
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Container uploadMissingWedget() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       margin: EdgeInsets.symmetric(horizontal: 30),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Color.fromRGBO(234, 239, 239, 1),
//       ),
//       child: Column(
//         children: [
//           Text(
//             "Upload Missing",
//             style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Center(
//             child: ElevatedButton(
//               onPressed: initializeCamera,
//               style: ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll(
//                       Color.fromRGBO(255, 103, 103, 1))),
//               child: Text(
//                 "Upload",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   SizedBox petCategoriesWidget() {
//     return SizedBox(
//       // padding: EdgeInsets.symmetric(horizontal: 10),
//       height: 120,
//       child: ListView.builder(
//         itemCount: animalCategorylist.length,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () {
//               fetchImages(animalCategorylist[index]);
//               _selectedIndex.value = index;
//             },
//             child: ValueListenableBuilder<int>(
//               valueListenable: _selectedIndex,
//               builder: (context, selectedIndex, child) {
//                 return Container(
//                   width: 100,
//                   margin: EdgeInsets.only(right: 20),
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                   decoration: BoxDecoration(
//                       color: (index == selectedIndex)
//                           ? Color.fromRGBO(228, 245, 246, 1)
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Image.asset(
//                         'assets/animal-category-${index + 1}.png',
//                         height: 70,
//                       ),
//                       Text(
//                         animalCategorylist[index] + 's',
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:minor_app/camera.dart';
import 'package:minor_app/const/const.dart';
import 'package:minor_app/auth/login.dart';
// import 'package:minor_app/missing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
Map<String, List<dynamic>> cachedImages = {};

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({required this.token, Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String email;
  List<String> animalCategorylist = [
    "Dog",
    "Cow",
    "Cat",
    "Bird",
    "Goat",
    "Rabbit"
  ];
  List<dynamic> selectedAnimalImages = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    fetchImages(animalCategorylist[_selectedIndex.value]);
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraPage(camera: firstCamera),
      ),
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MissingReport(),
    //   ),
    // );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> fetchImages(String query) async {
    setState(() {
      isLoading = true;
    });

    if (cachedImages.containsKey(query)) {
      setState(() {
        selectedAnimalImages = cachedImages[query]!;
        isLoading = false;
      });
      return;
    }

    final url =
        'https://pixabay.com/api/?key=44047406-c815a6a2a9aca5d86609f49bb&q=' +
            query;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final JsonResponse = jsonDecode(response.body);
        setState(() {
          selectedAnimalImages = JsonResponse['hits'];
          cachedImages[query] = selectedAnimalImages;
        });
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hello, User'),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
          ],
        ),
        drawer: drawerWidget(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                uploadMissingWedget(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                petCategoriesWidget(),
                SizedBox(
                  height: 15,
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : resultPetImages()
              ],
            ),
          ),
        ),
      ),
    );
  }

  GridView resultPetImages() {
    return GridView.builder(
      // scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: selectedAnimalImages.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: selectedAnimalImages[index]['largeImageURL'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${animalCategorylist[_selectedIndex.value]} ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Drawer drawerWidget() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: thirdColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                  radius: 35,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Kunal Verma",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 3'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }

  Container uploadMissingWedget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: thirdColor,
      ),
      child: Column(
        children: [
          Text(
            "Upload Missing",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: ElevatedButton(
              onPressed: initializeCamera,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(primaryColor),
              ),
              child: Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox petCategoriesWidget() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        itemCount: animalCategorylist.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              fetchImages(animalCategorylist[index]);
              _selectedIndex.value = index;
            },
            child: ValueListenableBuilder<int>(
              valueListenable: _selectedIndex,
              builder: (context, selectedIndex, child) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 20),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: (index == selectedIndex)
                          ? secondaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/animal-category-${index + 1}.png',
                        height: 70,
                      ),
                      Text(
                        animalCategorylist[index] + 's',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
