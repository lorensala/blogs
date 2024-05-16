// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

@immutable
class Product extends Equatable {
  const Product(this.name, this.price);

  final String name;
  final double price;

  @override
  List<Object?> get props => [name, price];

  bool get isEmpty => name.isEmpty || price == 0;

  Product copyWith({
    String? name,
    double? price,
  }) {
    return Product(
      name ?? this.name,
      price ?? this.price,
    );
  }
}

final cartNotifier = CartNotifier();

class CartNotifier extends ValueNotifier<List<Product>> {
  CartNotifier() : super(const []);

  void add(Product product) {
    value = [...value, product];
  }

  void remove(Product product) {
    value = value.where((c) => c != product).toList();
  }
}

final productFormNotifier = ProductFormNofier();

class ProductFormNofier extends ValueNotifier<Product> {
  ProductFormNofier() : super(const Product('', 0));

  void setName(String name) {
    value = value.copyWith(name: name);
  }

  void setPrice(double price) {
    value = value.copyWith(price: price);
  }
}

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: cartNotifier,
        builder: (context, value, _) {
          return ListView(
            shrinkWrap: true,
            children: value
                .map((product) => ProductItem(product))
                .toList(growable: false),
          );
        });
  }
}

class ProductForm extends StatelessWidget {
  const ProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) => productFormNotifier.setName(value),
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (value) =>
                productFormNotifier.setPrice(double.tryParse(value) ?? 0),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Price',
            ),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder(
            valueListenable: productFormNotifier,
            builder: (context, product, _) {
              return ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart),
                onPressed:
                    product.isEmpty ? null : () => cartNotifier.add(product),
                label: const Text('Add to cart'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem(this.product, {Key? key}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      trailing: IconButton(
        onPressed: () => cartNotifier.remove(product),
        icon: const Icon(Icons.remove_circle),
      ),
      subtitle: Text('\$${product.price}'),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      home: const MyHomePage(title: 'ValueNotifier Example'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const ProductForm(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
              valueListenable: cartNotifier,
              builder: (context, value, _) {
                return Text(
                  'Added to cart (${value.length})',
                  style: Theme.of(context).textTheme.titleLarge,
                );
              }),
        ),
        const Expanded(child: ProductList()),
      ]),
    );
  }
}
