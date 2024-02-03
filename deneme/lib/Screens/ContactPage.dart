import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Config/SecureStorage.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String userMail = "";
  String userPhone = "";

  void initState() {
    super.initState();
    SecureStorage().readSecureData('user').then((value) {
      setState(() {
        userMail = jsonDecode(value)['email'];
        userPhone = jsonDecode(value)['phone'];
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF1FAEE),
      appBar: AppBar(
        title: const Text(
          "İletişim",
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFFF1FAEE),
          ),
        ),
        backgroundColor: const Color(0xFF457B9D),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("İletişim Bilgileri",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFFF1FAEE),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                height: 20,
                color: Color(0xFFF1FAEE),
              ),
              Text(
                userMail,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFFF1FAEE),
                ),
              ),
              InkWell(
                onTap: () {
                  _sendEmail(userMail);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Mail Gönder",style: TextStyle(fontSize: 20,color: Color(0xFFEC9A9A)),),
                    IconButton(
                      icon: const Icon(Icons.mail),
                      onPressed: () {
                        _sendEmail(userMail);
                      },
                      color: const Color(0xFFEC9A9A),
                    ),
                  ],
                ),
              ),

              const Divider(
                height: 20,
                color: Color(0xFFF1FAEE),
              ),
              Text(
                userPhone,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFFF1FAEE),
                ),
              ),

              InkWell(
                onTap: () {
                  _makePhoneCall(userPhone);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ara",style: TextStyle(fontSize: 20,color: Color(0xFFEC9A9A)),),
                    IconButton(
                      icon: const Icon(Icons.phone),
                      onPressed: () {
                        _makePhoneCall(userPhone);
                      },
                      color: const Color(0xFFEC9A9A),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }
}
