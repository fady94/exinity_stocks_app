import 'package:exinity_app/core/resources/colors.dart';
import 'package:exinity_app/extensions/context.dart';
import 'package:exinity_app/extensions/media_query.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:flutter/material.dart';

class StockTileWidget extends StatelessWidget {
  final StockEntity stock;

  const StockTileWidget({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    String percentage = context.formatNumber(stock.changePercentage);
    return ListTile(
      title: Text(
        stock.symbolEntity.displaySymbol,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        stock.symbolEntity.description,
        style: const TextStyle(
            fontWeight: FontWeight.w400, color: ColorManager.secondaryColor),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            stock.currentPrice.toString(),
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Container(
            width: context.width / 5.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: stock.changePercentage > 0 ? Colors.green : Colors.red,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Center(
              child: Text("$percentage%",
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
