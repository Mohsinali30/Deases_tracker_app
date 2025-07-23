import 'package:flutter/material.dart';
import 'package:polio_app/worldStates.dart';


class ShowDatabyCountry extends StatefulWidget {
  String name;
  String image;
  int totalCases,population, totalDeaths , active, critical, todayRecvered,test;

   ShowDatabyCountry({
     required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.active,
     required this.critical,
     required this.todayRecvered,
     required this.test,
     required this.population


   });

  @override
  State<ShowDatabyCountry> createState() => _ShowDatabyCountryState();
}

class _ShowDatabyCountryState extends State<ShowDatabyCountry> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFDFAF6),
        title: Center(child: Text(widget.name,style: TextStyle(fontSize: 24,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),)),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
             Stack(
               alignment: Alignment.topCenter,
               children: [
                 Padding(
                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0456),
                   child: Card(
                     color: Color(0xffFDFAF6),
                     child: Column(
                       children: [
                         SizedBox(height: MediaQuery.of(context).size.height * .08),
                         Reuseable(title: 'Population', value:widget.population.toString()),
                         Reuseable(title: 'Cases', value:widget.totalCases.toString()),
                         Reuseable(title: 'Deaths', value:widget.totalDeaths.toString()),
                         Reuseable(title: 'Critical', value:widget.critical.toString()),
                         Reuseable(title: 'Active Cases', value:widget.active.toString()),
                         Reuseable(title: 'Recovered Cases', value:widget.todayRecvered.toString()),
                         Reuseable(title: 'Test', value:widget.test.toString()),
                       ],
                     ),
                   ),
                 ),
                 CircleAvatar(
                   radius: 50,
                   backgroundImage: NetworkImage(widget.image),

                 )
               ],
             )
        ],
      ),


    );




  }
}
