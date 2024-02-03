import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final String movieId;
  final String movieName;

  const MovieDetailPage(
      {super.key, required this.movieId, required this.movieName});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  Map<String, dynamic>? movieDetails;

  @override
  void initState() {
    super.initState();
    getMovieDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1FAEE),
        appBar: AppBar(
          title: Text(
            widget.movieName,
            style: const TextStyle(
              fontSize: 25,
              color: Color(0xFFF1FAEE),
            ),
          ),
          backgroundColor: const Color(0xFF457B9D),
        ),
        body: movieDetails == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (
        OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  MovieImageName(
                    poster: movieDetails!['Poster'],
                    title: movieDetails!['Title'],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE63946),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        MoviePlot(
                          plot: movieDetails!['Plot'],
                        ),
                        SizedBox(height: 10,),
                        MovieDetails(
                          IMDbRating: movieDetails!['imdbRating'],
                          released: movieDetails!['Released'],
                          runtime: movieDetails!['Runtime'],
                          genre: movieDetails!['Genre'],
                        ),
                        SizedBox(height: 10,),
                        MovieHumans(
                          director: movieDetails!['Director'],
                          writer: movieDetails!['Writer'],
                          actors: movieDetails!['Actors'],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
          } else {
            return SingleChildScrollView(
child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  MovieImageName(
                    poster: movieDetails!['Poster'],
                    title: movieDetails!['Title'],
                  ),
                  SizedBox(width: 10,),
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE63946),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        MoviePlot(
                          plot: movieDetails!['Plot'],
                        ),
                        SizedBox(height: 10,),
                        MovieDetails(
                          IMDbRating: movieDetails!['imdbRating'],
                          released: movieDetails!['Released'],
                          runtime: movieDetails!['Runtime'],
                          genre: movieDetails!['Genre'],
                        ),
                        SizedBox(height: 10,),
                        MovieHumans(
                          director: movieDetails!['Director'],
                          writer: movieDetails!['Writer'],
                          actors: movieDetails!['Actors'],
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            );
          }
        })
        )
    );
  }

  Future<void> getMovieDetails() async {
    try {
      var dio = Dio();
      var response = await dio.get(
        'https://www.omdbapi.com/?apikey=eee41f18&i=${widget.movieId}',
        // Replace YourApiKey with your actual API key
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          movieDetails = response.data;
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

class MovieImageName extends StatelessWidget {
  final String? poster;
  final String? title;

  const MovieImageName({super.key, this.poster, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF457B9D),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Image.network(
            poster!,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF1FAEE),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoviePlot extends StatelessWidget {
  final String? plot;

  const MoviePlot({super.key, this.plot});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF457B9D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        plot!,
        style: const TextStyle(
          fontSize: 20,
          color: Color(0xFFF1FAEE),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class MovieDetails extends StatelessWidget {
  final String? IMDbRating;
  final String? released;
  final String? runtime;
  final String? genre;

  const MovieDetails(
      {super.key, this.IMDbRating, this.released, this.runtime, this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF457B9D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'IMDB Rating: ${IMDbRating!}',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFF1FAEE),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Released: $released',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFF1FAEE),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Runtime: ${runtime}',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFF1FAEE),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Genre: ${genre}',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFF1FAEE),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieHumans extends StatelessWidget {
  final String? director;
  final String? writer;
  final String? actors;

  const MovieHumans({super.key, this.director, this.writer, this.actors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF457B9D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Director: ${director!}',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFF1FAEE),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Writer: ${writer!}',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFF1FAEE),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Actors: ${actors!}',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFF1FAEE),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
