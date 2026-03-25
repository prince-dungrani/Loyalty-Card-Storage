import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_card_storage_app/features/cards/domain/models/loyalty_card.dart';
import 'package:loyalty_card_storage_app/features/cards/presentation/utils/barcode_helper.dart';
import 'package:uuid/uuid.dart';

class AddCardScreen extends StatefulWidget {
  final Function(LoyaltyCard)? onSave;

  const AddCardScreen({super.key, this.onSave});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController(); // optional parsing for MVP
  String _selectedBarcodeType = 'CODE_128';

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Mock Card Preview
          Container(
            height: 180,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF5A46E6),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5A46E6).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(Icons.contactless, color: Colors.white.withOpacity(0.5)),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  child: Container(
                    width: 150,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 200,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Customize your digital wallet by adding a\nnew rewards or loyalty card.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          // Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF5A46E6)),
                  label: const Text('Scan Barcode', style: TextStyle(color: Color(0xFF5A46E6), fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF5A46E6)),
                  label: const Text('Upload Image', style: TextStyle(color: Color(0xFF5A46E6), fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Form Container
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField('Card Name', 'e.g. Coffee Shop Rewards', controller: _nameController),
                const SizedBox(height: 16),
                _buildInputField('Card Number', '0000 0000 0000 0000', icon: Icons.credit_card, controller: _numberController),
                const SizedBox(height: 16),
                _buildInputField('Expiry Date', 'MM/YY', controller: _expiryController),
                const SizedBox(height: 16),
                
                // Barcode Format Dropdown
                const Text(
                  'Barcode Format',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1E5ED).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedBarcodeType,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black38),
                      // Hardcoding the types since we haven't imported BarcodeHelper cleanly here yet or it's static
                      items: [
                        'CODE_128', 'QR_CODE', 'EAN_13', 'UPC_A', 'CODE_39', 'DATA_MATRIX'
                      ]
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBarcodeType = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                 const Text(
                  'Notes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1E5ED).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Add any additional details here...',
                      hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (widget.onSave != null) {
                  // Fallbacks for empty forms
                  final cardName = _nameController.text.isNotEmpty ? _nameController.text : 'New Loyalty Card';
                  final cardNum = _numberController.text.isNotEmpty ? _numberController.text : '1234567890';
                  
                  final newCard = LoyaltyCard(
                    id: const Uuid().v4(),
                    name: cardName,
                    cardNumber: cardNum,
                    expiryDate: DateTime.now().add(const Duration(days: 365)), // mock future date
                    barcodeType: _selectedBarcodeType,
                  );
                  widget.onSave!(newCard);
                }
              },
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text('Save Card', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5A46E6),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 10,
                shadowColor: const Color(0xFF5A46E6).withOpacity(0.3),
              ),
            ),
          ),
          const SizedBox(height: 100), // padding for bottom nav
        ],
      ),
    );
  }

  Widget _buildInputField(String label, String hint, {IconData? icon, IconData? suffixIcon, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE1E5ED).withOpacity(0.5),
            borderRadius: BorderRadius.circular(24),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
              border: InputBorder.none,
              icon: icon != null ? Icon(icon, color: Colors.black38) : null,
              suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.black38) : null,
            ),
          ),
        ),
      ],
    );
  }
}
