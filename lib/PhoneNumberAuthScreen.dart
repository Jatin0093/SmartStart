import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartstart/Constanst.dart';
import 'package:smartstart/HomePage.dart';
import 'package:smartstart/OtpverificationScreen.dart';
import 'package:smartstart/SplashScreen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberAuthScreen extends StatefulWidget {
  const PhoneNumberAuthScreen({Key? key}) : super(key: key);

  @override
  _PhoneNumberAuthScreenState createState() => _PhoneNumberAuthScreenState();
}


int numCount = 10;

class _PhoneNumberAuthScreenState extends State<PhoneNumberAuthScreen> {

  late Future<FirebaseApp> _firebaseApp;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseApp = Firebase.initializeApp();
  }

  bool? isLoggedIn = (Constanst.getLogIn()==null)?false:Constanst.getLogIn();
  bool otpSent = false;
  String? uid;
  String _verificationId = '';
  String number = '';
  String _phoneNumber = '';

  void _sendOTP() async{
    if(_phoneNumber.length > numCount ){
      await FirebaseAuth.instance
          .verifyPhoneNumber(
              phoneNumber: _phoneNumber,
              verificationCompleted: verificationCompleted,
              verificationFailed: verificationFailed,
              codeSent: codeSent,
              codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
          .then((value) {
        setState(() {
          otpSent = true;
        });
      });
    }else{
      toast("Please Enter Phone Number Correctlty");
    }
  }

  void codeAutoRetrievalTimeout(String verificationID){
    setState(() {
      _verificationId = _verificationId;
      otpSent = true;
    });

  }

  void codeSent(String verificationId, [int? a]){
    setState(() {
      _verificationId = verificationId;
      otpSent = true;
    });
  }

  void verificationFailed(FirebaseAuthException exception) {
    setState(() {
      isLoggedIn = false;
      Constanst.setLogIn(false);
      otpSent = false;
    });
  }

  void verificationCompleted(PhoneAuthCredential credential) async{
    await FirebaseAuth.instance.signInWithCredential(credential);
    if(FirebaseAuth.instance.currentUser != null){
      setState(() {
        isLoggedIn = true;
        Constanst.setLogIn(true);
        uid = FirebaseAuth.instance.currentUser!.uid;
      });
    }else{
      toastLong("Failed to Verify Number");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _firebaseApp,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return  const MaterialApp(home: Splash());
            return isLoggedIn!
                ? Home()
                : otpSent
                ? OtpVerificationScreen(verificationId: _verificationId,)
                : SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/Splash.png',
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.width+0.5,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      "Let's get started",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Add your phone number. we'll send you a verification code so we know you're real",
                      style:  TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IntlPhoneField(
                        validator: (value){
                          print(value);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onCountryChanged: (phoneNo){
                          numCount = countries.firstWhere((element) => element['code'] == phoneNo.countryISOCode)['max_length'];
                        },
                        onChanged: (phone) {
                          print(phone.completeNumber);
                          print(numCount);
                          print(phone.completeNumber.length);
                          _phoneNumber = phone.completeNumber;
                        },
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: (){
                    //     _sendOTP;
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: MediaQuery.of(context).size.width *0.4,
                    //     decoration: BoxDecoration(
                    //       color: (number.length!=numCount)?Colors.red.shade200:Colors.red,
                    //       borderRadius: BorderRadius.circular(15)
                    //     ),
                    //     child: const Center(
                    //       child: Text("Send OTP",style: const TextStyle(color: Colors.white),),
                    //     ),
                    //   ),
                    // ),
                    ElevatedButton(
                      onPressed: _sendOTP,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // Background color
                      ),
                      child: const Text("Send OTP"),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
