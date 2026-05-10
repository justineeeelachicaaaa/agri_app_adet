import 'package:flutter/material.dart';
import '../data/local_storage.dart';
import '../models/supply_item.dart';
import '../models/user_model.dart'; 
import '../pages/login_screen.dart'; 
import '../pages/requisition_screen.dart';
import '../pages/supply_details_screen.dart';
import '../pages/about_screen.dart'; 

class DashboardScreen extends StatefulWidget {
  final User loggedInUser; 

  const DashboardScreen({super.key, required this.loggedInUser});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<SupplyItem> _filteredSupplies = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredSupplies = LocalData.availableSupplies;
  }

  // Search Function
  void _filterSupplies(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSupplies = LocalData.availableSupplies;
      } else {
        _filteredSupplies = LocalData.availableSupplies
            .where((item) => 
                item.itemName.toLowerCase().contains(query.toLowerCase()) ||
                item.category.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supply Catalog"),
        backgroundColor: Colors.green.shade800,
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RequisitionScreen()),
              ).then((_) {
                setState(() {}); 
              });
            },
          )
        ],
      ),
      
      // 1. Navigation Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green.shade900),
              accountName: Text(widget.loggedInUser.fullName),
              accountEmail: Text("${widget.loggedInUser.email} • ${widget.loggedInUser.assignedMunicipality}"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.green, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home Catalog"),
              onTap: () => Navigator.pop(context), 
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text("My Requisitions"),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequisitionScreen()),
                ).then((_) {
                  setState(() {}); 
                });
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About the App"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const AboutScreen())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text("About the Developers"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const AboutScreen())
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      
      // 2. Responsive Layout with Search Bar
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSupplies, 
              decoration: InputDecoration(
                hintText: "Search seeds, fertilizers, tools...",
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                filled: true,
                fillColor: const Color.fromARGB(255, 0, 0, 0),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.green.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.green.shade800, width: 2),
                ),
              ),
            ),
          ),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int gridColumns = constraints.maxWidth > 600 ? 2 : 1;

                if (_filteredSupplies.isEmpty) {
                  return const Center(
                    child: Text(
                      "No matching supplies found.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridColumns,
                    childAspectRatio: gridColumns == 1 ? 2.2 : 1.8, 
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _filteredSupplies.length,
                  itemBuilder: (context, index) {
                    final item = _filteredSupplies[index];
                    return _buildSupplyCard(item);
                  },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade700,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RequisitionScreen()),
          ).then((_) {
            setState(() {}); 
          });
        },
        child: Badge(
          label: Text(
            LocalData.requisitionForm.length.toString(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          isLabelVisible: LocalData.requisitionForm.isNotEmpty,
          backgroundColor: Colors.red,
          child: const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  // 3. Dynamic Catalog: Supply Card implementation
  Widget _buildSupplyCard(SupplyItem item) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell( 
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SupplyDetailsScreen(item: item), 
            ),
          ).then((_) => setState(() {})); 
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                  image: item.imagePath != null && item.imagePath!.isNotEmpty
                      ? DecorationImage(
                          image: AssetImage(item.imagePath!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: item.imagePath == null || item.imagePath!.isEmpty
                    ? Icon(
                        item.category == "Seeds" ? Icons.grass : 
                        item.category == "Fertilizer" ? Icons.science : Icons.build,
                        size: 40,
                        color: Colors.green.shade800,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.itemName,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, 
                        ),
                        Text(
                          "${item.category} • ${item.unit}",
                          style: TextStyle(color: Colors.green.shade400, fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "₱${item.price.toStringAsFixed(2)}", 
                          style: TextStyle(
                            color: Colors.orange.shade800, 
                            fontWeight: FontWeight.bold, 
                            fontSize: 14
                          ),
                        ),
                      ],
                    ),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            int currentQty = LocalData.requisitionForm[item.id] ?? 0;
                            LocalData.requisitionForm[item.id] = currentQty + 1;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${item.itemName} added to requisition.'),
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.green.shade800,
                            ),
                          );
                        },
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text("Request"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}