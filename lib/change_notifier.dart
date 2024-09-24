import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String _userName = '';
  String get userName => _userName;

  void login(String name) {
    _userName = name;
    notifyListeners();
  }
}

class PropertyProvider with ChangeNotifier {
  List<Property> _properties = [];

  List<Property> get properties => _properties;

  void addProperty(Property property) {
    _properties.add(property);
    notifyListeners();
  }
}

class Property {
  final String title;
  final String description;
  final String imageUrl;
  final double price;

  Property({required this.title, required this.description, required this.imageUrl, required this.price});
}
