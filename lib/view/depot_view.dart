import 'package:flutter/material.dart';
import 'package:flutter_banking/common/chart_painter.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/viewmodel/depot_model.dart';

class DepotView extends StatefulWidget {
  @override
  _DepotViewState createState() => _DepotViewState();
}

class _DepotViewState extends State<DepotView> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BaseView<DepotModel>(builder: (_, model, child) {
      return Scaffold(
        appBar: _buildAppBar(theme),
        body: _buildBody(theme),
      );
    });
  }

  AppBar _buildAppBar(ThemeData theme) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          border: InputBorder.none,
          hintText: 'Search for stocks, ETFs, ...',
          hintStyle: theme.primaryTextTheme.subhead,
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  _buildBody(ThemeData theme) {
    final TextStyle title = theme.textTheme.title;
    final TextStyle subTitle = theme.textTheme.subtitle;

    return ListView(
      padding: const EdgeInsets.symmetric(
          horizontal: 6, vertical: Dimens.listVerticalPadding),
      children: [
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  'Watchlist',
                  style: title,
                ),
              ),
              _buildWatchListItem(subTitle, 'Drillisch', 22.92, 0.88),
              _buildWatchListItem(subTitle, 'Wirecard', 114.90, -1.54),
              _buildWatchListItem(subTitle, 'Facebook', 181.14, 1.24),
            ],
          ),
        )
      ],
    );
  }

  ListTile _buildWatchListItem(
      TextStyle subTitle, String stockName, double value, double valueChange) {
    final bool isPositive = valueChange >= 0;
    final Color valueChangeColor = isPositive ? Colors.green : Colors.red;
    final IconData valueChangeIcon =
        isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    return ListTile(
      title: Text(stockName),
      onTap: () {},
      subtitle: Text('$value €', style: subTitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            width: 120,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: CustomPaint(
              painter: ChartPainter(),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              height: 32,
              width: 84,
              color: valueChangeColor.withOpacity(0.10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    valueChangeIcon,
                    color: valueChangeColor,
                  ),
                  Expanded(child: Container()),
                  Text(
                    '$valueChange %',
                    style: subTitle.copyWith(color: valueChangeColor),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
