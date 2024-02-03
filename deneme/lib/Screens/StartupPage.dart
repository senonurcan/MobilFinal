import 'package:flutter/material.dart';

class StartupPage extends StatelessWidget{
  const StartupPage({super.key});
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF1FAEE),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Outer padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First item: Image
              Image.asset(
                'assets/images/film.png',
                width: 200, // Adjust the size as needed
                height: 200,
              ),
              const SizedBox(height: 20), // Spacer

              // Second item: "Giriş yap" button
              SizedBox(
                width: double.infinity, // Button takes 100% width
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/LoginPage");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1D3557),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Giriş yap',
                    style: TextStyle(color: Colors.white, fontSize: 24)
                  )
                ),
              ),
              const SizedBox(height: 10), // Spacer

              // Third item: "Kayıt ol" button
              SizedBox(
                width: double.infinity, // Button takes 100% width
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/RegisterPage");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFFFFF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Kayıt ol', style: TextStyle( fontSize: 16,
                    color: Color(0xFF1D3557))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}