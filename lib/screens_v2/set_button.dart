import 'package:flutter/material.dart';

class SetButton extends StatefulWidget {
  final int initialLieutenantOrders;
  final int initialRegularOrders;
  final int initialIrregularOrders;
  final int initialImpetuousOrder;

  final Function(int) onLieutenantOrdersChanged;
  final Function(int) onRegularOrdersChanged;
  final Function(int) onIrregularOrdersChanged;
  final Function(int) onImpetuousOrderChanged;

  const SetButton({
    Key? key,
    required this.initialLieutenantOrders,
    required this.initialRegularOrders,
    required this.initialIrregularOrders,
    required this.initialImpetuousOrder,
    required this.onLieutenantOrdersChanged,
    required this.onRegularOrdersChanged,
    required this.onIrregularOrdersChanged,
    required this.onImpetuousOrderChanged,
  }) : super(key: key);

  @override
  _SetButtonState createState() => _SetButtonState();
}

class _SetButtonState extends State<SetButton> {
  late int _lieutenantOrders;
  late int _regularOrders;
  late int _irregularOrders;
  late int _impetuousOrder;

  @override
  void initState() {
    super.initState();
    _lieutenantOrders = widget.initialLieutenantOrders;
    _regularOrders = widget.initialRegularOrders;
    _irregularOrders = widget.initialIrregularOrders;
    _impetuousOrder = widget.initialImpetuousOrder;
  }

  @override
  Widget build(BuildContext context) {
    return _buildDialog();
  }

  Widget _buildDialog() {
    return AlertDialog(
      title: const Text('Set Orders'),
      content: Column(
        children: [
          buildOrderRow(
            orderType: 'Lieutenant',
            orderCount: _lieutenantOrders,
            onOrderCountChanged: widget.onLieutenantOrdersChanged,
          ),
          buildOrderRow(
            orderType: 'Regular',
            orderCount: _regularOrders,
            onOrderCountChanged: widget.onRegularOrdersChanged,
          ),
          buildOrderRow(
            orderType: 'Irregular',
            orderCount: _irregularOrders,
            onOrderCountChanged: widget.onIrregularOrdersChanged,
          ),
          buildOrderRow(
            orderType: 'Impetuous',
            orderCount: _impetuousOrder,
            onOrderCountChanged: widget.onImpetuousOrderChanged,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Done'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget buildOrderRow({
    required String orderType,
    required int orderCount,
    required Function(int) onOrderCountChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            onOrderCountChanged(orderCount - 1);
            _updateState();
          },
        ),
        Text("$orderType Orders: $orderCount"),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            onOrderCountChanged(orderCount + 1);
            _updateState();
          },
        ),
      ],
    );
  }

  // Force the dialog to rebuild
  void _updateState() {
    setState(() {});
  }
}