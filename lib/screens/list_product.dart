import 'package:flutter/material.dart';
import 'package:kmstore_mobile/models/keyboard.dart' as k;
import 'package:kmstore_mobile/models/mouse.dart' as m;
import 'package:kmstore_mobile/models/product.dart';
import 'package:kmstore_mobile/widgets/sidebar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kmstore_mobile/screens/detail_product.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<k.Keyboard>> fetchKeyboard(CookieRequest request) async {
    final response = await request
        .get('http://tristan-agra-kmstore.pbp.cs.ui.ac.id/json/keyboard');

    var data = response;

    List<k.Keyboard> listKeyboard = [];
    for (var d in data) {
      if (d != null) {
        listKeyboard.add(k.Keyboard.fromJson(d));
      }
    }
    return listKeyboard;
  }

  Future<List<m.Mouse>> fetchMouse(CookieRequest request) async {
    final response = await request
        .get('http://tristan-agra-kmstore.pbp.cs.ui.ac.id/json/mouse');

    var data = response;

    List<m.Mouse> listMouse = [];
    for (var d in data) {
      if (d != null) {
        listMouse.add(m.Mouse.fromJson(d));
      }
    }
    return listMouse;
  }

  Future<List<Product>> fetchUserProduct(CookieRequest request) async {
    final userId = request.jsonData['id'].toString();
    final response = await request
        .get('http://tristan-agra-kmstore.pbp.cs.ui.ac.id/products/$userId');

    var data = response;

    List<Product> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Product.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Use this to make the content scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<k.Keyboard>>(
                future: fetchKeyboard(request),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No keyboards available'),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Keyboard',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        SizedBox(
                          height: 270,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final keyboard = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          keyboard.fields.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Image.network(
                                          keyboard.fields.image,
                                          width: 100,
                                          height: 100,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          keyboard.fields.description,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Text(
                                          'Stock: ${keyboard.fields.stock}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailProductPage(
                                                        keyboard: keyboard),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.amber, // Button color
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                          ),
                                          child: const Text(
                                            'Detail',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 24.0), // Add spacing between sections
              FutureBuilder<List<m.Mouse>>(
                future: fetchMouse(request),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No mice available'),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mouse',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        SizedBox(
                          height: 270,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final mouse = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mouse.fields.name,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Image.network(
                                          mouse.fields.image,
                                          width: 100,
                                          height: 100,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          mouse.fields.description,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          'Stock: ${mouse.fields.stock}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Action when button is pressed
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailProductPage(
                                                        mouse: mouse),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.amber, // Button color
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                          ),
                                          child: const Text(
                                            'Detail',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 24.0), // Add spacing between sections
              FutureBuilder<List<Product>>(
                future: fetchUserProduct(request),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No products available'),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Products',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        SizedBox(
                          height: 270,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final product = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.fields.name,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Image.network(
                                          product.fields.image,
                                          width: 100,
                                          height: 100,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          product.fields.description,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          'Stock: ${product.fields.stock}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (product.fields.fieldsSwitch != null) {
                                              final keyboardFields = k.Keyboard(
                                                model: product.model,
                                                pk: product.pk,
                                                fields: k.Fields(
                                                  name: product.fields.name,
                                                  price: product.fields.price,
                                                  description: product.fields.description,
                                                  stock: product.fields.stock,
                                                  createdAt: product.fields.createdAt,
                                                  updatedAt: product.fields.updatedAt,
                                                  fieldsSwitch: product.fields.fieldsSwitch!,
                                                  brand: product.fields.brand,
                                                  image: product.fields.image,
                                                  author: product.fields.author,
                                                ),
                                              );
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailProductPage(
                                                          keyboard: keyboardFields),
                                                ),
                                              );
                                            } else {
                                              final mouseFields = m.Mouse(
                                                model: product.model,
                                                pk: product.pk,
                                                fields: m.Fields(
                                                  name: product.fields.name,
                                                  price: product.fields.price,
                                                  description: product.fields.description,
                                                  stock: product.fields.stock,
                                                  createdAt: product.fields.createdAt,
                                                  updatedAt: product.fields.updatedAt,
                                                  dpi: product.fields.dpi!,
                                                  weight: product.fields.weight!,
                                                  brand: product.fields.brand,
                                                  image: product.fields.image,
                                                  author: product.fields.author,
                                                ),
                                              );
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailProductPage(
                                                          mouse: mouseFields),
                                                ),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.amber, // Button color
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                          ),
                                          child: const Text(
                                            'Detail',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
