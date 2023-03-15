import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_seller_frontend/constants.dart';
import 'package:smart_seller_frontend/registration/otp/otp_screen.dart';
import 'package:smart_seller_frontend/registration/sign_up/signup_cubit.dart';
import 'package:smart_seller_frontend/registration/sign_up/signup_state.dart';

import '../login/login_screen.dart';

class SignUpScreen extends StatelessWidget {

  final formkey = GlobalKey<FormState>();

  late String _email;
  late String _phone;
  late String _name;
  late String _password;
  late String _confirmpassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formkey,
              child: BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state){
                  if(state is SignUpSuccess){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => OtpScreen())
                    );
                  }
                  if(state is SignUpFailed){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),backgroundColor: Colors.red,));
                  }
                },
                builder: (context, state){
                  return Column(
                    children: [
                      SizedBox(height: 24,),
                      Image.asset('assets/images/logo.png', height: 100,),
                      SizedBox(height: 44,),
                      _emailField(!(state is SignUpSubmitting), state is SignUpFailed ? state.message == 'email already exists'?state.message:null :null),
                      SizedBox(height: 21,),
                      _phoneField(!(state is SignUpSubmitting), state is SignUpFailed ? state.message == 'phone already exists'?state.message:null :null),
                      SizedBox(height: 21,),
                      _nameField(!(state is SignUpSubmitting)),
                      SizedBox(height: 21,),
                      _passwordField(!(state is SignUpSubmitting)),
                      SizedBox(height: 21,),
                      _confirmpasswordField(!(state is SignUpSubmitting)),
                      SizedBox(height: 25,),
                      if(state is SignUpSubmitting)
                        CircularProgressIndicator(),
                      SizedBox(height: 28,),
                      ElevatedButton(style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                          )

                        ),
                        elevation: MaterialStateProperty.all(0),
                        fixedSize: MaterialStateProperty.all(Size(double.maxFinite, 50))
                        
                      ), onPressed: (state is SignUpSubmitting)?null:(){
                        if(formkey.currentState!.validate()){
                          BlocProvider.of<SignUpCubit>(context).requestOtp(_email, _phone);
                        }
                      },
                          child: Text('Create Account')),
                      SizedBox(
                        height: 48,
                      ),
                      TextButton(onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                        );
                      }, child: Text('Allready have an account? Login'))
                    ],
                  );
                },
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
        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)){
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
        hintText: "Enter your Email Address",
        labelText: "Email Address",
        suffixIcon: const Icon(Icons.email)
      ),
    );
  }

  Widget _phoneField(enableForm, error){
    return TextFormField(
      maxLength: 10,
      enabled: enableForm,
      validator: (value){
        if(value!. length !=10){
          return "Please enter a valid Phone Number";
        }
        _phone = value;
      },
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 14),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: TextStyle(height: 1),
          hintText: "Enter your Phone Number",
          labelText: "Phone",
          suffixIcon: const Icon(Icons.smartphone)
      ),
    );
  }

  Widget _nameField(enableForm){
    return TextFormField(
      enabled: enableForm,
      validator: (value){
        if(value!. length <= 1){
          return "Please enter a valid Name";
        }
        _name = value;
      },
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: TextStyle(height: 1),
          hintText: "Enter your Name",
          labelText: "Fullname",
          suffixIcon: const Icon(Icons.person)
      ),
    );
  }

  Widget _passwordField(enableForm){
    return TextFormField(
      enabled: enableForm,
      obscureText: true,
      validator: (value){
        if(value!. length < 8){
          return "Please enter a 8 characters";
        }
        _password = value;
      },
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: TextStyle(height: 1),
          hintText: "Password",
          labelText: "Password",
          suffixIcon: const Icon(Icons.lock)
      ),
    );
  }

  Widget _confirmpasswordField(enableForm){
    return TextFormField(
      enabled: enableForm,
      obscureText: true,
      validator: (value){
        if(value != _password){
          return "Password mismatched!";
        }
        _confirmpassword = value!;
      },
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: TextStyle(height: 1),
          hintText: "Confirm Password",
          labelText: "Confirm Password",
          suffixIcon: const Icon(Icons.lock)
      ),
    );
  }


}
