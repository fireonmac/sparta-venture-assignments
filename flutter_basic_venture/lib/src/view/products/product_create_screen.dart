import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/styles.dart';
import 'package:flutter_basic_venture/src/utils/navigation.dart';
import 'package:flutter_basic_venture/src/widgets/call_to_action_button.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  static Route<dynamic> buildRoute(BuildContext context) {
    return buildScreenRoute(context, screen: const ProductCreateScreen());
  }

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
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
                onTap: () {},
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined),
                      const SizedBox(height: 8),
                      Text('터치해서 사진 추가'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('물건 이름'),
              TextField(decoration: InputDecoration(hintText: '예: 한쪽만 남은 양말')),
              const SizedBox(height: 24),

              _buildSectionTitle('물건 설명'),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: '이 물건에 얽힌 눈물 나는 이야기를 적어주세요...',
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('판매 가격 (단위: 조약돌)'),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '숫자만 입력',
                  suffixIcon: Icon(Icons.sunny),
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: CallToActionButton(text: '엉망진창 벼룩시장에 내던지기!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
