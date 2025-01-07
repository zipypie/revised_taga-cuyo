import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/app/app_viewer.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/app/themes/themes.dart';
import 'package:taga_cuyo/core/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:taga_cuyo/core/bloc/my_user_bloc/my_user_bloc.dart';
import 'package:taga_cuyo/core/bloc/progress_bloc/progress_bloc.dart';
import 'package:taga_cuyo/core/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:taga_cuyo/core/bloc/sign_up_bloc/sign_up_bloc.dart'; // Import SignUpBloc
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/user_progress_repo.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';
import 'package:taga_cuyo/presentation/onboarding/get_started/get_started.dart';
import 'package:taga_cuyo/presentation/onboarding/login/login_screen.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MainApp extends StatelessWidget {
  final UserRepository userRepository;
  final UserProgressRepository userProgressRepository;

  const MainApp(this.userRepository, this.userProgressRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(
            myUserRepository: userRepository,
          ),
        ),
        RepositoryProvider<ProgressBloc>(
          create: (_) => ProgressBloc(
            userProgressRepository: userProgressRepository,
          ),
        ),
        BlocProvider(
          create: (context) => SignInBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        onGenerateRoute: AppRoutes.generateRoute,
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              if (state.user!.emailVerified) {
                // User is authenticated and email is verified
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => ProgressBloc(
                        userProgressRepository: userProgressRepository,
                      )..add(GetUserProgressEvent()),
                    ),
                  ],
                  child: const MainAppScreen(),
                );
              } else {
                // Email is not verified, show login screen
                return const LoginScreen();
              }
            } else if (state.status == AuthenticationStatus.unauthenticated) {
              return const LoginScreen(); // User is not authenticated
            } else if (state.status == AuthenticationStatus.unknown) {
              return const GetStartedScreen(); // Loading or first-time screen
            } else {
              return const LoginScreen(); // Default to login screen
            }
          },
        ),
      ),
    );
  }
}
