import 'package:flutter/material.dart';
import 'package:flutter_movies/widgets/movies_section_widget.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _apiKey = 'b6c9840b9364e52061f772b66dde3055';
  final String _apiReadAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNmM5ODQwYjkzNjRlNTIwNjFmNzcyYjY2ZGRlMzA1NSIsIm5iZiI6MTcyODIzMDY3OC4wMDcxNjMsInN1YiI6IjY2ZmQxYjRjYzZmYmIyZjBjZGYyM2M3ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Z-DqZjvMoB_UBzcdfJ71r1FzmMmIIinEisz5CxZZ0D8';
  List trendingMovies = [];
  List topRatedMovies = [];
  List tvShows = [];

  @override
  void initState() {
    loadTrendingMovies();
    super.initState();
  }

  loadTrendingMovies() async {
    TMDB tmdbWithCustomLog = TMDB(ApiKeys(_apiKey, _apiReadAccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));

    Map trendingMoviesResponse =
        await tmdbWithCustomLog.v3.trending.getTrending();

    Map topRatedMoviesResponse =
        await tmdbWithCustomLog.v3.movies.getTopRated();

    Map tvShowsResponse = await tmdbWithCustomLog.v3.tv.getPopular();

    setState(() {
      trendingMovies = trendingMoviesResponse['results'];
      topRatedMovies = topRatedMoviesResponse['results'];
      tvShows = tvShowsResponse['results'];
    });

    print(trendingMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Movies'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  child: MoviesSectionWidget(
                      title: 'Trending Movies', movies: trendingMovies)),
              Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  child: MoviesSectionWidget(
                      title: 'Top Rated Movies', movies: topRatedMovies)),
              Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  child: MoviesSectionWidget(
                      title: 'Popular TV Shows', movies: tvShows))
            ],
          ),
        ));
  }
}
