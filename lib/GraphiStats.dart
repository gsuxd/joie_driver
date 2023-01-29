import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'colors.dart';

class GraphicPie extends StatefulWidget {
  const GraphicPie({Key? key}) : super(key: key);

  @override
  State<GraphicPie> createState() => _GraphicPieState();
}

class _GraphicPieState extends State<GraphicPie> {
  late final List<FoodData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  // ignore: must_call_super
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<FoodData, String>(
          dataSource: _chartData,
          xValueMapper: (FoodData data, _) => data.stat,
          yValueMapper: (FoodData data, _) => data.numb,
          enableTooltip: true,
          pointColorMapper: (FoodData data, _) => data.color,
        )
      ],
    );
  }

  List<FoodData> getChartData() {
    final List<FoodData> chartData = [
      FoodData('Viajes Completado', 96, blue),
      FoodData('Vieajes de Hoy', 5, Colors.green),
      FoodData('Cancelados por pasajero', 23, Colors.blueGrey),
      FoodData('Cancelados por conductor', 23, Colors.red),
    ];
    return chartData;
  }
}

class FoodData {
  final String stat;
  final int numb;
  final Color color;
  FoodData(
    this.stat,
    this.numb,
    this.color,
  );
}
