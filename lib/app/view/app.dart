// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:flow_builder/flow_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_trans/app/view/app.dart';
// // import 'package:food_trans/pages/login/login_page.dart';
// // import 'package:food_trans/theme.dart';
//
// import '../../cart/cubit/cart_cubit.dart';
// import '../../cart/repository/cart_repository.dart';
// import '../../food_details/cubit/food_details_cubit.dart';
// import '../../food_details/repository/food_details_repository.dart';
// import '../../product/cubit/product_cubit.dart';
// import '../../repositories/settings_repository.dart';
// import '../../splash/view/splash_page.dart';
// import '../bloc/app_bloc.dart';
// import '../routes/app_routes.dart';
// import '../routes/routes.dart';
//
// class App extends StatelessWidget {
//   const App({
//     required AuthenticationRepository authenticationRepository,
//     super.key,
//   }) : _authenticationRepository = authenticationRepository;
//
//   final AuthenticationRepository _authenticationRepository;
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return RepositoryProvider.value(
// //       value: _authenticationRepository,
// //       child: BlocProvider(
// //         lazy: false,
// //         create: (_) => AppBloc(
// //           authenticationRepository: _authenticationRepository,
// //         )..add(const AppUserSubscriptionRequested()),
// //         child: const AppView(),
// //       ),
// //     );
// //   }
// // }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         RepositoryProvider.value(
//           value: _authenticationRepository,
//         ), // ✅ No child parameter
//         RepositoryProvider(create: (context) => SettingsRepository(),),
//         BlocProvider(
//           lazy: false,
//           create: (_) => AppBloc(
//             authenticationRepository: _authenticationRepository,
//           )..add(const AppUserSubscriptionRequested()),
//         ),
//         BlocProvider(create: (_) => CartCubit()),
//         BlocProvider(create: (_) => ProductCubit()),
//       ],
//       child: const AppView(),
//     );
//   }
// }
//
// // class AppView extends StatelessWidget {
// //   const AppView({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       // theme: theme,
// //       home: FlowBuilder<AppStatus>(
// //         state: context.select((AppBloc bloc) => bloc.state.status),
// //         onGeneratePages: onGenerateAppViewPages,
// //       ),
// //     );
// //   }
// // }
//
// class AppView extends StatelessWidget {
//   const AppView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FlowBuilder<AppStatus>(
//         state: context.select((AppBloc bloc) => bloc.state.status),
//         onGeneratePages: onGenerateAppViewPages,
//       ),
//       // home: LoginPage(),
//       theme: ThemeData(
//         textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(foregroundColor: Colors.deepOrangeAccent),
//         ),
//         primarySwatch: Colors.orange,
//         fontFamily: 'Inter',
//       ),
//       onGenerateRoute: AppRoutes.generateRoute,
//       // initialRoute: AppRoutes.cart,
//     );
//   }
// }

// lib/app/app.dart
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cart/cubit/cart_cubit.dart';
import '../../cart/repository/cart_repository.dart';
import '../../food_details/cubit/food_details_cubit.dart';
import '../../food_details/repository/food_details_repository.dart';
import '../../product/cubit/product_cubit.dart';
import '../../repositories/settings_repository.dart';
import '../../splash/view/splash_page.dart';
import '../bloc/app_bloc.dart';
import '../routes/app_routes.dart';
import '../routes/routes.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    // Create repositories outside of providers to avoid circular dependency
    final settingsRepository = SettingsRepository();
    return MultiBlocProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider(
          create: (context) => SettingsRepository(),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => AppBloc(
            authenticationRepository: _authenticationRepository,
            settingsRepository: settingsRepository,
          )..add(const AppUserSubscriptionRequested()),
        ),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => ProductCubit()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: state.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('es'),
            Locale('fr'),
          ],
          home: FlowBuilder<AppStatus>(
            state: context.select((AppBloc bloc) => bloc.state.status),
            onGeneratePages: onGenerateAppViewPages,
          ),
          theme: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.deepOrangeAccent),
            ),
            primarySwatch: Colors.orange,
            fontFamily: 'Inter',
          ),
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
