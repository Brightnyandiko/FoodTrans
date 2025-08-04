import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_trans/app/bloc/app_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/image34.png"),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: (){}, child: Icon(Icons.search_rounded, size: 23, color: Colors.white,),
                  ),
            
                  const SizedBox(width: 10,),
            
                  OutlinedButton(
                    onPressed: (){},
                    child: Icon(Icons.notifications_none_rounded, size: 23, color: Colors.white,),
                  ),
                  
                  IconButton(
                      onPressed: () => context.read<AppBloc>().add(const AppLogoutPressed()),
                      icon: Icon(Icons.logout, color: Colors.white,))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20), child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Provide the best\nfood for you",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
