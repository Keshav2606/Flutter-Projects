import 'package:flutter/material.dart';
import 'package:flutter_movies/utils/custom_text.dart';

class MovieDescriptionPage extends StatelessWidget {
  final Map movie;
  const MovieDescriptionPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title'] ?? 'Movie'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Positioned(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}'),
              )),
              Positioned(
                  bottom: 10,
                  child: CustomText(
                      text: ' ⭐ Average Rating: ${movie['vote_average']}',
                      size: 16))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          CustomText(text: movie['title'] ?? 'Movie Name', size: 25),
          CustomText(text: 'Released on: ${movie['release_date']}', size: 16),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                width: 120,
                child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
              ),
              Flexible(child: CustomText(text: movie['overview'], size: 16))
            ],
          )
        ],
      ),
    );
  }
}
