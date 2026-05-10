class SupplyItem {
  final String id;
  final String itemName;
  final String category;
  final String unit;
  final String description;
  final double price;
  final String? imagePath;

  SupplyItem({
    required this.id,
    required this.itemName,
    required this.category,
    required this.unit,
    required this.description,
    required this.price,
    this.imagePath,
  });
}