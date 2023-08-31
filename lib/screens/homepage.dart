import 'package:flutter/material.dart';
import 'package:marvel_hero/models/hero_data_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MarvelScreen extends StatefulWidget {
  const MarvelScreen({super.key});

  @override
  State<MarvelScreen> createState() => _MarvelScreenState();
}

class _MarvelScreenState extends State<MarvelScreen> {
  List<int> listid = [];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var hero = Heros[index];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Icon(
          Icons.person,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SlidingUpPanel(
        parallaxEnabled: true,
        minHeight: 170,
        color: Colors.transparent,
        body: PageView(
          children: Heros.map((hero) => Image.asset(
                hero.mainimage,
                fit: BoxFit.fill,
              )).toList(),
          onPageChanged: (index) => setState(() {
            this.index = index;
          }),
        ),
        panelBuilder: (ScrollController scrollController) {
          return Column(
            children: [firstScreen(hero), secondScreen(hero)],
          );
        },
      ),
    );
  }

  Widget firstScreen(hero) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text(
                "POPULARITY",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                hero.popularity,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "MOVIES",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                hero.moviecount,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "RATING",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                hero.rating,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget secondScreen(hero) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hero.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(hero.loction)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (listid.contains(hero.id)) {
                      listid.remove(hero.id);
                    } else {
                      listid.add(hero.id);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  width: listid.contains(hero.id) ? 50 : 120,
                  height: 50,
                  child: listid.contains(hero.id)
                      ? buildShrinked()
                      : buildStretched(),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Description: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            hero.description,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Character",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: hero.movies
                  .map<Widget>((url) => Container(
                        height: 80,
                        width: 100,
                        padding: const EdgeInsets.only(right: 5),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(url, fit: BoxFit.fill)),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget buildStretched() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.red, width: 2.5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Center(
          child: FittedBox(
            child: Text(
              'Favourite',
              style: TextStyle(
                color: Colors.red,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
  Widget buildShrinked() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.red),
        child: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
      );
}
