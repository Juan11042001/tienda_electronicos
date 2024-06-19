import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'product.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Product> products = [
    Product(
      title: 'Laptop Acer GW',
      image: 'imagenes/imagenes_productos/Captura de pantalla 2024-06-05 154837.png',
      description: 'Core i5 12va, 512gb, 8gb, 14pulg touch',
      category: 'Laptops',
      price: 534,
    ),
    Product(
      title: 'Laptop Microsoft Surface',
      image: 'imagenes/imagenes_productos/laptop2.png',
      description: 'Core i5 10ma, 4gb, 64gb, touch',
      category: 'Laptops',
      price: 422,
    ),
    Product(
      title: 'Xiaomi 13 Ultra',
      image: 'imagenes/imagenes_productos/telefono1.webp',
      description: '16GB + 1024GB + Snapdragon 8 Gen 2 3.2GHz',
      category: 'Smartphones',
      price: 1049,
    ),
    Product(
      title: 'Xiaomi Redmi Note 13 Pro+',
      image: 'imagenes/imagenes_productos/telefono2.webp',
      description: '12GB + 512GB + Mediatek Dimensity 7200 Ultra 2.8GHz',
      category: 'Smartphones',
      price: 489,
    ),
    Product(
      title: 'Cámara Canon EOS T7',
      image: 'imagenes/imagenes_productos/Canon-EOS-T7-con-lente-18-55mm-1-600x529.jpg.webp',
      description: 'La EOS 2000D (Rebel T7 en América) es la sucesora de la Canon EOS 1300D / Rebel T6.',
      category: 'Cameras',
      price: 50,
    ),
    Product(
      title: 'Cámara DSLR Canon EOS 5D Mark IV',
      image: 'imagenes/imagenes_productos/Canon-EOS-5D-Mark-IV-con-24-105mm-f4L-II-17-600x600.jpg',
      description: 'Diseñada para rendir en cada situación, la EOS 5D Mark IV es una atractiva cámara muy completa.',
      category: 'Cameras',
      price: 50,
    ),
    Product(
      title: 'Redmi Buds 4 Active',
      image: 'imagenes/imagenes_productos/accesorio1.webp',
      description: 'Bluetooth® 5.3 + Hasta 28 horas + Puerto de carga: Tipo-C',
      category: 'Accessories',
      price: 34.99,
    ),
    Product(
      title: 'Xiaomi Smart Band 8 Active',
      image: 'imagenes/imagenes_productos/accesorio2.webp',
      description: 'Batería: hasta 14 días + Resistencia al agua: hasta 50 metros + Idioma: chino, inglés, con actualización a español*',
      category: 'Accessories',
      price: 39.99,
    ),
    Product(
      title: 'Lambo Smartwatch Aventador Q4 Nero',
      image: 'imagenes/imagenes_productos/accesorio3.webp',
      description: 'Bluetooth: V5.0 + agua: 5 ATM & IP69K + Pantalla: 1.85”, IPS, 320*385',
      category: 'Accessories',
      price: 139,
    ),
    Product(
      title: 'Control Inalámbrico DualSense para PS5 Original',
      image: 'imagenes/imagenes_productos/accesorio4.webp',
      description: 'Respuesta háptica + Gatillos adaptativos + Sensor de movimiento',
      category: 'Accessories',
      price: 99,
    ),
  ];

  String selectedCategory = 'All';
  String priceFilter = 'none';
  List<String> categories = ['All', 'Laptops', 'Smartphones', 'Accessories', 'Cameras'];

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = selectedCategory == 'All'
        ? products
        : products.where((product) => product.category == selectedCategory).toList();

    if (priceFilter == 'price_low_high') {
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (priceFilter == 'price_high_low') {
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Products', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String category) {
              setState(() {
                selectedCategory = category;
              });
            },
            itemBuilder: (BuildContext context) {
              return categories.map((String category) {
                return PopupMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category: $selectedCategory', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.teal),
                  onPressed: () {
                    _showFilterDialog();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return _buildProductCard(context, filteredProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(product.image, fit: BoxFit.cover),
        ),
        title: Text(product.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.add_shopping_cart, color: Colors.teal),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addItem(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.title} added to cart')),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/product_detail',
                  arguments: product,
                );
              },
              child: Text('View', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Price: Low to High'),
                leading: Radio<String>(
                  value: 'price_low_high',
                  groupValue: priceFilter,
                  onChanged: (String? value) {
                    setState(() {
                      priceFilter = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                title: Text('Price: High to Low'),
                leading: Radio<String>(
                  value: 'price_high_low',
                  groupValue: priceFilter,
                  onChanged: (String? value) {
                    setState(() {
                      priceFilter = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  priceFilter = 'none';
                });
                Navigator.of(context).pop();
              },
              child: Text('Clear', style: TextStyle(color: Colors.teal)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close', style: TextStyle(color: Colors.teal)),
            ),
          ],
        );
      },
    );
  }
}
