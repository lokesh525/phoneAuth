

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_proj/main.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OTPscreen extends StatefulWidget {
  String verificationid;
  OTPscreen({super.key, required this.verificationid});

  @override
  State<OTPscreen> createState() => _OTPscreenState();
}

class _OTPscreenState extends State<OTPscreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter OTP',
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async{
                try {
                  PhoneAuthCredential credential =
                      await PhoneAuthProvider.credential(
                          verificationId: widget.verificationid,
                          smsCode: otpController.text.toString());
                  FirebaseAuth.instance.signInWithCredential(credential).then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'hello',)));
                  });
                } catch (ex) {
                  log(ex.toString());
                }
              },
              child: Text('OTP'))
        ],
      ),
    );
  }
}
