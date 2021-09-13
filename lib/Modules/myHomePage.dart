import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todolist/Bloc/cubit.dart';
import 'package:flutter_todolist/Bloc/cubitstates.dart';
import 'package:flutter_todolist/icon_broken.dart';

import 'package:intl/intl.dart';


class MyHomePage extends StatelessWidget {


  var key1= GlobalKey<ScaffoldState>();
  var keyvalaside= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<Appcubit,Appstates >(
        listener: (context,state) {
          if(state is Appinsertstate){
            Navigator.pop(context);
          }
        },
        builder: (context,state) => Scaffold(
          key: key1,
          appBar: AppBar(
//            backgroundColor: Colors.red,
            title: Text(Appcubit.get(context).titles[Appcubit.get(context).currentindex],
              style: TextStyle
                (
                  color:Appcubit.get(context).b,
                  fontSize: 23,
                  fontFamily: 'OpenSans'
                ),),
            actions: [
              Switch(
                  inactiveThumbColor: Colors.black,
                  activeColor: Colors.white,
                  value: Appcubit.get(context).isswitch, onChanged: (value){
                  Appcubit.get(context).change_switch(context);



              })
            ],
          ),
          body: Appcubit.get(context).screen[Appcubit.get(context).currentindex],
          floatingActionButton: FloatingActionButton(
              backgroundColor:Appcubit.get(context).b,
              child: Icon(IconBroken.Paper_Plus,color: Appcubit.get(context).w,),
              onPressed: (){
                if(Appcubit.get(context).cheak){
                      if(keyvalaside.currentState.validate()){
                        Appcubit.get(context).insert_in_database(title: Appcubit.get(context).controller1.text, time: Appcubit.get(context).controller2.text, date: Appcubit.get(context).controller3.text).then((value) {

                          Appcubit.get(context).cheak=false;
                      });
                  }
                }
                else{
                  key1.currentState.showBottomSheet((context) =>
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          color: Appcubit.get(context).w,
                          child: Form(
                            key: keyvalaside,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.title,color: Appcubit.get(context).b,),
                                      labelText: ('Tilte Task'),
                                      labelStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Appcubit.get(context).b),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  style: TextStyle(
                                      color: Appcubit.get(context).b,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.text,
                                  controller: Appcubit.get(context).controller1,
                                  // ignore: missing_return
                                  validator: (value){
                                    if(value.isEmpty){
                                      return ("Enter Title");
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.timelapse,color: Appcubit.get(context).b,),
                                      labelText: ('Time Of Task'),
                                      labelStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Appcubit.get(context).b),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  style: TextStyle(
                                      color: Appcubit.get(context).b,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.text,
                                  controller: Appcubit.get(context).controller2,

                                  onTap: (){
                                    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                                      Appcubit.get(context).controller2.text=value.format(context);
                                    });

                                  },
                                  // ignore: missing_return
                                  validator: (value){
                                    if(value.isEmpty){
                                      return ("Enter Time");
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.date_range_outlined,color: Appcubit.get(context).b,),
                                      labelText: ('Date Task'),
                                      labelStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Appcubit.get(context).b),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  style: TextStyle(
                                      color: Appcubit.get(context).b,
                                      fontWeight: FontWeight.bold)

                                  ,
                                  keyboardType: TextInputType.text,
                                  controller: Appcubit.get(context).controller3,
                                  onTap: (){
                                    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate:DateTime.parse('2022-09-03')).then((value) {
                                      Appcubit.get(context).controller3.text=  DateFormat.yMMMEd().format(value);
                                    });
                                  },
                                  // ignore: missing_return
                                  validator: (value){
                                    if(value.isEmpty){
                                      return ("Enter Date");
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ).closed.then((value) {
                    Appcubit.get(context).cheak=false;
                  });
                  Appcubit.get(context).cheak=true;
                }
              }
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: Appcubit.get(context).currentindex,
            onTap: (index){

              Appcubit.get(context).tap(index);

            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Shield_Done),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Shield_Fail),
                label: 'Archived',
              ),
            ],
          ),
        ),
    );
  }


}

