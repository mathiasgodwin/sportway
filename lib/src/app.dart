import 'package:app_preference/app_preference.dart';
import 'package:app_storage/app_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_components/google_components.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sportway/configs/theme.dart';
import 'package:sportway/src/features/sportway/logic/bloc/auth/auth_bloc.dart';
import 'package:sportway/src/features/sportway/view/pages/pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AppStorage(),
        ),
        RepositoryProvider(
          create: (context) => AppPreference(),
        ),
        RepositoryProvider(
          create: (context) => GoogleComponentsRepository(
            remoteDataSource: RemoteDataSource(
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              storage: AppStorage(),
            ),
          ),
        ),
      ],
      child: const _AppBloc(),
    );
  }
}

class _AppBloc extends StatelessWidget {
  const _AppBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            context.read<GoogleComponentsRepository>(),
          )..add(AppAuthRequested()),
        ),
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final navigationKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => navigationKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: darkTheme,
      theme: lightTheme,
      navigatorKey: navigationKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            /// Check if this the first launch of the app
            final isFirstLaunch =
                RepositoryProvider.of<AppPreference>(context).isFirstLaunch;

            /// Check if user has setup sport interest during sign-up process
            final hasInterest = RepositoryProvider.of<AppPreference>(context)
                    .getBool(key: 'hasInterest') ??
                false;

            /// Navigate to OnboardingPage if [isFirstLaunch] is `true`
            if (isFirstLaunch) {
              FlutterNativeSplash.remove();
              _navigator.pushAndRemoveUntil(
                OnboardingPage.go(),
                (route) => false,
              );
            } else {
              switch (state.status) {
                case AuthStatus.authenticated:
                  FlutterNativeSplash.remove();
                  if (hasInterest) {
                    _navigator.pushAndRemoveUntil(
                      HomePage.go(),
                      (route) => false,
                    );
                  } else {
                    _navigator.pushAndRemoveUntil(
                      SportInterestPage.go(),
                      (route) => false,
                    );
                  }
                  break;
                case AuthStatus.unauthenticated:
                  FlutterNativeSplash.remove();
                  _navigator.pushAndRemoveUntil(
                    LoginPage.go(),
                    (route) => false,
                  );
                  break;
                default:
                  break;
              }
            }
          },
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Sport Way - Connection that matters',
      onGenerateRoute: (route) {
        return SplashPage.go();
      },
    );
  }
}
