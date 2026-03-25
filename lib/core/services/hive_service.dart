import 'package:hive_flutter/hive_flutter.dart';
import 'package:loyalty_card_storage_app/features/cards/domain/models/loyalty_card.dart';

class HiveService {
  static const String cardsBoxName = 'loyalty_cards_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    // Register adapters
    // Hive.registerAdapter(LoyaltyCardAdapter());
    await Hive.openBox(cardsBoxName);
  }

  static Box getCardsBox() => Hive.box(cardsBoxName);

  static Future<void> saveCard(Map<String, dynamic> cardData) async {
    final box = getCardsBox();
    
    // Encrypt sensitive data
    if (cardData.containsKey('cardNumber')) {
      cardData['cardNumber'] = await EncryptionService.encrypt(cardData['cardNumber']);
    }
    
    await box.put(cardData['id'], cardData);
  }

  static Future<List<Map<String, dynamic>>> getAllCards() async {
    final box = getCardsBox();
    final List<Map<String, dynamic>> cards = [];
    
    for (var value in box.values) {
      final card = Map<String, dynamic>.from(value);
      if (card.containsKey('cardNumber')) {
        card['cardNumber'] = await EncryptionService.decrypt(card['cardNumber']);
      }
      cards.add(card);
    }
    return cards;
  }

  static Future<void> deleteCard(String id) async {
    final box = getCardsBox();
    await box.delete(id);
  }
}
