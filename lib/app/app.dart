import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/app/app_viewer.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/app/themes/themes.dart';
import 'package:taga_cuyo/core/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:taga_cuyo/core/bloc/progress_bloc/progress_bloc.dart';
import 'package:taga_cuyo/core/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:taga_cuyo/core/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:taga_cuyo/core/cubit/category_cubit/category_cubit.dart';
import 'package:taga_cuyo/core/cubit/change_password_cubit/change_password_cubit.dart';
import 'package:taga_cuyo/core/cubit/lesson_cubit/lesson_cubit.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/firestore_user_progress_repository.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/firestore_lesson_repository.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/user_progress_repo.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';
import 'package:taga_cuyo/presentation/onboarding/get_started/get_started.dart';
import 'package:taga_cuyo/presentation/onboarding/login/login_screen.dart';

import '../core/cubit/feedback_cubit/feedback_cubit.dart';
import '../core/cubit/submit_ticket_cubit/submit_ticket_cubit.dart';
import '../core/repositories/user_progress_repository/src/firestore_user_progress_repository.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MainApp extends StatelessWidget {
  final UserRepository userRepository;
  final UserProgressRepository userProgressRepository;

  const MainApp(this.userRepository, this.userProgressRepository, {super.key});

  Future<void> _setUserOnlineStatus(BuildContext context, String userId) async {
    await userProgressRepository.updateUserOnlineDates(userId);
    await userProgressRepository.updateUserProgressStatistics(userId);
  }

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
          create: (context) {
            final userId =
                context.read<AuthenticationBloc>().state.user?.uid ?? '';
            return CategoryCubit(
              FirebaseCategoryRepository(),
              FirebaseUserProgressRepository(userRepository: userRepository),
              userId, // Now using the user ID from AuthenticationBloc
            )..fetchCategoriesWithSubcategories();
          },
        ),
        BlocProvider(
          create: (context) => LessonCubit(FirebaseLessonRepository()),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
        ),
        BlocProvider(
          create: (context) => ChangePasswordCubit(userRepository),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => userRepository,
        ),
        BlocProvider<SubmitTicketCubit>(
          create: (context) => SubmitTicketCubit(
            myUserRepository: context.read<UserRepository>(),
          ),
        ),
        BlocProvider<FeedbackCubit>(
          create: (context) => FeedbackCubit(
            myUserRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        onGenerateRoute: AppRoutes.generateRoute,
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              // Trigger category fetch on successful login
              final userId = state.user?.uid; // Extract the user ID
              if (userId != null) {
                _setUserOnlineStatus(context, userId);

                context
                    .read<CategoryCubit>()
                    .fetchCategoriesWithSubcategories(); // Fetch categories for the authenticated user
              }
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
      ),
    );
  }
}
