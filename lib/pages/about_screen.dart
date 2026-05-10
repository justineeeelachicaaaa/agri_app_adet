import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("System Information"),
        backgroundColor: Colors.green.shade800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: About the App
            const Text(
              "About Agri-Monitor",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 10),
            const Text(
              "The Provincial Crop Production & Supply Monitor is a digital solution designed for the Provincial Agriculture Office. "
              "It streamlines the requisition of farming supplies and monitors crop production distribution across the six municipalities of Marinduque.",
              style: TextStyle(
                fontSize: 16, 
                height: 1.5),
            ),
            const SizedBox(height: 20),
            
            // Section: Data Privacy
            const Card(
              color: Colors.black26,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.security, color: Colors.lightGreenAccent),
                        SizedBox(width: 10),
                        Text("Data Privacy Compliance", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "In compliance with the Data Privacy Act of 2012, all officer information collected during registration is stored locally in-memory and is used solely for the simulation of this application's functions.",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 40),

            // Section: About the Developers
            const Text(
              "The Developers",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            
            //Jhon Kyn
            _buildDeveloperTile(
              context: context,
              name: "Jhon Kyn Axix Cabrigas",
              role: "UI/UX Designer and Lead Programmer",
              bio: "The best way to predict the future is to invent it. — Alan Kay",
              imageAsset: "assets/images/kyn.jpg",
              facebookUrl: "https://www.facebook.com/jk.cabrigas",
              email: "cabrigas.jhonkynaxix@marsu.edu.ph"
            ),
            const SizedBox(height: 16),
            
            //Justine
            _buildDeveloperTile(
              context: context,
              name: "Justine Lachica",
              role: "System Analyst and Backup Programmer",
              bio: "Technology expands our way of thinking about things, and expands our way of doing things. — Herbert Simon",
              imageAsset: "assets/images/lachica.jpg",
              facebookUrl: "https://www.facebook.com/justinotpanot",
              email: "lachica.justine@marsu.edu.ph",
            ),
            const SizedBox(height: 16),
            
            //Ian Simon
            _buildDeveloperTile(
              context: context,
              name: "Ian Simon Francis Rey",
              role: "Project Manager",
              bio: "Technology is best when it brings people together. — Matt Mullenweg",
              imageAsset: "assets/images/ian.jpg", 
              facebookUrl: "https://www.facebook.com/ian.rey.183811",
              email: "rey.iansimonfrancis@marsu.edu.ph",
            ),
            const SizedBox(height: 16),
            
            //Jay Vincent
            _buildDeveloperTile(
              context: context,
              name: "Jay Vincent Motol",
              role: "Researcher",
              bio: "You affect the world by what you browse. — Tim Berners-Lee",
              imageAsset: "assets/images/vincent.jpg",
              facebookUrl: "https://www.facebook.com/bisente.02",
              email: "motol.jayvincent@marsu.edu.ph"
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperTile({
    required BuildContext context,
    required String name, 
    required String role, 
    required String bio, 
    String? imageAsset,
    String? facebookUrl,
    String? email,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade900.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade700),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.green.shade700,
            backgroundImage: imageAsset != null ? AssetImage(imageAsset) : null,
            child: imageAsset == null 
                ? const Icon(Icons.person, size: 40, color: Colors.white) 
                : null,
          ),
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name, 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ),
                Text(
                  role, 
                  style: const TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.w500)
                ),
                const SizedBox(height: 8),
                Text(
                  bio, 
                  style: const TextStyle(fontSize: 14, color: Colors.white70)
                ),
                
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (facebookUrl != null)
                      _buildSocialIcon(
                        context: context,
                        icon: Icons.facebook,
                        color: Colors.blueAccent,
                        platformName: "Facebook",
                        url: facebookUrl,
                      ),
                    if (email != null)
                      _buildSocialIcon(
                        context: context,
                        icon: Icons.email,
                        color: Colors.redAccent,
                        platformName: "Email",
                        url: email,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String platformName,
    required String url,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening $platformName link...'),
              backgroundColor: Colors.green.shade800,
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.white12,
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}