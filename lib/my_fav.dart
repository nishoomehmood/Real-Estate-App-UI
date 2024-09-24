import 'package:flutter/material.dart';

class Property {
  final String title;
  final String price;
  final String imageUrl;
  final String description;

  Property({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
  });
}

class MyFavouritesScreen extends StatefulWidget {
  @override
  _MyFavouritesScreenState createState() => _MyFavouritesScreenState();
}

class _MyFavouritesScreenState extends State<MyFavouritesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _headingAnimation;

  final List<Property> favouriteProperties = [
    Property(
      title: 'Beach House',
      price: '\$800,000',
      imageUrl: 'assets/house.jpg',
      description: 'A beautiful house by the beach with a great view.',
    ),
    Property(
      title: 'Mountain Cabin',
      price: '\$400,000',
      imageUrl: 'assets/cottage.jpg',
      description: 'A cozy cabin in the mountains, perfect for a getaway.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _headingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
        title: const Text('My Favourites'),
      ),
      body: Column(
        children: [
          FadeTransition(
            opacity: _headingAnimation,
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Favourite Properties',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: favouriteProperties.length,
              itemBuilder: (context, index) {
                return buildFavouritePropertyCard(favouriteProperties[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFavouritePropertyCard(Property property, int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(property.title, style:const  TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(property.price, style: const TextStyle(fontSize: 18, color: Colors.green)),
                  const SizedBox(height: 10),
                  Text(property.description, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
