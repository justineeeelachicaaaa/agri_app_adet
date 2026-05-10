import 'package:flutter/material.dart';
import '../models/supply_item.dart';
import '../data/local_storage.dart';

class SupplyDetailsScreen extends StatefulWidget {
  final SupplyItem item;

  const SupplyDetailsScreen({super.key, required this.item});

  @override
  State<SupplyDetailsScreen> createState() => _SupplyDetailsScreenState();
}

class _SupplyDetailsScreenState extends State<SupplyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.itemName),
        backgroundColor: Colors.green.shade800,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              image: widget.item.imagePath != null && widget.item.imagePath!.isNotEmpty
                  ? DecorationImage(
                      image: AssetImage(widget.item.imagePath!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: widget.item.imagePath == null || widget.item.imagePath!.isEmpty
                ? Icon(
                    widget.item.category == "Seeds" ? Icons.grass : 
                    widget.item.category == "Fertilizer" ? Icons.science : Icons.build,
                    size: 120,
                    color: Colors.green.shade800,
                  )
                : null,
          ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.item.category.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  
                  Text(
                    "Standard Unit: ${widget.item.unit}",
                    style: TextStyle(fontSize: 18, color: Colors.green.shade700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Price: ₱${widget.item.price.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                  const Divider(height: 40),
                  
                  const Text(
                    "Product Description",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  
                  Text(
                    widget.item.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 40),

                 
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          int currentQty = LocalData.requisitionForm[widget.item.id] ?? 0;
                          LocalData.requisitionForm[widget.item.id] = currentQty + 1;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${widget.item.itemName} to your requisition.'),
                            backgroundColor: Colors.green.shade800,
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text("ADD TO REQUISITION", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}