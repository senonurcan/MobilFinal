import 'dart:convert';

import 'package:deneme/Config/SecureStorage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF457B9D),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Image(
              image: AssetImage('assets/images/profil.jpg'),
              width: 150,
              height: 150,
            ),
          ),
        ),
      ],
    );
  }
}

class RestContainer extends StatefulWidget {
  const RestContainer({super.key});

  @override
  State<RestContainer> createState() => _RestContainerState();
}

class _RestContainerState extends State<RestContainer> {
  bool _isPasswordHide = true;
  Map<String, dynamic> user = {};

  void initState() {
    super.initState();
    SecureStorage().readSecureData('user').then((value) {
      setState(() {
        user = jsonDecode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF457B9D),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          //scrollable
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Kullanıcı Adı",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF1FAEE),
                  ),
                ),
                const Divider(
                  color: Color(0xFFF1FAEE),
                  thickness: 2,
                ),
                Text(
                  user['userName'],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFFF1FAEE),
                  ),
                ),
                const SizedBox(height: 20,),

                const MySeparator(),

                const SizedBox(height: 20,),

                const Text(
                  "E-mail",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF1FAEE),
                  ),
                ),
                const Divider(
                  color: Color(0xFFF1FAEE),
                  thickness: 2,
                ),

                Text(
                  user['email'],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFFF1FAEE),
                  ),
                ),

                const SizedBox(height: 20,),

                const MySeparator(),

                const SizedBox(height: 20,),
                const Text(
                  "Şifre",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF1FAEE),
                  ),
                ),
                const Divider(
                  color: Color(0xFFF1FAEE),
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _isPasswordHide
                        ? const Text(
                      "********",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFF1FAEE),
                      ),
                    )
                        : Text(
                      user['password'],
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFFF1FAEE),
                      ),
                    ),
                    IconButton(
                      style: ButtonStyle(
                        iconColor: MaterialStateProperty.all(
                            const Color(0xFFF1FAEE)),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHide = !_isPasswordHide;
                        });
                      },
                      icon: Icon(_isPasswordHide
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FAEE),
      appBar: AppBar(
        title: const Text(
          "Profil",
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFFF1FAEE),
          ),
        ),
        backgroundColor: const Color(0xFF457B9D),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const Column(
            children: [
              SizedBox(height: 20),
              ImageContainer(),
              SizedBox(height: 20),
              RestContainer(),
            ],
          );
        } else {
          return const Row(
            children: [
              SizedBox(width: 20),
              ImageContainer(),
              SizedBox(width: 20),
              RestContainer(),
            ],
          );
        }
      }),
    );
  }
}


class MySeparator extends StatelessWidget {
  const MySeparator({super.key, this.height = 1, this.color = Colors.black});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
