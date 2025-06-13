import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int rescued = 0;

  int found = 0;

  int pending = 0;

  int adopted = 0;

  int total = 0;

  @override
  void initState() {
    super.initState();
    fetchInfo();
  }

  Future<void> fetchInfo() async {
    try {
      final response = await http.get(
          Uri.parse('https://minor-backend-xi.vercel.app/api/animal/info'));
      final jsonBody = response.body;
      final jsonResponse = json.decode(jsonBody);
      setState(() {
        rescued = jsonResponse['statusCounts']['rescued'] ?? 0;
        adopted = jsonResponse['statusCounts']['adopted'] ?? 0;
        found = jsonResponse['statusCounts']['found'] ?? 0;
        pending = jsonResponse['statusCounts']['pending'] ?? 0;
        total = rescued + adopted + found + pending;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Pie Chart Section
              const Text(
                'Rescue Status Overview',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: total > 0
                        ? [
                            PieChartSectionData(
                              value: (rescued / total) * 100,
                              color: Colors.pinkAccent,
                              title: '${rescued.toString()}',
                              radius: 80,
                              titleStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: (found / total) * 100,
                              color: Colors.orangeAccent,
                              title: '${found.toString()}',
                              radius: 70,
                              titleStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: (adopted / total) * 100,
                              color: Colors.blueAccent,
                              title: '${adopted.toString()}',
                              radius: 70,
                              titleStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: (pending / total) * 100,
                              color: Colors.redAccent,
                              title: '${pending.toString()}',
                              radius: 70,
                              titleStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ]
                        : [], // If total is 0, provide an empty list to avoid NaN
                    centerSpaceRadius: 50,
                    sectionsSpace: 3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(Colors.pinkAccent, 'Rescued'),
                  const SizedBox(width: 10),
                  _buildLegendItem(Colors.orangeAccent, 'Found'),
                  const SizedBox(width: 10),
                  _buildLegendItem(Colors.redAccent, 'Pending'),
                ],
              ),
              const SizedBox(height: 30),
              // Statistics Boxes
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final data = [
                    {
                      'title': 'Total Rescued',
                      'value': rescued,
                      'color': Colors.pinkAccent,
                      'icon': Icons.pets,
                    },
                    {
                      'title': 'Total Found',
                      'value': found,
                      'color': Colors.orangeAccent,
                      'icon': Icons.cruelty_free,
                    },
                    {
                      'title': 'Total Adopted',
                      'value': adopted,
                      'color': Colors.blueAccent,
                      'icon': Icons.home,
                    },
                    {
                      'title': 'Total Pending',
                      'value': pending,
                      'color': Colors.redAccent,
                      'icon': Icons.pending_actions,
                    },
                  ][index];

                  return _buildStatCard(
                    data['title'] as String,
                    data['value'] as int,
                    data['color'] as Color,
                    data['icon'] as IconData,
                    size.width,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, int value, Color color, IconData icon, double width) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: width > 600 ? 50 : 40,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
