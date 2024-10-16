import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper/pages/fullscreen.dart';
import 'package:http/http.dart' as http;

class WallPapersPage extends StatefulWidget {
  const WallPapersPage({super.key});

  @override
  State<WallPapersPage> createState() => _WallPapersPageState();
}

class _WallPapersPageState extends State<WallPapersPage> {
  String apiKey = 'lbxaIPI8uDYCYFBsHMz7VZk1j7PqJ1mRKFCljmw8wUpn7XpC78IbtJIN';
  List images = [];
  int page = 1;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fetchImages();
  }

  fetchImages() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=60'),
        headers: {
          'Authorization': apiKey,
        }).then((value) {
      Map result = jsonDecode(value.body);

      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  searchImages() async {
    String url;
    if (searchController.text.isNotEmpty) {
      url =
          "https://api.pexels.com/v1/search?per_page=80&query=${searchController.text}";
    } else {
      url = "https://api.pexels.com/v1/curated?per_page=60";
    }

    await http.get(Uri.parse(url), headers: {
      'Authorization': apiKey,
    }).then((value) {
      Map result = jsonDecode(value.body);

      setState(() {
        images = result['photos'];
      });
    });
  }

  Future<void> loadMore() async {
    String url;
    setState(() {
      page++;
    });
    if (searchController.text.isEmpty) {
      url =
          'https://api.pexels.com/v1/curated?per_page=60&page=${page.toString()}';
    } else {
      url =
          'https://api.pexels.com/v1/search?per_page=80&query=${searchController.text}&page=${page.toString()}';
    }

    await http.get(Uri.parse(url), headers: {
      'Authorization': apiKey,
    }).then((value) {
      Map result = jsonDecode(value.body);

      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WallPapers'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchImages();
                    },
                    icon: const Icon(Icons.search),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 2 / 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                    imageUrl: images[index]['src']
                                        ['large2x'])));
                      },
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    );
                  })),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: Center(
                child: GestureDetector(
                    onTap: () {
                      loadMore();
                    },
                    child: const Text('Load More'))),
          )
        ],
      ),
    );
  }
}
