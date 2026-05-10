import 'package:flutter/material.dart';
import '../data/local_storage.dart';
// We will import the Dashboard here in the next step!
import '../pages/dashboard_screen.dart';
import '../pages/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    String inputEmail = _emailController.text.trim();
    String inputPassword = _passwordController.text.trim();

    int userIndex = LocalData.registeredUsers.indexWhere(
      (user) => user.email == inputEmail && user.password == inputPassword
    );

    if (userIndex != -1) { 
      final matchedUser = LocalData.registeredUsers[userIndex];

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(loggedInUser: matchedUser),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Access Denied"),
          content: const Text("Invalid email or password. Please check your credentials and try again."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.agriculture, size: 80, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                "AGRI-MONITOR",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text("Provincial Supply System"),
              const SizedBox(height: 48),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Government Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),

              // Login Button
           SizedBox(
             width: double.infinity,
             height: 50,
             child: ElevatedButton(
               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.green,
                 foregroundColor: Colors.white,
               ),
               onPressed: _handleLogin,
               child: const Text("SECURE LOGIN", style: TextStyle(fontSize: 16)),
             ),
           ),
           const SizedBox(height: 16),

           //Registration Link
           TextButton(
             onPressed: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const RegistrationScreen()),
               );
             },
             child: const Text(
               "New Officer? Register Here",
               style: TextStyle(color: Colors.lightGreenAccent),
             ),
           ),
            ],
          ),
        ),
      ),
    );
  }
}