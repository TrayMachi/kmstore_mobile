import 'package:flutter/material.dart';
import 'package:kmstore_mobile/models/keyboard.dart';
import 'package:kmstore_mobile/models/mouse.dart';
import 'package:kmstore_mobile/widgets/sidebar.dart';

class DetailProductPage extends StatelessWidget {
  final Keyboard? keyboard;
  final Mouse? mouse;
  const DetailProductPage({
    super.key,
    this.keyboard,
    this.mouse,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Product'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        drawer: const LeftDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Detail Product',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (keyboard != null) ...[
                Text(
                  keyboard!.fields.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text('Keyboard'),
                const SizedBox(height: 8),
                Image.network(keyboard!.fields.image, width: 200, height: 200),
                Text(keyboard!.fields.description),
                const SizedBox(height: 16),
                Text('Price: ${keyboard!.fields.price.toString()}'),
                Text('Stock: ${keyboard!.fields.stock.toString()}'),
                Text('Brand: ${keyboard!.fields.brand}'),
                Text('Swtich: ${keyboard!.fields.fieldsSwitch}'),
              ],
              if (mouse != null) ...[
                Text(
                  mouse!.fields.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text('Mouse'),
                const SizedBox(height: 8),
                Image.network(mouse!.fields.image, width: 200, height: 200),
                Text(mouse!.fields.description),
                const SizedBox(height: 16),
                Text('Price: ${mouse!.fields.price.toString()}'),
                Text('Stock: ${mouse!.fields.stock.toString()}'),
                Text('Brand: ${mouse!.fields.brand}'),
                Text('DPI: ${mouse!.fields.dpi.toString()}'),
                Text('Weight: ${mouse!.fields.weight.toString()}Gram'),
              ],
            ],
          ),
        ));
  }
}
