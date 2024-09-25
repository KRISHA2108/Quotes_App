import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_application/headers.dart';
import 'package:share_extend/share_extend.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextStyle font = GoogleFonts.roboto();
  double quoteFontSize = 14;
  double authorFontSize = 14;
  Color quoteColor = Colors.white.withOpacity(0.2);
  Color authorColor = Colors.white.withOpacity(0.2);
  Color qColor = Colors.white;
  Color aColor = Colors.white;
  double bgOpacity = 0.2;
  bool isLiked = false;

  GlobalKey key = GlobalKey();

  Future<File> share() async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 25,
    );
    ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    Uint8List uInt8list = bytes!.buffer.asUint8List();

    final Directory directory = await getTemporaryDirectory();
    File file = await File(
            "${directory.path}/QA-${DateTime.now().millisecondsSinceEpoch}.png")
        .create();
    file.writeAsBytesSync(uInt8list);

    return file;
  }

  Widget saveChild = const Icon(Icons.save_alt_rounded);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    QuoteModal quote = ModalRoute.of(context)!.settings.arguments as QuoteModal;
    return Scaffold(
      // AppBar
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
        title: const Text(
          "Detail Page",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          //share
          IconButton(
            onPressed: () async {
              File file = await share();
              ShareExtend.share(file.path, "file");
            },
            icon: const Icon(
              Icons.share,
            ),
          ),
          //reset
          IconButton(
            onPressed: () {
              quoteFontSize = 14;
              authorFontSize = 14;
              qColor = Colors.white;
              aColor = Colors.white;
              quoteColor = Colors.white.withOpacity(0.2);
              authorColor = Colors.white.withOpacity(0.2);
              quoteImage = "";
              font = GoogleFonts.roboto();
              bgOpacity = 0.2;
              isLiked = false;
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      // Body
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Quote
                  RepaintBoundary(
                    key: key,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: size.height * 0.4,
                      width: size.width * 0.96,
                      decoration: BoxDecoration(
                        color: quoteColor.withOpacity(bgOpacity),
                        image: DecorationImage(
                          image: AssetImage(
                            quoteImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(
                            maxLines: 10,
                            quote.quote,
                            style: font.merge(
                              TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: quoteFontSize,
                                color: qColor,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SelectableText(
                                "- ${quote.author}",
                                style: font.merge(
                                  TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: authorFontSize,
                                    color: aColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              // Like Quote Button
                              IconButton(
                                onPressed: () {
                                  favQuotes.contains(quote)
                                      ? favQuotes.remove(quote)
                                      : favQuotes.add(quote);
                                  setState(() {});
                                },
                                icon: favQuotes.contains(quote)
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Quote Font Family
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(12),
                    height: 55,
                    width: size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: quoteFontFamily
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        font = e;
                                      });
                                    },
                                    child: Text(
                                      "ABC",
                                      style: e.merge(
                                        const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  // Quote Font Size
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(12),
                    height: 55,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Quote font size",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              quoteFontSize--;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            quoteFontSize.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              quoteFontSize++;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // author Font Size
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(12),
                    height: 55,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Author font size",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              authorFontSize--;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            authorFontSize.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              authorFontSize++;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Bg color
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(12),
                    height: 65,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...quoteColors
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          quoteColor = e;
                                          quoteImage = "";
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: e,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 50,
                                        width: 30,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Bg change
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(12),
                    height: 75,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...quoteImages
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          quoteImage = e;
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(e),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Quote change color
                  const Text(
                    " ----------: Quote Color :----------",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(12),
                    height: 65,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...quoteColors
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          qColor = e;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: e,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 50,
                                        width: 30,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // author change color
                  const Text(
                    "----------: Author Color :----------",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(12),
                    height: 65,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...quoteColors
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          aColor = e;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: e,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 50,
                                        width: 30,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Quote Opacity
                  const Text(
                    "----------: Quote Opacity :----------",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Slider(
                      activeColor: Colors.white,
                      inactiveColor: Colors.black,
                      value: bgOpacity,
                      onChanged: (val) {
                        setState(() {
                          bgOpacity = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
