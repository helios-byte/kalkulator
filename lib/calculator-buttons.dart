import 'package:flutter/material.dart';

class CalculatorButtons extends StatelessWidget {
  final void Function(String) onTap;

  CalculatorButtons({required this.onTap});

  final List<String> buttons = [
    '7', '8', '9', '/',
    '4', '5', '6', '*',
    '1', '2', '3', '-',
    '0', '.', '=', '+',
    'C'
  ];

  // Fungsi untuk menentukan warna tombol berdasarkan jenis tombol
  Color _getButtonColor(String text) {
    if (text == 'C') return Colors.redAccent;
    if (text == '=' ) return Colors.green;
    if ('/*-+'.contains(text)) return Colors.orange;
    return Colors.grey[850]!; // tombol angka warna gelap
  }

  // Fungsi untuk menentukan warna teks tombol
  Color _getTextColor(String text) {
    if (text == 'C' || text == '=' || '/*-+'.contains(text)) {
      return Colors.white;
    }
    return Colors.white70;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,   // Lebar fixed
      height: 420,  // Tinggi fixed
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 8,
            offset: Offset(2, 4),
          )
        ],
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(), // Disable scroll
        shrinkWrap: true,
        itemCount: buttons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          final buttonText = buttons[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _getButtonColor(buttonText),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 5,
              shadowColor: Colors.black87,
            ),
            onPressed: () => onTap(buttonText),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: _getTextColor(buttonText),
              ),
            ),
          );
        },
      ),
    );
  }
}
