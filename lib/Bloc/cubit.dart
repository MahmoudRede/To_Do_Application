
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../Modules/arvhived.dart';
import '../Modules/done.dart';
import '../Modules/tasks.dart';
import 'cubitstates.dart';

class Appcubit extends Cubit<Appstates>{

  Appcubit() : super( Appintialstate());

   static Appcubit get(context) => BlocProvider.of(context);

  int currentindex=0;
  Database database;
  List Newtasks =[];
  List Donetasks =[];
  List Archivedtasks =[];


  var controller1=TextEditingController();
  var controller2=TextEditingController();
  var controller3=TextEditingController();




  List screen=[
    Tasks(),
    Done(),
    Archined(),

  ];
  List titles=[
    "Tasks",
    "Done",
    "Archived",
  ];

  void tap(index){
    currentindex=index;
    emit(Appnavegited());
  }

  bool cheak=false;

  void booll(correct){
    cheak=correct;
  }


  void create_database(){

     openDatabase(
        'Todo',
        version: 1,

        onCreate: (database,version){

          print('Database Created');
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT,status TEXT )').then((value) {
            print('Table Created');
          }).catchError((error){
            print("Error Is ${error.toString()}");
          });

        },
        onOpen: (database){
          get_from_database(database);
          print('Database Opened');
        }
    ).then((value) {
      
      database=value;
      emit(Appcreatestate());
     });
  }

   insert_in_database({@required String title,@required String time,@required String date}) async {

     await database.transaction((txn) {
      txn.rawInsert('INSERT INTO tasks (title , time ,date ,status) VALUES ("$title","$time","$date","new" )')
       .then((value) {
        print('${value} Insert Succssed');
        emit(Appinsertstate());
        get_from_database(database);
      }).catchError((error){print('Error Is ${error}');});
      return null;
    });

  }

  void get_from_database(database) {

     Newtasks =[];
     Donetasks =[];
     Archivedtasks =[];

    database.rawQuery('SELECT * FROM tasks').then((value) {

       controller1.text="";
       controller2.text="";
       controller3.text="";

       value.forEach((element){

         if(element['status']=='new'){
           Newtasks.add(element);
         }
        else if(element['status']=='Done'){
           Donetasks.add(element);
         }
         else {
           Archivedtasks.add(element);
         }

       });

       emit(Appgetstate());

     });
  }


 void update_dataebase(String status, int id) async{
    database.rawUpdate(
       'UPDATE tasks SET status = ? WHERE id = ?',
       ['$status', id])
        .then((value) {
          get_from_database(database);
          emit(Appupdatestate());
        });
 }

  void delete_dataebase( int id) async{
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
        .then((value) {
      get_from_database(database);
      emit(Appdeletestate());
    });
  }
  bool isswitch=false;

  Color w=Colors.white;
  Color b=Color.fromRGBO(34, 34, 34 , 1);

   void change_switch (context){
    isswitch?  isswitch=false:isswitch=true;
  Appcubit.get(context).w==Colors.white?Appcubit.get(context).w=Color.fromRGBO(34, 34, 34 , 1):Appcubit.get(context).w=Colors.white;
  Appcubit.get(context).b==Color.fromRGBO(34, 34, 34 , 1)? Appcubit.get(context).b=Colors.white: Appcubit.get(context).b=Color.fromRGBO(34, 34, 34 , 1);
  emit(Appswitchestate());
  }
}