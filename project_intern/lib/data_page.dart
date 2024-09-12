import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:proje_intern/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dynamic Charts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: DataPage(),
    );
  }
}

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  String selectedData = 'temperature'; // Default olarak sıcaklık
  Map<String, String> dataValues = {
    'temperature': '32 °C',
    'carbon': '400 ppm',
    'humidity': '60 %'
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' '),   
        leading: IconButton(onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()),);}, icon: Icon(Icons.arrow_back),),
      ),
      body: Column(
        children: [
          // Üst taraftaki butonlar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedData = 'temperature';
                  });
                },
                child: Text('Sıcaklık'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedData = 'carbon';
                  });
                },
                child: Text('Karbondioksit'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedData = 'humidity';
                  });
                },
                child: Text('Nem'),
              ),
            ],
          ),
          SizedBox(height: 20),
          
          // Ortadaki daire içindeki veri
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blueGrey,
            child: Text(
              dataValues[selectedData]!,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          
          SizedBox(height: 20),
          
          // Haftalık grafik
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Haftalık Grafik', style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: GrafikWidget(
                      veriTipi: selectedData,
                      zamanAraligi: 'haftalık',
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Aylık grafik
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Aylık Grafik', style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: GrafikWidget(
                      veriTipi: selectedData,
                      zamanAraligi: 'aylık',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class GrafikWidget extends StatelessWidget {
  final String veriTipi;
  final String zamanAraligi;

  GrafikWidget({required this.veriTipi, required this.zamanAraligi});

  List<FlSpot> getDataSpots() {
    if (zamanAraligi == 'haftalık') {
      return getWeeklyDataSpots();
    } else {
      return getMonthlyDataSpots();
    }
  }

  List<FlSpot> getWeeklyDataSpots() {
    if (veriTipi == 'temperature') {
      return [
        FlSpot(0, 25),  // MON
        FlSpot(1, 28),  // TUE
        FlSpot(2, 30),  // WED
        FlSpot(3, 40),  // THU
        FlSpot(4, 30),  // FRI
        FlSpot(5, 33),  // SAT
        FlSpot(6, 32),  // SUN
      ];
    } else if (veriTipi == 'carbon') {
      return [
        FlSpot(0, 450),
        FlSpot(1, 460),
        FlSpot(2, 470),
        FlSpot(3, 480),
        FlSpot(4, 490),
        FlSpot(5, 500),
        FlSpot(6, 510),
      ];
    } else {
      return [
        FlSpot(0, 60),
        FlSpot(1, 70),
        FlSpot(2, 64),
        FlSpot(3, 66),
        FlSpot(4, 68),
        FlSpot(5, 70),
        FlSpot(6, 72),
      ];
    }
  }

  List<FlSpot> getMonthlyDataSpots() {
    if (veriTipi == 'temperature') {
      return [
        FlSpot(0, 27),  
        FlSpot(1, 29),   
        FlSpot(2, 31),  
        FlSpot(3, 35),  
        FlSpot(4, 39),
        FlSpot(5, 37),
        FlSpot(6, 31),
        FlSpot(7, 33),
        FlSpot(8, 34),
        FlSpot(9, 35),
        FlSpot(10, 30),
        FlSpot(11, 37),
      ];
    } else if (veriTipi == 'carbon') {
      return [
                        FlSpot(0, 450),
                        FlSpot(1, 460),
                        FlSpot(2, 470),
                        FlSpot(3, 480),
                        FlSpot(4, 490),
                        FlSpot(5, 500),
                        FlSpot(6, 510),
                        FlSpot(7, 520),
                        FlSpot(8, 530),
                        FlSpot(9, 540),
                        FlSpot(10, 550),
                        FlSpot(11, 560),
      ];
    } else {
      return [
                        FlSpot(0, 60),
                        FlSpot(1, 70),
                        FlSpot(2, 64),
                        FlSpot(3, 66),
                        FlSpot(4, 68),
                        FlSpot(5, 70),
                        FlSpot(6, 72),
                        FlSpot(7, 74),
                        FlSpot(8, 76),
                        FlSpot(9, 78),
                        FlSpot(10, 75),
                        FlSpot(11, 73),
      ];
    }
  }

  Color getLineColor() {
    if (veriTipi == 'temperature') {
      return Colors.redAccent;
    } else if (veriTipi == 'carbon') {
      return Colors.greenAccent;
    } else {
      return Colors.blueAccent;
    }
  }
  @override
  Widget build(BuildContext context) {
    double maxY = 60; // Default maxY
    double minY = 0;  // Default minY

    if (veriTipi == 'carbon') {
      maxY = 650;
      minY = 400;
    } else if (veriTipi == 'humidity') {
      maxY = 100;
      minY = 0;
    }

    return SizedBox(
      height: 150,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: getDataSpots(),
              isCurved: zamanAraligi == 'haftalık',
              color: getLineColor(),
              belowBarData: BarAreaData(
                show: zamanAraligi == 'haftalık',
                color:getLineColor().withOpacity(0.4),
              ),
              barWidth: 4,
              dotData: FlDotData(
                show: zamanAraligi == 'aylık',
              ),
            ),
          ],
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey[700],
                strokeWidth: 1,
              );
            },
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey[600],
                strokeWidth: 1,
              );
            },
            horizontalInterval: veriTipi == 'carbon' ? 50 : 10,
            verticalInterval: 1,
          ),
titlesData: FlTitlesData(
  leftTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 40,
      getTitlesWidget: (value, meta) {
        // Y ekseni için değerlerin gösterilmesi
        if (veriTipi == 'carbon') {
          if (value % 50 == 0) { // Karbondioksit için her 50 birimde bir göster
            return Text(
              '${value.toInt()}',
              style: const TextStyle(color: Color.fromARGB(255, 10, 10, 10), fontSize: 12),
            );
          }
        } else {
          if (value % 10 == 0) { // Diğer veri tipleri için her 10 birimde bir göster
            return Text(
              '${value.toInt()}',
              style: const TextStyle(color: Color.fromARGB(255, 7, 7, 7), fontSize: 12),
            );
          }
        }
        return const SizedBox.shrink();
      },
      interval: veriTipi == 'carbon' ? 50 : 10, // Karbondioksit için 50, diğerleri için 10 aralık
    ),
  ),
  bottomTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 40,
      getTitlesWidget: (value, meta) {
        if (zamanAraligi == 'haftalık') {
          // Haftalık grafik için günler
          switch (value.toInt()) {
            case 0:
              return const Text('MON', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 1:
              return const Text('TUE', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 2:
              return const Text('WED', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 3:
              return const Text('THU', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 4:
              return const Text('FRI', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 5:
              return const Text('SAT', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 6:
              return const Text('SUN', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            default:
              return const SizedBox.shrink();
          }
        } else {
          // Aylık grafik için aylar
          switch (value.toInt()) {
            case 0:
              return const Text('JAN', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 1:
              return const Text('FEB', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 2:
              return const Text('MAR', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 3:
              return const Text('APR', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 4:
              return const Text('MAY', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 5:
              return const Text('JUN', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 6:
              return const Text('JUL', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 7:
              return const Text('AUG', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 8:
              return const Text('SEP', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 9:
              return const Text('OCT', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 10:
              return const Text('NOV', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            case 11:
              return const Text('DEC', style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)));
            default:
              return const SizedBox.shrink();
          }
        }
      },
      interval: 1, // X eksenindeki bölümler için
    ),
  ),
  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
),

          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey[700]!, width: 1),
          ),
          minY: minY,
          maxY: maxY,
        ),
      ),
    );
  }
}
