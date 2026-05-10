import 'package:flutter/material.dart';
import '../data/local_storage.dart';
import '../models/supply_item.dart';

class RequisitionScreen extends StatefulWidget {
  const RequisitionScreen({super.key});

  @override
  State<RequisitionScreen> createState() => _RequisitionScreenState();
}

class _RequisitionScreenState extends State<RequisitionScreen> {
  
  // Helper function to find item details based on ID
  SupplyItem _getSupplyDetails(String id) {
    return LocalData.availableSupplies.firstWhere((item) => item.id == id);
  }

  
  void _updateQuantity(String id, int change) {
    setState(() {
      int currentQty = LocalData.requisitionForm[id] ?? 0;
      int newQty = currentQty + change;

      if (newQty <= 0) {
        LocalData.requisitionForm.remove(id);
      } else {
        LocalData.requisitionForm[id] = newQty;
      }
    });
  }

  void _clearForm() {
    setState(() {
      LocalData.requisitionForm.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Requisition form cleared."), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> cartItems = LocalData.requisitionForm;

    double grandTotal = 0;
    cartItems.forEach((id, quantity) {
      final item = _getSupplyDetails(id);
      grandTotal += item.price * quantity;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Requisitions"),
        backgroundColor: Colors.green.shade800,
        actions: [
          // Clear Form Button
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: "Clear Form",
            onPressed: cartItems.isEmpty ? null : _clearForm,
          )
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "No supplies requested yet.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                String itemId = cartItems.keys.elementAt(index);
                int quantity = cartItems[itemId]!;
                
              
                SupplyItem item = _getSupplyDetails(itemId);
                
                
                double subtotal = item.price * quantity;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8),
                            image: item.imagePath != null
                                ? DecorationImage(
                                    image: AssetImage(item.imagePath!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: item.imagePath == null
                              ? Icon(Icons.inventory, color: Colors.green.shade800)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        
                        // Item Details & Subtotal
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.itemName,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "₱${item.price.toStringAsFixed(2)} x $quantity ${item.unit}",
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Subtotal: ₱${subtotal.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.orange.shade800, 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Quantity Controls
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                              onPressed: () => _updateQuantity(itemId, -1),
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                              onPressed: () => _updateQuantity(itemId, 1),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            
      
      bottomNavigationBar: cartItems.isEmpty ? null : Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 58, 58, 58),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("GRAND TOTAL:", style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
                Text("₱${grandTotal.toStringAsFixed(2)}", 
                     style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Requisition Submitted to Provincial Office!"), backgroundColor: Colors.green),
                  );
                  _clearForm(); // Clears after successful submission
                },
                child: const Text("SUBMIT REQUISITION", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 