// import 'package:flutter/material.dart';
// import 'package:post_api_assignment/Screens/Home/Create_Post.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   final List<Map<String, dynamic>> buttons = [
//     {
//       'title': 'Create Post',
//       'color': Colors.grey,
//       'onTap': () {
//         CreatePost();
//       },
//     },
//     {
//       'title': 'View All Product',
//       'color': Colors.deepPurple,
//       'onTap': () {
//        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreatePost()));
//       },
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Screen'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 36,
//           childAspectRatio: 3 / 1,
//           children: buttons.map((btn) {
//             return ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: btn['color'],
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: btn['onTap'],
//               child: Text(
//                 btn['title'],
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:post_api_assignment/Screens/Home/Create_Post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> buttons = [
      {
        'title': 'Create Post',
        'color': Colors.grey,
        'onTap': () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CreatePost()),
          );
        },
      },
      {
        'title': 'View All Product',
        'color': Colors.deepPurple,
        'onTap': () {
          // For example, navigate to another page
          // Navigator.of(context).push(
          //   MaterialPageRoute(builder: (context) => ViewAllProduct()),
          // );
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu, color: Colors.black87,))
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 36,
          childAspectRatio: 3 / 1,
          children: buttons.map((btn) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: btn['color'],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: btn['onTap'],
              child: Text(
                btn['title'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
