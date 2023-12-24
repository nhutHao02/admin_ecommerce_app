import 'dart:convert';

import 'package:admin_ecommerce_app/models/size_product.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() {
    return _ProductAddScreenState();
  }
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final formKey = GlobalKey<FormState>();

  var nameProduct = "";
  var priceProduct = 0;
  var promotionalPriceProduct = 0;
  List<String> listIMG = [];
  List<String> listImage = [];
  List<SizeProduct> listSize = [SizeProduct(nameSize: "", quantity: 0)];
  var idType = 1;
  var idBrand = 1;
  var idSex = 1;
  var idStatus = 1;
  var numberOfRowAdd = 1;

  var isLoading = false;

  List<String> listBrand = ['Nike', 'Adidas', 'Jordan', 'Khác'];
  List<String> listType = ['Giày', 'Dép', 'Đồ thể thao', 'Phụ kiện', 'Khác'];
  List<String> listStatus = ['Bình thường', 'Mới', 'Hot', 'Khuyến Mãi'];
  String valueChoose = 'Nike';
  String valueChooseT = 'Giày';
  String valueChooseS = 'Bình thường';
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Xử lý ảnh đã chọn ở đây, ví dụ: lưu đường dẫn vào listImage
      setState(() {
        listImage.add(pickedFile.path);
      });
    }
  }

  Future<List<String>> uploadImages(List<String> imagePaths) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      await auth.signInAnonymously();
    }

    for (String imagePath in imagePaths) {
      File imageFile = File(imagePath);

      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      String imagePathInStorage = 'images/$imageName.jpg';

      TaskSnapshot taskSnapshot = await FirebaseStorage.instance
          .ref()
          .child(imagePathInStorage)
          .putFile(imageFile);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      listIMG.add(downloadUrl);
    }

    // print(downloadUrls);

    return listIMG;
  }

  bool _validateInputs() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  String _productTojson() {
    Map<String, dynamic> product = {
      "name_product": nameProduct,
      "star_review": 5,
      "listed_price": priceProduct,
      "promotional_price": promotionalPriceProduct,
      "list_image": listIMG.map((path) => {"path_image": path}).toList(),
      "list_size": listSize
          .map((size) =>
              {"name_size": size.nameSize, "quantity_available": size.quantity})
          .toList(),
      "id_type": idType,
      "id_brand": idBrand,
      "id_sex": idSex,
      "id_status_product": idStatus,
    };

    return jsonEncode(product);
  }

  Future<bool> sendAddProduct(String json) async {
    print('sendAddProduct using');
    const url =
        'http://tranhao123-001-site1.etempurl.com/api/products/create-product';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'}, body: json);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('sendAddProduct Success........');
      return true;
    } else {
      print('sendAddProduct failed with status: ${response.statusCode}.');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }

  void resetInfo() {
    nameProduct = "";
    priceProduct = 0;
    promotionalPriceProduct = 0;
    listImage = [];
    listSize = [SizeProduct(nameSize: "", quantity: 0)];
    idType = 1;
    idBrand = 1;
    idSex = 1;
    idStatus = 1;
    numberOfRowAdd = 1;
  }

  Future<void> _createProduct() async {
    setState(() {
      isLoading = true;
    });
    if (_validateInputs()) {
      await uploadImages(listImage);
      String productJson = _productTojson();
      if (await sendAddProduct(productJson)) {
        setState(() {
          isLoading = false;
          resetInfo();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProductAddScreen()),
          );
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () => Navigator.pop(context, true),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        title: const Text('Thêm sản phẩm'),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colorSecondary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Text('Thông tin sản phẩm',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        const Divider(height: 2),
                        Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                    decoration: const InputDecoration(
                                      labelText: 'Tên sản phẩm',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 231, 231, 231),
                                          fontSize: 18),
                                      hintText: 'Tên sản phẩm',
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 201, 200, 200)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Vui lòng nhập tên sản phẩm";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) => nameProduct = value,
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  DropdownButton(
                                    hint: const Text('Chọn nhãn hiệu'),
                                    disabledHint: const Text('Chọn nhãn hiệu'),
                                    isExpanded: true,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    value: valueChoose,
                                    onChanged: (newValue) {
                                      setState(() {
                                        valueChoose = newValue!;
                                        idBrand =
                                            listBrand.indexOf(newValue) + 1;
                                      });
                                    },
                                    items: listBrand.map((value) {
                                      return DropdownMenuItem(
                                          value: value, child: Text(value));
                                    }).toList(),
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  DropdownButton(
                                    hint: const Text('Chọn nhãn hiệu'),
                                    disabledHint: const Text('Chọn nhãn hiệu'),
                                    isExpanded: true,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    value: valueChooseT,
                                    onChanged: (newValue) {
                                      setState(() {
                                        valueChooseT = newValue!;
                                        idType = listType.indexOf(newValue) + 1;
                                      });
                                    },
                                    items: listType.map((value) {
                                      return DropdownMenuItem(
                                          value: value, child: Text(value));
                                    }).toList(),
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 1,
                                        groupValue: idSex,
                                        onChanged: (value) {
                                          setState(() {
                                            idSex = value as int;
                                          });
                                        },
                                      ),
                                      const Text('Nam'),
                                      const SizedBox(width: 20),
                                      Radio(
                                        value: 2,
                                        groupValue: idSex,
                                        onChanged: (value) {
                                          setState(() {
                                            idSex = value as int;
                                          });
                                        },
                                      ),
                                      const Text('Nữ'),
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  defaultPadding),
                                              child: TextFormField(
                                                // Thuộc tính của TextFormField 1
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Size',
                                                  hintText: 'Size',
                                                  // ... các thuộc tính khác ...
                                                ),
                                                onChanged: (value) {
                                                  // Cập nhật giá trị size trong danh sách listSize
                                                  listSize[0].nameSize = value;
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Vui lòng nhập size";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  defaultPadding),
                                              child: TextFormField(
                                                // Thuộc tính của TextFormField 2
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Số lượng',
                                                  hintText: 'Số lượng',
                                                  // ... các thuộc tính khác ...
                                                ),
                                                onChanged: (value) {
                                                  // Cập nhật giá trị size trong danh sách listSize
                                                  listSize[0].quantity =
                                                      value as int;
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Vui lòng nhập số lượng";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: -10,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              numberOfRowAdd++;
                                              listSize.add(SizeProduct(
                                                  nameSize: "", quantity: 0));
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 162, 160, 160),
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(10),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: colorPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (numberOfRowAdd > 1)
                                    for (int i = 1; i < numberOfRowAdd; i++)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  defaultPadding),
                                              child: TextFormField(
                                                // Thuộc tính của TextFormField 1
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Size',
                                                  hintText: 'Size',
                                                  // ... các thuộc tính khác ...
                                                ),
                                                onChanged: (value) {
                                                  // Cập nhật giá trị size trong danh sách listSize
                                                  listSize[i].nameSize = value;
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Vui lòng nhập size";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  defaultPadding),
                                              child: TextFormField(
                                                // Thuộc tính của TextFormField 2
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Số lượng',
                                                  hintText: 'Số lượng',
                                                  // ... các thuộc tính khác ...
                                                ),
                                                onChanged: (value) {
                                                  // Cập nhật giá trị size trong danh sách listSize
                                                  listSize[i].quantity =
                                                      value as int;
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Vui lòng nhập số lượng";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  const SizedBox(height: defaultPadding),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                    decoration: const InputDecoration(
                                      labelText: 'Giá sản phẩm',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 231, 231, 231),
                                          fontSize: 18),
                                      hintText: 'Giá sản phẩm',
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 201, 200, 200)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          int.parse(value) == 0) {
                                        return "Vui lòng nhập giá sản phâm";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) =>
                                        priceProduct = int.parse(value),
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                    decoration: const InputDecoration(
                                      labelText: 'Giá khuyến mãi',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 231, 231, 231),
                                          fontSize: 18),
                                      hintText: 'Giá khuyến mãi',
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 201, 200, 200)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        promotionalPriceProduct = priceProduct;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) =>
                                        promotionalPriceProduct =
                                            int.parse(value),
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  DropdownButton(
                                    hint: const Text('Chọn nhãn hiệu'),
                                    disabledHint: const Text('Chọn nhãn hiệu'),
                                    isExpanded: true,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    value: valueChooseS,
                                    onChanged: (newValue) {
                                      setState(() {
                                        valueChooseS = newValue!;
                                        idStatus =
                                            listStatus.indexOf(newValue) + 1;
                                      });
                                    },
                                    items: listStatus.map((value) {
                                      return DropdownMenuItem(
                                          value: value, child: Text(value));
                                    }).toList(),
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  const SizedBox(height: defaultPadding),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255,
                                            221,
                                            217,
                                            217), // Đặt màu nền của nút ở đây
                                      ),
                                      onPressed: _pickImage,
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Chọn ảnh',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: defaultPadding),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (listImage.isNotEmpty)
                                        const Text(
                                          'Danh sách ảnh đã chọn:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      const SizedBox(height: 8),
                                      if (listImage.isNotEmpty)
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: List.generate(
                                            listImage.length,
                                            (index) => Stack(
                                              children: [
                                                Image.file(
                                                  File(listImage[index]),
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                                Positioned(
                                                  top: -16,
                                                  right: -15,
                                                  child: Ink(
                                                    decoration:
                                                        const ShapeDecoration(
                                                      color: Colors
                                                          .transparent, // Để loại bỏ màu nền của button
                                                      shape: CircleBorder(
                                                        side: BorderSide(
                                                            color: Colors.black,
                                                            width: 2),
                                                      ),
                                                    ),
                                                    child: IconButton(
                                                      icon: const Icon(
                                                          Icons.close),
                                                      onPressed: () {
                                                        setState(() {
                                                          listImage
                                                              .removeAt(index);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  Column(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                colorPrimary, // Đặt màu nền của nút ở đây
                                          ),
                                          onPressed: _createProduct,
                                          child: isLoading
                                              ? const SizedBox(
                                                  height: 20,
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator()))
                                              : const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .cloud_upload_outlined,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Tạo',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                )),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
