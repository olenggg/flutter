part of 'services.dart';

class ProductServices {
  //setup cloud firestroe
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");
  static DocumentReference productDoc;

  //setup firestore storage
  static Reference ref;
  static UploadTask uploadTask;

  static String imgUrl;

  static Future<bool> addProduct(Products product, PickedFile imgFile) async {
    await Firebase.initializeApp();

    productDoc = await productCollection.add({
      'id': "",
      'name': product.name,
      'price': product.price,
      'image': "",
    });

    if (productDoc.id != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("image")
          .child("product")
          .child(productDoc.id + ".png");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(() => ref.getDownloadURL().then(
            (value) => imgUrl = value,
          ));

      productCollection.doc(productDoc.id).update({
        'id': productDoc.id,
        'image': imgUrl,
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateProduct(
      String id, String name, String price) async {
    await Firebase.initializeApp();
    return await productCollection
        .doc(id)
        .update({'name': name, 'price': price})
        .then((value) => true)
        .catchError((error) => false);
  }

  static Future<bool> deleteProduct(Products product) async {
    await Firebase.initializeApp();
    if (product.id != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("image")
          .child("product")
          .child(product.id + ".png");

      ref.delete();
      productCollection.doc(product.id).delete();

      return true;
    } else {
      return false;
    }
  }
}
