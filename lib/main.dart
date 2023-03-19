import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_seller_frontend/constants.dart';
import 'package:smart_seller_frontend/home/home_screen.dart';
import 'package:smart_seller_frontend/registration/authentication/auth_cubit.dart';
import 'package:smart_seller_frontend/registration/authentication/auth_repository.dart';
import 'package:smart_seller_frontend/registration/authentication/auth_state.dart';
import 'package:smart_seller_frontend/registration/authentication/authenticating_screen.dart';
import 'package:smart_seller_frontend/registration/sign_up/signup_cubit.dart';
import 'package:smart_seller_frontend/registration/sign_up/signup_screen.dart';

final AuthRepository authRepository = AuthRepository();
final storage = FlutterSecureStorage();
final AuthCubit authCubit = AuthCubit(storage: storage, authRepository: authRepository);

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if(authCubit.state is AuthInitial){
    await authCubit.authenticate();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authCubit,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state){
          
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: PRIMARY_SWATCH,
            ),
            home: state is Authenticated ? HomeScreen():state is AuthenticationField || state is Authenticating?AuthenticatingScreen():BlocProvider<SignUpCubit>(create:(_)=>SignUpCubit(),child: SignUpScreen()),
          );
        },
        
      ),
    );
  }
}
