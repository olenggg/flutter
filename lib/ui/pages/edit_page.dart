part of 'pages.dart';

class EditPage extends StatefulWidget {
  final Products product;
  EditPage(this.product);

  @override
  _EditPageState createState() => _EditPageState(product);
}

class _EditPageState extends State<EditPage> {
  final Products product;
  _EditPageState(this.product);

  final ctrlName = TextEditingController();
  final ctrlPrice = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlPrice.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlPrice.clear();
    setState(() {
      imageFile = null;
    });
  }

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseImage() async {
    final selectedImage = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = selectedImage;
    });
  }

  final int pushindex = 1;

  @override
  Widget build(BuildContext context) {
    ctrlName.text = product.name;
    ctrlPrice.text = product.price;

    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Data"),
          centerTitle: true,
          leading: Container(),
        ),
        body: Stack(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      controller: ctrlName,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add_box),
                          labelText: 'Product Name',
                          hintText: "Write your product name",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ctrlPrice,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.attach_money),
                          labelText: 'Product Price',
                          hintText: "Write your price",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 20),
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(product.image),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            padding: EdgeInsets.all(15),
                            child: Text("Update Product"),
                            onPressed: () async {
                              if (ctrlName.text == "" || ctrlPrice.text == "") {
                                Fluttertoast.showToast(
                                  msg: "Please Fill All Field!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 20.0,
                                );
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                bool result =
                                    await ProductServices.updateProduct(
                                        product.id,
                                        ctrlName.text,
                                        ctrlPrice.text);
                                if (result == true) {
                                  Fluttertoast.showToast(
                                    msg: "Add Products Success",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 20.0,
                                  );
                                  clearForm();
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MainMenu();
                                  }));
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Failed! Try Again",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 20.0,
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            }),
                        RaisedButton(
                            textColor: Colors.white,
                            color: Colors.red,
                            padding: EdgeInsets.all(15),
                            child: Text("Delete Product"),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              bool result =
                                  await ProductServices.deleteProduct(product);
                              if (result == true) {
                                Fluttertoast.showToast(
                                  msg: "Add Products Success",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 20.0,
                                );
                                clearForm();
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MainMenu();
                                }));
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Failed! Try Again",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 20.0,
                                );
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            })
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          isLoading == true
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                  child: SpinKitFadingCircle(
                    size: 50,
                    color: Colors.blue,
                  ))
              : Container()
        ]));
  }
}
