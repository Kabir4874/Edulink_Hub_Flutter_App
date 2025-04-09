class Book {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final List<String> reviews;
  final String pdfUrl;
  bool isPurchased; // Track purchase status

  Book({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.reviews,
    required this.pdfUrl,
    this.isPurchased = false, // Default as not purchased
  });
}
