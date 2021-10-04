

import 'package:currency_converter/Themes/colors.dart';
import 'package:flutter/material.dart';

class DecimalScreens extends StatefulWidget {
  const DecimalScreens({Key? key}) : super(key: key);

  @override
  _DecimalScreensState createState() => _DecimalScreensState();
}

class _DecimalScreensState extends State<DecimalScreens> {

  int value=-1;
  int value1=-1;
  int num=4;
  int num1=6;

  List <String>radiMonetaryFormat=["12334.56","1.234,56","1 234.56","1 234,56",];
  List <bool> boolMonetaryFormate=[false,false,false,false];
  List <bool> boolDecimalFormate=[false,false,false,false,false,false];
  List <String>radiDecimalFormat=[".02",".003",".0004",".00005",".0000006","Dont't show "];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(height: 10,),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.share,color: MyColors.textColor)),
            ],
          ),

          Row(
            children: [
              Container(
                width: 180,
                child: Column(
                  children: [

                    Text("Monetary Format",style: TextStyle(color: MyColors.textColor,fontSize: 20),),
                    SizedBox(height: 10,),
                    ListView.builder(
                      padding: EdgeInsets.all(0),

                      shrinkWrap: true,

                      itemCount:num,
                      itemBuilder: (context, index) {
                        return  Container(
                          width: 150,
                          height: 38  ,
                          child: Row(
                            children: [    Checkbox(
                              side: BorderSide(color: MyColors.textColor),
                              value:boolMonetaryFormate[index] ,


                              onChanged: (value) {
                                int j=0;
                                setState(() {


                                  boolMonetaryFormate.forEach((element) {


                                    if(index==j)
                                    {
                                      boolMonetaryFormate[j]=true;
                                    }
                                    else
                                      boolMonetaryFormate[j]=false;

                                    j++;
                                  });

                                });
                              },
                              activeColor: MyColors.checkBoxValue2?Colors.black45:Colors.white,
                              checkColor: Colors.black,
                              tristate: false,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                              Text("${radiMonetaryFormat[index]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: MyColors.textColor)),],

                          ),
                        );
                      },

                    ),





                  ],
                ),
              ),
              Column(children: [

                Container(
                  margin: EdgeInsets.only(top: 40),
                  width: 180,

                  child: Column(
                    children: [

                      Text("Decimal Format",style: TextStyle(color: MyColors.textColor,fontSize: 20),),
                      SizedBox(height: 10,),
                      ListView.builder(
                        padding: EdgeInsets.all(0),

                        shrinkWrap: true,

                        itemCount:5,
                        itemBuilder: (context, index) {
                          return  Container(
                            width: 150,
                            height: 38  ,
                            child: Row(
                           children: [    Checkbox(
                             side: BorderSide(color: MyColors.textColor),
                             value:boolDecimalFormate[index] ,


                             onChanged: (value) {
                               int i=0;
                               setState(() {


                                 boolDecimalFormate.forEach((element) {


                                   if(index==i)
                                     {
                                       boolDecimalFormate[i]=true;
                                     }
                                   else
                                     boolDecimalFormate[i]=false;

                                     i++;
                                 });

                               });
                             },
                             activeColor: MyColors.checkBoxValue2?Colors.black45:Colors.white,
                             checkColor: Colors.black,
                             tristate: false,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)),
                           ),
                             Text("${radiDecimalFormat[index]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: MyColors.textColor)),],

                            ),
                          );
                        },

                      ),





                    ],
                  ),
                ),

              ],)

            ],
          ),





        ],
      ),
    );
  }
}
