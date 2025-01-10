import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  // สินค้าตัวอย่างในร้าน
  final List<Map<String, dynamic>> products = [
    {'name': 'Product A', 'price': 100, 'quantity': 0},
    {'name': 'Product B', 'price': 200, 'quantity': 0},
    {'name': 'Product C', 'price': 300, 'quantity': 0},
  ];

  // ฟังก์ชันคำนวณผลรวมของราคา
  int get totalPrice {
    return products.fold(0, (sum, item) {
      final int price = item['price'] as int;
      final int quantity = item['quantity'] as int;
      return sum + (price * quantity);
    });
  }

  int get totalItems {
    return products.fold(0, (sum, item) => sum + (item['quantity'] as int));
  }

  // ฟังก์ชันรีเซ็ตจำนวนสินค้าในตระกร้า
  void resetCart() {
    setState(() {
      for (var product in products) {
        product['quantity'] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          // แสดงรายการสินค้า
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text('Price: \$${product['price']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (product['quantity'] > 0) {
                              product['quantity']--;
                            }
                          });
                        },
                      ),
                      Text(product['quantity'].toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            product['quantity']++;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // แสดงผลรวมของสินค้าและราคา
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Items: $totalItems',
                    style: TextStyle(fontSize: 18)),
                Text('Total Price: \$${totalPrice}',
                    style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          // ปุ่มรีเซ็ต
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: resetCart,
              child: Text('Reset Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
