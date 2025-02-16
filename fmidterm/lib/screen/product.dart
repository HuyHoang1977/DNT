import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'product_detail.dart';
import 'login.dart';

class ProductManagementScreen extends StatefulWidget {
  @override
  _ProductManagementScreenState createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  String productName = "";
  String productType = "";
  String productImage = "";
  int productPrice = 0;
  String? editingProductId;  // ID sản phẩm đang được chỉnh sửa
  String selectedSortCriteria = 'Tên';  // Tiêu chí sắp xếp mặc định
  String searchQuery = '';  // Biến lưu trữ từ khóa tìm kiếm

  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController searchController = TextEditingController();  // Controller cho ô tìm kiếm

  // Hàm đăng xuất
  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  // Thêm sản phẩm mới vào Firestore
  void createData() {
    if (productName.isEmpty || productType.isEmpty || productPrice <= 0 || productImage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng điền đầy đủ thông tin")),
      );
      return;
    }

    Map<String, dynamic> productData = {
      "productName": productName,
      "productType": productType,
      "productPrice": productPrice,
      "productImage": productImage
    };

    FirebaseFirestore.instance.collection("Products").add(productData).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$productName đã được thêm thành công")),
      );
      clearFields();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thêm thất bại: $error")),
      );
    });
  }

  // Cập nhật thông tin sản phẩm
  void updateData(String documentId) {
    String updatedProductName = nameController.text;
    String updatedProductType = typeController.text;
    int updatedProductPrice = int.tryParse(priceController.text) ?? 0;
    String updatedProductImage = imageController.text;

    if (updatedProductName.isEmpty || updatedProductType.isEmpty || updatedProductPrice <= 0 || updatedProductImage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng điền đầy đủ thông tin")),
      );
      return;
    }

    DocumentReference documentReference = FirebaseFirestore.instance.collection("Products").doc(documentId);

    Map<String, dynamic> updatedData = {
      "productName": updatedProductName,
      "productType": updatedProductType,
      "productPrice": updatedProductPrice,
      "productImage": updatedProductImage
    };

    documentReference.update(updatedData).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$updatedProductName đã được cập nhật thành công")),
      );
      clearFields();
      setState(() {
        editingProductId = null;
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cập nhật thất bại: $error")),
      );
    });
  }

  // Xóa sản phẩm khỏi Firestore
  void deleteData(String documentId) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Products").doc(documentId);

    documentReference.delete().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sản phẩm đã được xóa thành công")),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Xóa thất bại: $error")),
      );
    });
  }

  // Xóa các trường input
  void clearFields() {
    nameController.clear();
    typeController.clear();
    priceController.clear();
    imageController.clear();

    setState(() {
      productName = "";
      productType = "";
      productPrice = 0;
      productImage = "";
    });
  }

  // Mở form chỉnh sửa sản phẩm
  void openEditForm(String productId, String productName, String productType,
      int productPrice, String productImage) {
    setState(() {
      editingProductId = productId;
      this.productName = productName;
      this.productType = productType;
      this.productPrice = productPrice;
      this.productImage = productImage;

      nameController.text = productName;
      typeController.text = productType;
      priceController.text = productPrice.toString();
      imageController.text = productImage;
    });

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Tên sản phẩm",
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: typeController,
                    decoration: InputDecoration(
                      labelText: "Loại sản phẩm",
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: "Giá tiền",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: imageController,
                    decoration: InputDecoration(
                      labelText: "Link hình ảnh",
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      updateData(productId);
                      Navigator.pop(context);
                    },
                    child: Text("Cập nhật sản phẩm"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Mở form xác nhận xóa
  void openDeleteConfirmation(String productId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Xác nhận xóa"),
          content: Text("Bạn có chắc chắn muốn xóa sản phẩm này không?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                deleteData(productId);
                Navigator.pop(context);
              },
              child: Text("Xóa"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý sản phẩm", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        actions: [
          Tooltip(
            message: "Đăng xuất",
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: _signOut,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                selectedSortCriteria = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return {'Tên', 'Loại', 'Giá'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Tìm kiếm sản phẩm...',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .where('productName', isGreaterThanOrEqualTo: searchQuery)
                  .where('productName', isLessThanOrEqualTo: searchQuery + '\uf8ff')
                  .orderBy(
                selectedSortCriteria == 'Tên'
                    ? 'productName'
                    : selectedSortCriteria == 'Loại'
                    ? 'productType'
                    : 'productPrice',
              )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "Không có sản phẩm nào",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        // Điều hướng đến ProductDetailScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              productId: documentSnapshot.id,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  // Ảnh sản phẩm
                                  Flexible(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: documentSnapshot["productImage"] != null &&
                                          documentSnapshot["productImage"].isNotEmpty
                                          ? Image.network(
                                        documentSnapshot["productImage"],
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )
                                          : Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Thông tin sản phẩm
                                  Flexible(
                                    flex: 7,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          documentSnapshot["productName"] ?? "Tên sản phẩm",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text("Loại: ${documentSnapshot["productType"] ?? "Không rõ"}"),
                                        Text("Giá: ${documentSnapshot["productPrice"] ?? "0"} VND"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Nút chỉnh sửa và xóa
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Row(
                                children: [
                                  Tooltip(
                                    message: "Chỉnh sửa",
                                    child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: Colors.blue,
                                      onPressed: () {
                                        openEditForm(
                                          documentSnapshot.id,
                                          documentSnapshot["productName"],
                                          documentSnapshot["productType"],
                                          documentSnapshot["productPrice"],
                                          documentSnapshot["productImage"],
                                        );
                                      },
                                    ),
                                  ),
                                  Tooltip(
                                    message: "Xóa",
                                    child: IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        openDeleteConfirmation(documentSnapshot.id);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            editingProductId = null;
          });
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: "Tên sản phẩm"),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: typeController,
                          decoration: InputDecoration(labelText: "Loại sản phẩm"),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: priceController,
                          decoration: InputDecoration(labelText: "Giá tiền"),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: imageController,
                          decoration: InputDecoration(labelText: "Link hình ảnh"),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: createData,
                          child: Text("Thêm sản phẩm"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
