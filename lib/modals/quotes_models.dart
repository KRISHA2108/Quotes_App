class QuoteModal {
  String quote;
  String author;
  String category;

  QuoteModal({
    required this.quote,
    required this.author,
    required this.category,
  });

  factory QuoteModal.fromMap({required Map data}) {
    return QuoteModal(
      quote: data['quote'],
      author: data['author'],
      category: data['category'],
    );
  }

  String selCategory = "All";
}
