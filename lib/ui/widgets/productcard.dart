part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        onTap: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return EditPage(product);
          }));
        },
        title: Text(
          product.name,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
            NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 2)
                .format(int.parse(product.price))),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(
            product.image,
            scale: 60,
          ),
        ),
        trailing: Icon(Icons.visibility),
      ),
    );
  }
}
