import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/product.dart';
class Store{
  final Firestore _firestore = Firestore.instance;
  addProduct(Product product){
    _firestore.collection('products').add({
      'productName' : product.pName,
      'productPrice' : product.pPrice,
      'productDescription' : product.pDescription,
      'productLocation' : product.pLocation,
      'productCategory' : product.pCategory,
    });
  }
  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection('products').snapshots();
  }
  deleteProduct(documentId){
    _firestore.collection('products').document(documentId).delete();
  }
  editProduct(data,documentId){
    _firestore.collection('products').document(documentId).updateData(data);
  }
}