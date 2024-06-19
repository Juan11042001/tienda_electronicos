import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    'assets/imagenes_productos/Canon-EOS-5D-Mark-IV-con-24-105mm-f4L-II-17-600x600.jpg',
    'assets/imagenes_productos/telefono2.webp',
    'assets/imagenes_productos/laptop2.png',
  ];

  final List<Product> popularProducts = [
    Product(
      title: 'Laptop Acer GW',
      image: 'assets/imagenes_productos/Captura de pantalla 2024-06-05 154837.png',
      description: 'Core i5 12va, 512gb, 8gb, 14pulg touch',
      category: 'Laptops',
      price: 534,
    ),
    Product(
      title: 'Xiaomi 13 Ultra',
      image: 'assets/imagenes_productos/telefono1.webp',
      description: '16GB + 1024GB + Snapdragon 8 Gen 2 3.2GHz',
      category: 'Smartphones',
      price: 1049,
    ),
    Product(
      title: 'Cámara Canon EOS T7',
      image: 'assets/imagenes_productos/Canon-EOS-T7-con-lente-18-55mm-1-600x529.jpg.webp',
      description: 'La EOS 2000D (Rebel T7 en América) es la sucesora de la Canon EOS 1300D / Rebel T6.',
      category: 'Cameras',
      price: 50,
    ),
    Product(
      title: 'Redmi Buds 4 Active',
      image: 'assets/imagenes_productos/accesorio1.webp',
      description: 'Bluetooth® 5.3 + Hasta 28 horas + Puerto de carga: Tipo-C',
      category: 'Accessories',
      price: 34.99,
    ),
  ];

  String selectedCategory = 'All';
  List<String> categories = ['All', 'Laptops', 'Smartphones', 'Accessories', 'Cameras'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electronic Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildCarousel(),
            _buildCategorySection(),
            _buildPopularProductsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/products');
            },
            child: Text('Products'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            child: Text('Cart'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/checkout');
            },
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imgList.map((item) => Container(
        child: Center(
          child: Image.asset(item, fit: BoxFit.cover, width: 1000),
        ),
      )).toList(),
    );
  }

  Widget _buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) => _buildCategoryCard(category)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String category) {
    IconData iconData;
    switch (category) {
      case 'Laptops':
        iconData = Icons.laptop;
        break;
      case 'Smartphones':
        iconData = Icons.phone_android;
        break;
      case 'Accessories':
        iconData = Icons.headset;
        break;
      case 'Cameras':
        iconData = Icons.camera_alt;
        break;
      case 'All':
      default:
        iconData = Icons.all_inclusive;
        break;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(iconData, size: 40),
              SizedBox(height: 10),
              Text(category),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularProductsSection(BuildContext context) {
    List<Product> filteredProducts = selectedCategory == 'All'
        ? popularProducts
        : popularProducts.where((product) => product.category == selectedCategory).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/product_detail',
                    arguments: product,
                  );
                },
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(product.image, fit: BoxFit.cover),
                      SizedBox(height: 10),
                      Text(product.title),
                      Text(product.description),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
