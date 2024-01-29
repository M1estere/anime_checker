import 'package:film_checker/api/api.dart';
import 'package:film_checker/models/movie.dart';
import 'package:flutter/material.dart';

class ExplorePageView extends StatefulWidget {
  const ExplorePageView({super.key});

  @override
  State<ExplorePageView> createState() => _ExplorePageViewState();
}

class _ExplorePageViewState extends State<ExplorePageView> {
  late Future<List<Movie>> randomAnime;

  @override
  void initState() {
    super.initState();
    randomAnime = Api().getRandomAnime(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .85,
          width: double.infinity,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            height: MediaQuery.of(context).size.height * .4,
            child: FutureBuilder<List<Movie>>(
              future: Api().getRandomAnime(5),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          right: 15,
                        ),
                        height: MediaQuery.of(context).size.height * .35,
                        width: MediaQuery.of(context).size.width * .35,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .3,
                              width: double.infinity,
                              child: Image.network(
                                fit: BoxFit.cover,
                                "https://cdn.myanimelist.net/images/anime/1768/111676l.jpg",
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const Center(
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            Text(
                              snapshot.data![index].title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  );
                }
                return const Center(
                  child: Text(
                    'error here',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
