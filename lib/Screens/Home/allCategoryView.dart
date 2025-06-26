import 'package:flutter/material.dart';

import '../../Services/ApiService.dart';
import 'Category_AllProduct_Page.dart';
import 'Create_Product.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  bool isLoading = true;
  List<String> categoryNames = [];
  List<Map<String, dynamic>> categories = [];


  // Future<void> fetchCategory()async{
  //   final names = await ApiService().getMainCategory();
  //   setState(() {
  //    categoryNames = names;
  //     isLoading = false;
  //   });
  // }


  Future<void> fetchCategory()async{
    final names = await ApiService().getMainCategory();
    setState(() {
      categories = names;
      isLoading = false;
    });
  }


  @override
  void initState() {
    fetchCategory();
    super.initState();
  }

  final List<String> categoryImages = [
    'assets/arts_service.png',
    'assets/homePageImage.jpg',
    'assets/homePageImage.jpg',
    'assets/arts_service.png',
    'assets/arts_service.png',
    'assets/homePageImage.jpg',
    'assets/homePageImage.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product Post', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
    child: SingleChildScrollView(
    child: Column(
      children: [
      Container(
      height: 1000,
      child: GridView.builder(
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
        ),
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final imageIndex = index % categoryImages.length;
          final name = categories[index]['name'] ?? '';
          final sId = categories[index]['_id'] ?? '';

          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateProduct(
                  categoryName: name,
                  catagoriesId: sId,
                ),
              ));
            },
            child: Container(
              //height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        categoryImages[imageIndex],
                        width: 35,
                        height: 40,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "Roboto_Regular",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
    ],
    ),
    ),
    ),



    // SafeArea(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         InkWell(
      //           onTap: (){
      //            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CreateProduct(
      //            )));
      //           },
      //           child:
      //           Container(
      //             height: 1000,
      //             child: GridView.builder(
      //               itemCount: categories.length,
      //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //                 mainAxisSpacing: 10,
      //                 crossAxisSpacing: 12,
      //                 childAspectRatio: 1.5,
      //               ),
      //               padding: const EdgeInsets.all(8),
      //               itemBuilder: (context, index) {
      //                 final imageIndex = index % categoryImages.length;
      //                 return Container(
      //                   decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.circular(15),
      //                     boxShadow: [
      //                       BoxShadow(
      //                         color: Colors.grey.withOpacity(0.2),
      //                         blurRadius: 4,
      //                         spreadRadius: 1,
      //                         offset: Offset(0, 3),
      //                       ),
      //                     ],
      //                   ),
      //                   child: Center(
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(20.0),
      //                       child: Column(
      //                         children: [
      //                           // Expanded(
      //                           //   child:
      //                             Image.asset(
      //                               categoryImages[imageIndex],
      //                               width: 35,
      //                               height: 40,
      //                             ),
      //                          // ),
      //
      //                           Text(
      //                            // categoryNames[index],
      //                             categories[index]['name'] ?? '',
      //                             textAlign: TextAlign.center,
      //                             overflow: TextOverflow.ellipsis,
      //                             style: const TextStyle(
      //                               fontFamily: "Roboto_Regular",
      //                               fontWeight: FontWeight.w400,
      //                               fontSize: 16,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               },
      //             ),
      //           ),
      //
      //           // Container(
      //           //   height: 150,
      //           //   child: ListView.builder(
      //           //     itemCount: categories.length,
      //           //     scrollDirection: Axis.horizontal,
      //           //     itemBuilder: (context, index) {
      //           //       return Padding(
      //           //         padding: const EdgeInsets.all(4.0),
      //           //         child: InkWell(
      //           //           onTap: () {
      //           //             Navigator.of(context).push(
      //           //               MaterialPageRoute(
      //           //                 builder: (context) => const CategoryAllProductPage(),
      //           //               ),
      //           //             );
      //           //           },
      //           //           child: Container(
      //           //             width: 120,
      //           //             padding: const EdgeInsets.all(8),
      //           //             decoration: BoxDecoration(
      //           //               borderRadius: BorderRadius.circular(15),
      //           //               color: Colors.blueGrey.shade100,
      //           //               boxShadow: [
      //           //                 BoxShadow(
      //           //                   color: Colors.black12,
      //           //                   blurRadius: 6,
      //           //                   spreadRadius: 1,
      //           //                   offset: Offset(2, 3),
      //           //                 ),
      //           //               ],
      //           //             ),
      //           //             child: Column(
      //           //               mainAxisAlignment: MainAxisAlignment.center,
      //           //               children: [
      //           //                 Image.asset('assets/arts_service.png', scale: 2),
      //           //                 const SizedBox(height: 8),
      //           //                 Text(
      //           //                   categories[index]['name'] ?? '',
      //           //                   textAlign: TextAlign.center,
      //           //                   style: const TextStyle(
      //           //                     fontSize: 14,
      //           //                     color: Colors.black87,
      //           //                     fontWeight: FontWeight.w500,
      //           //                   ),
      //           //                 ),
      //           //               ],
      //           //             ),
      //           //           ),
      //           //         ),
      //           //       );
      //           //     },
      //           //   ),
      //           // ),
      //
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.grey[200],
    );
  }

}




















// Container(
//  // constraints: const BoxConstraints(maxWidth: 450),
//   padding: const EdgeInsets.all(24),
//   margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(16),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black.withOpacity(0.1),
//         blurRadius: 16,
//         offset: const Offset(0, 8),
//       ),
//     ],
//   ),
//   child: Form(
//     key: _formKey,
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//
//         TextFormField(
//           controller: titleController,
//           keyboardType: TextInputType.text,
//           decoration: InputDecoration(
//             labelText: 'Title',
//             prefixIcon: const Icon(Icons.title_outlined),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter a title';
//             }
//             if (value.length < 3) {
//               return 'Title must be at least 3 characters';
//             }
//             return null;
//           },
//         ),
//
//         const SizedBox(height: 16),
//
//         TextFormField(
//           controller: descriptionController,
//           keyboardType: TextInputType.text,
//           maxLines: 1,
//           decoration: InputDecoration(
//             labelText: 'Description',
//             alignLabelWithHint: true,
//             prefixIcon: const Icon(Icons.description_outlined),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter a description';
//             }
//             if (value.length < 10) {
//               return 'Description should be at least 10 characters';
//             }
//             return null;
//           },
//         ),
//
//         const SizedBox(height: 16),
//
//
//         TextFormField(
//           controller: priceController,
//           keyboardType:
//           const TextInputType.numberWithOptions(decimal: true),
//           decoration: InputDecoration(
//             labelText: 'Price',
//             prefixIcon: const Icon(Icons.attach_money_outlined),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter a price';
//             }
//             final price = double.tryParse(value);
//             if (price == null || price <= 0) {
//               return 'Please enter a valid price';
//             }
//             return null;
//           },
//         ),
//
//         const SizedBox(height: 24),
//
//         SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: ElevatedButton(
//             onPressed: _isSubmitting ? null : _submit,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.deepPurple,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: _isSubmitting
//                 ? const CircularProgressIndicator(
//               color: Colors.white,
//             )
//                 : const Text(
//               'Create Post',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),