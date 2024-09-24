import 'package:flutter/material.dart';

class FeaturedPropertiesScreen extends StatefulWidget {
  @override
  _FeaturedPropertiesScreenState createState() => _FeaturedPropertiesScreenState();
}

class _FeaturedPropertiesScreenState extends State<FeaturedPropertiesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _headerAnimation;
  late Animation<double> _backgroundAnimation;

  final List<Property> properties = [
    Property(title: 'Luxury Apartment', price: '\$300,000', imageUrl: 'assets/apartment.jpg', description: 'A luxurious apartment with modern amenities and a beautiful view.'),
    Property(title: 'Modern House', price: '\$450,000', imageUrl: 'assets/house.jpg', description: 'A modern house with spacious rooms and a great location.'),
    Property(title: 'Cozy Cottage', price: '\$250,000', imageUrl: 'assets/cottage.jpg', description: 'A cozy cottage in a quiet area, perfect for a peaceful retreat.'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _backgroundAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Properties'),
      ),
      drawer: _buildDrawer(),  // Add the drawer here
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _backgroundAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _backgroundAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[300]!, Colors.purple[300]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              );
            },
          ),
          Column(
            children: [
              FadeTransition(
                opacity: _headerAnimation,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Featured Properties',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    return buildSlidingPropertyCard(properties[index], index);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSlidingPropertyCard(Property property, int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.5), // Start from below
        end: Offset.zero, // Slide to original position
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2 * index, 1.0, curve: Curves.easeInOut),
      )),
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: SizedBox(
                height: 200, // Fixed height for images
                width: double.infinity,
                child: Image.asset(
                  property.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(property.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(property.price, style: const TextStyle(fontSize: 18, color: Colors.green)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Property Details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyDetailsScreen(property: property),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('View Details'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer widget for side navigation
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Nitasha S."),
            accountEmail: Text("nishoomehmood@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/profile-photo.jpeg'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Navigate to profile screen (if exists)
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to settings screen (if exists)
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              // Navigate to about screen (if exists)
            },
          ),
        ],
      ),
    );
  }
}

class Property {
  final String title;
  final String price;
  final String imageUrl;
  final String description;

  Property({required this.title, required this.price, required this.imageUrl, required this.description});
}

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(property.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(property.imageUrl, fit: BoxFit.cover, width: double.infinity, height: 250),
            const SizedBox(height: 20),
            Text(property.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(property.price, style: const TextStyle(fontSize: 22, color: Colors.green)),
            const SizedBox(height: 20),
            Text(property.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
