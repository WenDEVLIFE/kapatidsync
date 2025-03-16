import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


import 'YahooCredentials.dart';


class YahooService {

  // Get the API key from EmailKey.dart
  String username = YahooCredentials().email;
  String password = YahooCredentials().password;

  void sendEmail(int otp, String recipient, Function(bool) setLoading, BuildContext context) async {
    setLoading(true); // Start loading

    final smtpServer = SmtpServer('smtp.mail.yahoo.com',
        port: 587,
        username: username,
        password: password,
        ignoreBadCertificate: true);

    final message = Message()
      ..from = Address(username, 'Kapatid Sync')
      ..recipients.add(recipient)
      ..subject = 'Pet Welfare PH Forgto Password Verification code'
      ..text = 'Your OTP is $otp. Please enter this OTP to proceed to change the password.';

    try {
      final sendReport = await send(message, smtpServer);
      Fluttertoast.showToast(
          msg: 'OTP sent to your email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
    } finally {
      setLoading(false); // Stop loading
    }
  }
}