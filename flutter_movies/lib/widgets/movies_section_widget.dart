import 'package:flutter/material.dart';
import 'package:flutter_movies/pages/movie_description_page.dart';
import 'package:flutter_movies/utils/custom_text.dart';
// import 'package:flutter_movies/widgets/movies_poster_widget.dart';

class MoviesSectionWidget extends StatelessWidget {
  final String title;
  final List movies;
  const MoviesSectionWidget(
      {super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: title, size: 20),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 240,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 20,
                  );
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MovieDescriptionPage(movie: movies[index])));
                    },
                    child: SizedBox(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${movies[index]['poster_path']}'),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          CustomText(
                              text: movies[index]['title'] ?? 'Loading',
                              size: 12)
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
