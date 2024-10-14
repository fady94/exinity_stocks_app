import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/features/stocks/presentation/widgets/stock_tile_widget.dart';
import 'package:flutter/material.dart';

class StockListBuilder extends StatelessWidget {
  final List<StockEntity> stocks;
  final bool isDismissable;
  final void Function(String sym) onDismissed;

  const StockListBuilder(
      {super.key,
      required this.stocks,
      this.isDismissable = false,
      required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        return isDismissable
            ? Column(
                children: [
                  Dismissible(
                    direction: DismissDirection.endToStart,
                    behavior: HitTestBehavior.translucent,
                    background: Container(
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Remove From Watchlist",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 10),
                            Icon(Icons.delete, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    key: ValueKey<String>(stocks[index].symbolEntity.symbol),
                    onDismissed: (DismissDirection direction) {
                      onDismissed(stocks[index].symbolEntity.symbol);
                    },
                    child: StockTileWidget(
                      stock: stocks[index],
                    ),
                  ),
                  const Divider(
                    height: 0.5,
                    thickness: 0.7,
                  )
                ],
              )
            : Column(
                children: [
                  StockTileWidget(
                    stock: stocks[index],
                  ),
                  const Divider(
                    height: 0.5,
                    thickness: 0.7,
                  )
                ],
              );
      },
    );
  }
}
