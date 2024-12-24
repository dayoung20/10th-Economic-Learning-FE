import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestMultipleChoicePage extends StatefulWidget {
  const TestMultipleChoicePage({super.key});

  @override
  State<TestMultipleChoicePage> createState() => _TestMultipleChoicePageState();
}

class _TestMultipleChoicePageState extends State<TestMultipleChoicePage> {
  int? _selectedOption;
  final List<String> options = [
    '단기간 대출을 받은 경우',
    '장기간 투자한 예금 계좌의\n이자가 점점 커지는 경우',
    '정기적으로 단리로 계산된\n이자만 지급되는 경우',
    '원금만 같아도 되는 상황'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        title: Text(
          '레벨테스트',
          style: Palette.appTitle,
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16), // 모든 모서리를 동일하게
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '1. 다음 중 복리 효과가 경제적\n결과로 나타날 수 있는\n상황으로 적절한 것은?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ...List.generate(
                  options.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedOption = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _selectedOption == index
                              ? Colors.green
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _selectedOption == index
                                ? Colors.green
                                : Colors.grey[300]!,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: _selectedOption == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                options[index],
                                style: TextStyle(
                                  color: _selectedOption == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
