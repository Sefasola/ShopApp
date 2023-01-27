import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<States>(
      create: (BuildContext context) => States(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 7',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
      routes: {
        "home_screen": (context) => const HomeScreen(),
        "cart_screen": (context) => const CartScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/my-first-project-5d32d.appspot.com/o/1671478161547?alt=media&token=92374c40-1cf5-4a09-928e-ac7a1b720816",
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 24),
              const Text(
                "We deliver\ngroceries at your doorstep",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Fresh items everyday",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
                onPressed: () => Navigator.pushNamed(context, "home_screen"),
                child: const Text("Get Started"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.location_on_rounded, color: Colors.black38),
                    SizedBox(width: 8),
                    Text("Kayseri, Turkey")
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.person, color: Colors.black38),
                )
              ],
            ),
            const SizedBox(height: 32),
            const MessageContainer(),
            const SizedBox(height: 64),
            const Text("Fresh Items", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: items.length,
              itemBuilder: (BuildContext ctx, index) {
                return ItemCard(item: items[index]);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () => Navigator.pushNamed(context, "cart_screen"),
          child: const Icon(Icons.shopping_bag),
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<ItemModel> cart = Provider.of<States>(context).cart;
    double totalPrice = Provider.of<States>(context).totalPrice;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              "My Cart",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cart.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemCardCart(item: cart[index]);
                }),
          ],
        ),
        bottomNavigationBar: Container(
          height: 100,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Price",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[200],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              // const Text("Pay Now"),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                onPressed: () => {},
                icon: const Text("Pay Now"),
                label: const Icon(Icons.chevron_right),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MessageContainer extends StatelessWidget {
  const MessageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("Good morning,", style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Text(
          "Let's order fresh\nitems for you",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    Function addToCart = Provider.of<States>(context).addToCart;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: item.color?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.network(
            item.image!,
            width: 60,
            height: 60,
          ),
          Text(item.name!, style: const TextStyle(fontSize: 16)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: item.color),
            onPressed: () => addToCart(item),
            child: Text("\$${item.price?.toStringAsFixed(2)}"),
          ),
        ],
      ),
    );
  }
}

class ItemCardCart extends StatelessWidget {
  const ItemCardCart({Key? key, required this.item}) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    Function removeFromCart = Provider.of<States>(context).removeFromCart;

    return Container(
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.network(
          item.image!,
          width: 36,
          height: 36,
        ),
        title: Text(item.name!),
        subtitle: Text("\$${item.price?.toStringAsFixed(2)}"),
        trailing: IconButton(
          style: ElevatedButton.styleFrom(backgroundColor: item.color),
          onPressed: () => removeFromCart(item),
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}

class States with ChangeNotifier {
  final List<ItemModel> cart = [];
  double totalPrice = 0.00;

  void addToCart(ItemModel item) {
    cart.add(item);
    totalPrice += item.price!;
    notifyListeners();
  }

  void removeFromCart(ItemModel item) {
    cart.remove(item);
    totalPrice -= item.price!;
    notifyListeners();
  }
}

class ItemModel {
  int? id;
  String? name;
  double? price;
  String? image;
  Color? color;

  ItemModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.color,
  });
}

List<ItemModel> items = [
  ItemModel(
    id: 1,
    name: "Avocado",
    price: 4.00,
    image:
    "https://firebasestorage.googleapis.com/v0/b/my-first-project-5d32d.appspot.com/o/1671478161547?alt=media&token=92374c40-1cf5-4a09-928e-ac7a1b720816",
    color: Colors.green,
  ),
  ItemModel(
    id: 2,
    name: "Banana",
    price: 2.50,
    image:
    "https://firebasestorage.googleapis.com/v0/b/my-first-project-5d32d.appspot.com/o/1671478486909?alt=media&token=39fd6512-19d5-4dc9-85f3-4a58d98b1ca4",
    color: Colors.yellow,
  ),
  ItemModel(
    id: 3,
    name: "Chicken",
    price: 12.80,
    image:
    "https://firebasestorage.googleapis.com/v0/b/my-first-project-5d32d.appspot.com/o/1671479394954?alt=media&token=94c67b9f-0d7e-40ef-922d-0e008dbf362d",
    color: Colors.brown,
  ),
  ItemModel(
    id: 4,
    name: "Water",
    price: 1.00,
    image:
    "https://firebasestorage.googleapis.com/v0/b/my-first-project-5d32d.appspot.com/o/1671478678989?alt=media&token=ca8ca0fe-bb85-4bf8-96ed-fd1ca4cac06e",
    color: Colors.blue,
  ),
];
