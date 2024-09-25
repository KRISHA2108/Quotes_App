import 'package:quotes_application/headers.dart';
import 'dart:developer';
import 'components/quotes_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isGridView = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Scaffold(
      drawer: const Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                foregroundImage: AssetImage(
                    "lib/assets/images/Amazing-HD-Black-Wallpapers.jpg"),
              ),
              accountName: Text("Krisha"),
              accountEmail: Text("krishagujarati123@gmail.com"),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://wallpapercave.com/wp/wallpeaper.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          // height: 0.2,
          // width: 0.25,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage("https://wallpapercave.com/wp/MQy6rhu.jpg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        title: const Text(
          "Quotes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
                log("$isGridView");
              });
            },
            icon: isGridView
                ? const Icon(Icons.menu)
                : const Icon(Icons.grid_view_rounded),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "lib/assets/images/Amazing-HD-Black-Wallpapers.jpg",
                ),
                fit: BoxFit.cover,
                opacity: 0.9,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "All Category",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                //ListView
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allCategories.length,
                    itemBuilder: (BuildContext context, index) =>
                        GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.categoryPage,
                          arguments: allCategories[index],
                        );
                      },
                      child: Container(
                        width: 90,
                        height: 100,
                        margin: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Text(
                          allCategories[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                //GridView
                isGridView
                    ? Expanded(
                        flex: 12,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                          ),
                          itemCount: allQuotes.length,
                          itemBuilder: (BuildContext context, index) =>
                              GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.detailPage,
                                  arguments: allQuotes[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.2),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    maxLines: 10,
                                    " ${allQuotes[index].quote}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const Spacer(),
                                  Text(
                                    " - ${allQuotes[index].author}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 12,
                        child: ListView(
                          children: allQuotes.map(
                            (e) {
                              return quotes(context: context, quote: e);
                            },
                          ).toList(),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
