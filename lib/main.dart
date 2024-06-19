import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'register.dart';
import 'home.dart';
import 'product_list.dart';
import 'product_detail.dart';
import 'cart.dart';
import 'checkout.dart';
import 'cart_provider.dart';
import 'product.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electronic Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/products': (context) => ProductListPage(),
        '/cart': (context) => CartPage(),
        '/checkout': (context) => CheckoutPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/product_detail') {
          final Product product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) {
              return ProductDetailPage(product: product);
            },
          );
        }
        return null;
      },
    );
  }
}
