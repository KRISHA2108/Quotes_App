import 'package:quotes_application/headers.dart';

Widget quotes({required BuildContext context, required QuoteModal quote}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, Routes.detailPage, arguments: quote);
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.2),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quote.quote,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
