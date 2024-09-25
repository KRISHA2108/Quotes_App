import 'package:quotes_application/headers.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String data = ModalRoute.of(context)!.settings.arguments as String;
    List quotesCategory =
        allQuoteData.where((element) => element['category'] == data).toList();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage("https://wallpapercave.com/wp/MQy6rhu.jpg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.homePage);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          data.replaceFirst(
            data[0],
            data[0].toUpperCase(),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "lib/assets/images/Amazing-HD-Black-Wallpapers.jpg"),
                fit: BoxFit.cover,
                opacity: 0.9,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: quotesCategory.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Text(
                    quotesCategory[index]['quote'],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
