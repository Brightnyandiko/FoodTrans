import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_trans/app/view/app.dart';
// import 'package:food_trans/pages/login/login_page.dart';
// import 'package:food_trans/theme.dart';

import '../../cart/cubit/cart_cubit.dart';
import '../../cart/repository/cart_repository.dart';
import '../../food_details/cubit/food_details_cubit.dart';
import '../../food_details/repository/food_details_repository.dart';
import '../../splash/view/splash_page.dart';
import '../bloc/app_bloc.dart';
import '../routes/routes.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//       value: _authenticationRepository,
//       child: BlocProvider(
//         lazy: false,
//         create: (_) => AppBloc(
//           authenticationRepository: _authenticationRepository,
//         )..add(const AppUserSubscriptionRequested()),
//         child: const AppView(),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ), // ✅ No child parameter
        BlocProvider(
          lazy: false,
          create: (_) => AppBloc(
            authenticationRepository: _authenticationRepository,
          )..add(const AppUserSubscriptionRequested()),
        ),
        BlocProvider(
          create: (_) => CartCubit(cartRepository: CartRepository()),
        ),
        BlocProvider(
          create: (_) => FoodDetailsCubit(
            foodDetailsRepository: FoodDetailsRepository(),
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}

// class AppView extends StatelessWidget {
//   const AppView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // theme: theme,
//       home: FlowBuilder<AppStatus>(
//         state: context.select((AppBloc bloc) => bloc.state.status),
//         onGeneratePages: onGenerateAppViewPages,
//       ),
//     );
//   }
// }

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
      // home: LoginPage(),
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.deepOrangeAccent),
        ),
      ),
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
