import 'package:flutter/material.dart';

class CoffeeCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imageUrl;

  const CoffeeCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _CoffeeCardState createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown[300],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.price,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) quantity--;
                    });
                  },
                  icon: Icon(Icons.remove),
                  color: Colors.orange,
                  splashRadius: 20,
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontSize: 18, color: Colors.brown[900]),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: Icon(Icons.add),
                  color: Colors.orange,
                  splashRadius: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CoffeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Coffee Menu'),
        backgroundColor: Colors.brown[700],
      ),
      body: ListView(
        children: [
          CoffeeCard(
            title: 'Espresso',
            subtitle: 'with milk',
            price: 'ugxxx',
            imageUrl: 'lib/images/espresso.jpg',
          ),
          CoffeeCard(
            title: 'Latte',
            subtitle: 'with bakery',
            price: 'ugxxx',
            imageUrl: 'lib/images/latte.jpg',
          ),
          // Add more CoffeeCard widgets as needed
        ],
      ),
    );
  }
}
