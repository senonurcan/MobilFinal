import 'dart:convert';

import 'package:deneme/Config/SecureStorage.dart';
import 'package:deneme/Screens/StartupPage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'MovieDetailPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Movie> movies = [];
  String userName = "";

  @override
  void initState() {
    super.initState();
    getMovies();
    SecureStorage().readSecureData('user').then((value) {
      setState(() {
        userName = jsonDecode(value)['userName'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FAEE),
      appBar: AppBar(
        title: const Text(
          "Ana Sayfa",
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFFF1FAEE),
          ),
        ),
        backgroundColor: const Color(0xFF457B9D),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFF1FAEE),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFFE63946),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profil.jpg'),
                      radius: 30,
                    ),
                    const SizedBox(width: 15),
                    Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color(0xFFF1FAEE),
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                  ],
                ),
              ),
              // put all listTiles here but make background color red
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/ProfilePage");
                },
                leading: const Icon(
                  Icons.account_circle,
                  color: Color(0xFF1D3557),
                  size: 30,
                ),
                title: const Text(
                  'Profil',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF1D3557),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/ContactPage");
                },
                leading: const Icon(
                  Icons.contact_mail,
                  color: Color(0xFF1D3557),
                  size: 30,
                ),
                title: const Text(
                  'İletişim',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF1D3557),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  SecureStorage().deleteSecureData('user');
                  Navigator.of(context).popUntil((route) => route.isFirst);

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => const StartupPage()));
                },
                leading: const Icon(
                  Icons.logout,
                  color: Color(0xFF1D3557),
                  size: 30,
                ),
                title: const Text(
                  'Çıkış Yap',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF1D3557),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        // eğer ekran yatay ise 2 sütunlu liste göster
        if (orientation == Orientation.landscape) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieBox(movies[index]);
            },
          );
        }
        else {
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieBox(movies[index]);
            },
          );
        }
      }),
    );
  }

  Future<void> getMovies() async {
    try {
      var dio = Dio();
      var response = await dio.get(
        'https://www.omdbapi.com/?apikey=eee41f18&s=batman', // Replace YourApiKey with your actual API key
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> movieList = response.data['Search'];
          movies = movieList.map((movie) => Movie.fromMap(movie)).toList();
        });
      } else {
        print('Error fetching movie data: ${response.statusCode}');
        // Handle error appropriately
      }
    } catch (error) {
      print('Error fetching movie data: $error');
      // Handle error appropriately
    }
  }
}

class Movie {
  final String title;
  final String imageUrl;
  final String imdbID;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.imdbID,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['Title'],
      imageUrl: map['Poster'],
      imdbID: map['imdbID'],
    );
  }
}

class MovieBox extends StatelessWidget {
  final Movie movie;

  const MovieBox(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieDetailPage(movieId: movie.imdbID, movieName: movie.title)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF457B9D), width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
          color: const Color(0xFFA8DADC),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              movie.imageUrl,
              fit: BoxFit.contain,

              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }
            ),
            const SizedBox(height: 8.0),
            Text(
              movie.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
