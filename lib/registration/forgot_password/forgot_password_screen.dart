import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_seller_frontend/registration/forgot_password/forgot_password_cubit.dart';
import 'package:smart_seller_frontend/registration/forgot_password/forgot_password_state.dart';

import '../../constants.dart';

class ForgotPasswordScreen extends StatelessWidget {

  final formkey = GlobalKey<FormState>();

  late String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formkey,
              child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                listener: (context, state){
                  if(state is ForgotPasswordFailed){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(state.message),backgroundColor: Colors.red,));
                  }
                },
                builder: (context, state)=> Column(
                  children: [
                    SizedBox(height: 24,),
                    Image.asset(state is ForgotPasswordSuccess?
                    "assets/images/inbox.png"
                        : 'assets/images/forgot_password.png', height: 100,),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      State is ForgotPasswordSuccess?
                      "Check your Inbox!" : "Forgot Password?",
                      style: TextStyle(fontSize: 24),),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      state is ForgotPasswordSuccess?
                        "Password reset email has been sent successfullly to your registered email address, so please check your inbox to set yout new password."
                        :
                        "Don'/t worry we just need your registered Email address and its done."),
                    SizedBox(
                      height: 48,
                    ),
                    _emailField(!(state is ForgotPasswordSubmitting) && !(state is ForgotPasswordSuccess), state is ForgotPasswordFailed?state.message:null),
                    SizedBox(
                      height: 24,
                    ),
                    if(state is ForgotPasswordSubmitting)
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 24,
                    ),
                    if(!(state is ForgotPasswordSuccess))
                    ElevatedButton(style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        )

                    ),
                        elevation: MaterialStateProperty.all(0),
                        fixedSize: MaterialStateProperty.all(Size(double.maxFinite, 50))

                    ), onPressed: (state is ForgotPasswordSubmitting)?null:(){
                      if(formkey.currentState!.validate()){
                        BlocProvider.of<ForgotPasswordCubit>(context).resetPassword(_email);
                      }
                    },
                        child: Text('Reset Password')),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField(enableForm, error){
    return TextFormField(
      enabled: enableForm,
      validator: (value){
        if(!RegExp(EMAIL_REGEX).hasMatch(value!)){
          return "Please enter a valid email address";
        }
        _email = value;
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: TextStyle(height: 1),
          hintText: "Enter your Register Email Address",
          labelText: "Email Address",
          suffixIcon: const Icon(Icons.email)
      ),
    );
  }
}
