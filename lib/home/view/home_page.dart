import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_trans/app/bloc/app_bloc.dart';
import 'package:food_trans/home/cubit/item_filter_cubit.dart';
import 'package:food_trans/home/view/item_filter_view.dart';
import 'package:items_repository/items_repository.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   static Page<void> page() => const MaterialPage<void>(child: HomePage());
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: BlocProvider<ItemFilterCubit>(
//         create: (_) => ItemFilterCubit(context.read<ItemsRepository>())..loadItems(),
//         child: Column(
//           children: [
//             Container(
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(image: AssetImage("assets/image34.png"),
//                   fit: BoxFit.fill
//                 )
//               ),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 40),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         OutlinedButton(
//                           onPressed: (){}, child: Icon(Icons.search_rounded, size: 23, color: Colors.white,),
//                         ),
//
//                         const SizedBox(width: 10,),
//
//                         OutlinedButton(
//                           onPressed: (){},
//                           child: Icon(Icons.notifications_none_rounded, size: 23, color: Colors.white,),
//                         ),
//
//                         IconButton(
//                             onPressed: () => context.read<AppBloc>().add(const AppLogoutPressed()),
//                             icon: Icon(Icons.logout, color: Colors.white,))
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 15, top: 20), child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "Provide the best\nfood for you",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 15),
//               padding: EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text("Find by Category", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//
//                       const SizedBox(width: 110,),
//
//                       Text("See All", style: TextStyle(color: Colors.deepOrangeAccent),)
//                     ],
//                   ),
//
//                   const SizedBox(height: 10,),
//
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //   children: [
//                   //     GestureDetector(
//                   //       onTap: () {},
//                   //       child: Container(
//                   //         padding: EdgeInsets.all(10),
//                   //         decoration: BoxDecoration(
//                   //           borderRadius: BorderRadius.circular(8.00),
//                   //           color: Colors.deepOrangeAccent
//                   //         ),
//                   //         child: Column(
//                   //           children: [
//                   //             Image(image: AssetImage("assets/burgericon.png"),),
//                   //
//                   //             const SizedBox(height: 10,),
//                   //
//                   //             Text("Burger", style: TextStyle(color: Colors.white),)
//                   //           ],
//                   //         ),
//                   //       ),
//                   //     ),
//                   //     GestureDetector(
//                   //       onTap: () {},
//                   //       child: Container(
//                   //         padding: EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 10),
//                   //         decoration: BoxDecoration(
//                   //             borderRadius: BorderRadius.circular(8.00),
//                   //             color: Colors.deepOrangeAccent
//                   //         ),
//                   //         child: Column(
//                   //           children: [
//                   //             Image(image: AssetImage("assets/image24.png"),),
//                   //
//                   //             const SizedBox(height: 10,),
//                   //
//                   //             Text("Taco", style: TextStyle(color: Colors.white),)
//                   //           ],
//                   //         ),
//                   //       ),
//                   //     ),
//                   //     GestureDetector(
//                   //       onTap: () {},
//                   //       child: Container(
//                   //         padding: EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 10),
//                   //         decoration: BoxDecoration(
//                   //             borderRadius: BorderRadius.circular(8.00),
//                   //             color: Colors.deepOrangeAccent
//                   //         ),
//                   //         child: Column(
//                   //           children: [
//                   //             Image(image: AssetImage("assets/image24.png"),),
//                   //
//                   //             const SizedBox(height: 10,),
//                   //
//                   //             Text("Pizza", style: TextStyle(color: Colors.white),)
//                   //           ],
//                   //         ),
//                   //       ),
//                   //     ),
//                   //     GestureDetector(
//                   //       onTap: () {},
//                   //       child: Container(
//                   //         padding: EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 10),
//                   //         decoration: BoxDecoration(
//                   //             borderRadius: BorderRadius.circular(8.00),
//                   //             color: Colors.deepOrangeAccent
//                   //         ),
//                   //         child: Column(
//                   //           children: [
//                   //             Image(image: AssetImage("assets/image23.png"),),
//                   //
//                   //             const SizedBox(height: 10,),
//                   //
//                   //             Text("Drink", style: TextStyle(color: Colors.white),)
//                   //           ],
//                   //         ),
//                   //       ),
//                   //     )
//                   //   ],
//                   // )
//                   ItemFilterView(),
//                 ],
//               ),
//             )
//           ],
//
//         ),
//       )
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ItemsRepository>(
      create: (_) => ItemsRepository(),
      child: Builder(builder: (context) {
        return BlocProvider(
          create: (_) => ItemFilterCubit(context.read<ItemsRepository>())..loadItems(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(title: Text('Items Filter')),
              body: ItemFilterView(),
            ),
          ),
        );
      }),
    );
  }
}