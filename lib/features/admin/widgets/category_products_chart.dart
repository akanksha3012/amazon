import 'package:amazon/features/admin/models/sales.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesData;
  final TextStyle xAxisLabelStyle;

  const CategoryProductsChart({
    Key? key,
    required this.salesData,
    required this.xAxisLabelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Adding margin of 8 from all sides
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: salesData.map((s) => s.earning).reduce((a, b) => a > b ? a : b).toDouble() + 10, // Adjust maxY to fit the chart
          barGroups: salesData.map((sales) {
            return BarChartGroupData(
              x: salesData.indexOf(sales),
              barRods: [
                BarChartRodData(
                  toY: sales.earning.toDouble(),
                  width: 16,
                  // Applying a gradient for multiple colors
                  gradient: const LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.greenAccent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
              showingTooltipIndicators: [0],
            );
          }).toList(),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40, // Increase space for y-axis labels
                interval: 10, // Display every 10 units on y-axis
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0), // Adjust spacing between y-axis and chart
                    child: Text(
                      value.toInt().toString(), // Ensure numbers like '10' fit on one line
                      style: const TextStyle(
                        fontSize: 12, // Adjust font size if needed
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  int index = value.toInt();
                  if (index < 0 || index >= salesData.length) {
                    return const SizedBox.shrink(); // Handle out-of-range issues
                  }

                  // Rotate x-axis labels vertically
                  return RotatedBox(
                    quarterTurns: 1, // Rotate 90 degrees to make it vertical
                    child: Text(
                      salesData[index].label,
                      style: xAxisLabelStyle,
                    ),
                  );
                },
                reservedSize: 55, // Reserve enough space for vertical labels
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
