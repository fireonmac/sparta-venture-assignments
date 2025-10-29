import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/products/product_model.dart';
import 'package:flutter_basic_venture/src/features/products/products_container.dart';
import 'package:flutter_basic_venture/src/styles.dart';
import 'package:flutter_basic_venture/src/utils/navigation.dart';
import 'package:flutter_basic_venture/src/widgets/call_to_action_button.dart';
import 'package:flutter_basic_venture/src/widgets/quantity_control.dart';
import 'package:flutter_basic_venture/src/widgets/image_picker_bottom_sheet.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  static Route<dynamic> buildRoute(BuildContext context) {
    return buildScreenRoute(context, screen: const ProductCreateScreen());
  }

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  int _stockQuantity = 1;
  File? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      _stockQuantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_stockQuantity > 1) {
        _stockQuantity--;
      }
    });
  }

  Future<void> _pickImage() async {
    try {
      await showModalBottomSheet(
        context: context,
        builder: (context) => ImagePickerBottomSheet(
          onImageSelected: (pickedFile) {
            if (pickedFile != null) {
              setState(() {
                _selectedImage = pickedFile;
              });
            }
          },
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('이미지 선택 실패: $e')));
      }
    }
  }

  void _createProduct(BuildContext context) {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final priceText = _priceController.text.trim();

    if (name.isEmpty || description.isEmpty || priceText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('모든 필드를 입력해주세요.')));
      return;
    }

    if (_selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('사진을 선택해주세요.')));
      return;
    }

    final price = double.tryParse(priceText);
    if (price == null || price <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('올바른 가격을 입력해주세요.')));
      return;
    }

    final productsNotifier = ProductsContainer.of(context);
    final newProduct = Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      price: price,
      stock: _stockQuantity,
      imageUrl: _selectedImage!.path,
      category: '기타',
    );

    productsNotifier.add(newProduct);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$name 상품이 등록되었습니다!')));

    Navigator.of(context).pop();
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('쓸모없는 물건 내던지기')),
      body: SingleChildScrollView(
        child: Padding(
          padding: Styles.bodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('물건 사진'),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: _selectedImage == null ? Border.all() : null,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _selectedImage != null
                          ? Image.file(_selectedImage!, fit: BoxFit.cover)
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo_outlined),
                                const SizedBox(height: 8),
                                Text('터치해서 사진 추가'),
                              ],
                            ),
                      if (_selectedImage != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImage = null;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('던질 물건'),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: '예: 한쪽만 남은 양말'),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('버려진 이유'),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: '이 물건에 얽힌 눈물 나는 이야기를 적어주세요...',
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('판매 가격 (단위: 조약돌)'),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '조약돌 갯수 입력',
                  suffixIcon: Icon(Icons.diamond),
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('재고 수량'),
              QuantityControl(
                quantity: _stockQuantity,
                onIncrement: _incrementQuantity,
                onDecrement: _decrementQuantity,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: Styles.bodyPadding,
          child: CallToActionButton(
            text: '엉망진창 벼룩시장에 내던지기!',
            onPressed: () => _createProduct(context),
          ),
        ),
      ),
    );
  }
}
