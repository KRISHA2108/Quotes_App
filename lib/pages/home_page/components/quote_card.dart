import 'package:quotes_application/headers.dart';

Widget quoteCard({required String selCategory}) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all()),
      alignment: Alignment.center,
      child: Text(
        selCategory,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
