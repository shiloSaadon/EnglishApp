import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_application/providers/progress_provider.dart';
import 'package:web_application/utilis.dart';
import 'package:provider/provider.dart';

class ChartsPage extends StatefulWidget {
  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  late TooltipBehavior _tooltipBehavior;
  late ProgressProvider pv;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pv = context.watch<ProgressProvider>();
    return Container(
      padding: EdgeInsets.only(top: 25, bottom: 0),
      height: relativeHeigth(heigth: 1300, context: context),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Text(
              'Daily progress',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),
          SfCartesianChart(
              //title: ChartTitle(text: 'Daily progress'),
              // Enables the tooltip for all the series in chart
              tooltipBehavior: _tooltipBehavior,
              // Initialize category axis
              primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey)),
              series: <ChartSeries>[
                // Initialize line series
                LineSeries<SalesData, String>(
                    width: 5,
                    color: Colors.blue[800],
                    enableTooltip: true,
                    dataSource: [
                      // Bind data source
                      SalesData('Shi', 2),
                      SalesData('Feb', 4),
                      SalesData('Mar', 1),
                      SalesData('Apr', 5),
                      SalesData('Apr', 2),
                      SalesData('May', 10)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales)
              ]),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double? sales;
}
