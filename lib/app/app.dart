import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/app/app_viewer.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/app/themes/themes.dart';
import 'package:taga_cuyo/core/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:taga_cuyo/core/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:taga_cuyo/core/bloc/sign_up_bloc/sign_up_bloc.dart'; // Import SignUpBloc
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';
import 'package:taga_cuyo/presentation/onboarding/get_started/get_started.dart';

class MainApp extends StatelessWidget {
  final UserRepository userRepository;
  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
            create: (_) =>
                AuthenticationBloc(myUserRepository: userRepository)),
        RepositoryProvider<SignUpBloc>(
            create: (_) => SignUpBloc(userRepository: userRepository)),
        RepositoryProvider<SignInBloc>(
            create: (_) => SignInBloc(userRepository: userRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        onGenerateRoute: AppRoutes.generateRoute,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MainAppScreen();
            } else {
              return GetStartedScreen();
            }
          },
        ), // This screen will now have access to AuthenticationBloc and SignUpBloc
      ),
    );
  }
}
