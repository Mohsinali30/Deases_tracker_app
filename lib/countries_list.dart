import 'package:flutter/material.dart';
import 'package:polio_app/Services/states_services.dart';
import 'package:polio_app/data_by_Country.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  StatesServices statesServices = StatesServices();

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body:Column(

        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50,),
            child: TextFormField(
            onChanged: (value){
              setState(() {

              });
            },
                 controller: searchController,

              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
               hint:Text("Search") ,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(50.0),
                 borderSide: BorderSide(
                   color: Colors.white, // Change this to any color
                   width: 8.0,
                 ),

               ),

              ),
            ),
          ),

           Expanded(
             child: FutureBuilder(future: statesServices.Countrieslist(),
                 builder: (context,AsyncSnapshot<dynamic> snapshot){

               if(!snapshot.hasData){
                 return
                   ListView.builder(
                     itemCount: 6,
                     itemBuilder: (context, index)
                     {
                       return Shimmer.fromColors(

                           baseColor: Colors.grey.shade400,
                           highlightColor: Colors.grey.shade100,
                           child: Column(
                       children: [
                       ListTile(
                       title: Container(height: 10,width: 89,color: Colors.white,),
                       subtitle:Container(height: 10,width: 89,color: Colors.white,),
                     leading:
                     Container(height: 50,width: 50,color: Colors.white,),
                     )
                     ],
                       ),
                       );



                     }
                 );
               }
               else{
                 return ListView.builder(
                     itemCount: snapshot.data!.length,
                     itemBuilder: (context, index)
                 {

                   String country = snapshot.data![index]['country'].toString();
                   if(searchController.text.isEmpty){

                     return Column(
                       children: [
                         InkWell(
                           onTap: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) => ShowDatabyCountry(
                                   name: snapshot.data![index]['country'],
                                   image: snapshot.data![index]['countryInfo']['flag'],
                                   totalCases: snapshot.data![index]['cases'],
                                   totalDeaths: snapshot.data![index]['deaths'],
                                   active: snapshot.data![index]['active'],
                                   critical: snapshot.data![index]['critical'],
                                   todayRecvered: snapshot.data![index]['recovered'],
                                   test: snapshot.data![index]['tests'],
                                   population: snapshot.data![index]['population'],
                                 ),
                               ),
                             );
                           },
                           child: ListTile(

                             title: Text(snapshot.data![index]['country']),
                             subtitle: Text(snapshot.data![index]['cases'].toString()),
                             leading:CircleAvatar (
                               radius:25,
                                 backgroundImage: NetworkImage(
                                   
                                 snapshot.data![index]['countryInfo']['flag'],


                               ),
                             ),
                           ),
                         ),
                       ],
                     );

                   }
                   else if(country.toLowerCase().contains(searchController.text.toLowerCase())){

                     return Column(
                       children: [
                         InkWell(
                           onTap: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) => ShowDatabyCountry(
                                   name: snapshot.data![index]['country'],
                                   image: snapshot.data![index]['countryInfo']['flag'],
                                   totalCases: snapshot.data![index]['cases'],
                                   totalDeaths: snapshot.data![index]['deaths'],
                                   active: snapshot.data![index]['active'],
                                   critical: snapshot.data![index]['critical'],
                                   todayRecvered: snapshot.data![index]['recovered'],
                                   test: snapshot.data![index]['tests'],
                                   population: snapshot.data![index]['population'],
                                 ),
                               ),
                             );
                           },
                           child: ListTile(
                             title: Text(snapshot.data![index]['country']),
                             subtitle: Text(snapshot.data![index]['cases'].toString()),
                             leading: Image.network(
                               snapshot.data![index]['countryInfo']['flag'],
                               height: 50,
                               width: 50,
                             ),
                           ),
                         ),
                       ],
                     );

                   }
                   else{
                   return Container();
                   }




                 }
                 );
               }



                 }

             ),
           )
        ],
      )
    );
  }
}
