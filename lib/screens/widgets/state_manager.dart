import 'package:shared_preferences/shared_preferences.dart';
// UNUSED CURRENTLY, HOPEFULLY WILL BE USED LATER
// TODO: Delete this file or get saves between instances working


class AppStateManager {
  static const String keyLieutenantOrders = 'lieutenant_orders';
  static const String keyRegularOrders = 'regular_orders';
  static const String keyIrregularOrders = 'irregular_orders';
  static const String keyImpetuousOrder = 'impetuous_order';

  static Future<void> saveOrdersState({
    required int lieutenantOrders,
    required int regularOrders,
    required int irregularOrders,
    required int impetuousOrder,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyLieutenantOrders, lieutenantOrders);
    prefs.setInt(keyRegularOrders, regularOrders);
    prefs.setInt(keyIrregularOrders, irregularOrders);
    prefs.setInt(keyImpetuousOrder, impetuousOrder);
  }

  static Future<Map<String, int>> loadOrdersState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      keyLieutenantOrders: prefs.getInt(keyLieutenantOrders) ?? 0,
      keyRegularOrders: prefs.getInt(keyRegularOrders) ?? 0,
      keyIrregularOrders: prefs.getInt(keyIrregularOrders) ?? 0,
      keyImpetuousOrder: prefs.getInt(keyImpetuousOrder) ?? 0,
    };
  }
}
