import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:polio_app/countries_list.dart';

import 'Services/states_services.dart';

class Worldstates extends StatefulWidget {
  const Worldstates({super.key});

  @override
  State<Worldstates> createState() => _WorldstatesState();
}

class _WorldstatesState extends State<Worldstates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  )..repeat();

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      backgroundColor: Color(0xffFDFAF6),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: FutureBuilder(
              future: statesServices.fecthWorldRecords(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 350),
                    child: SpinKitThreeInOut(

                      color: Colors.blue,
                      size: 50.0,
                      controller: _controller,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Card(
                        color: Colors.black,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              PieChart(
                                dataMap: {
                                  "Total": double.parse(snapshot.data!.cases.toString()),
                                  "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                  "Deaths": double.parse(snapshot.data!.deaths.toString()),
                                },
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                                chartRadius: MediaQuery.of(context).size.height * 0.12,
                                animationDuration: Duration(milliseconds: 1200),
                                chartType: ChartType.ring,
                                colorList: colorList,
                                legendOptions: LegendOptions(
                                  showLegends: false,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Effected Overview",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("Total: ${snapshot.data!.cases}", style: TextStyle(color: Color(0xff4285F4), fontSize: 14)),
                                    Text("Recovered: ${snapshot.data!.recovered}", style: TextStyle(color: Color(0xff1aa260), fontSize: 14)),
                                    Text("Deaths: ${snapshot.data!.deaths}", style: TextStyle(color: Color(0xffde5246), fontSize: 14)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        child: Card(
                          color: Color(0xffFDFAF6),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              children: [
                                Reuseable(title: 'Population', value: snapshot.data!.population.toString()),
                                Reuseable(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                Reuseable(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                Reuseable(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                Reuseable(title: 'Active', value: snapshot.data!.active.toString()),
                                Reuseable(title: 'Critical Cases', value: snapshot.data!.critical.toString()),
                                Reuseable(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                                Reuseable(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                Reuseable(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 55),
            
                      //Track country Weidgt
                      GestureDetector(
                        onTap: () {
                          // Navigation logic
                        },
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:(context) =>CountriesList() ));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color:Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Track Country',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Reuseable extends StatelessWidget {
  final String title, value;

  const Reuseable({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18,fontStyle: FontStyle.normal,fontWeight: FontWeight.w400),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
