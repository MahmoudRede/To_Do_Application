import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todolist/Bloc/cubit.dart';
import 'package:flutter_todolist/Bloc/cubitstates.dart';


class Done extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,Appstates>(
      listener: (context,state){},
      builder: (context,state)=> Container(
        color:Appcubit.get(context).w,
          width: double.infinity,
          child: ConditionalBuilder(
            condition: Appcubit.get(context).Donetasks.length>0,
            builder: (context)=> ListView.separated(
                itemBuilder: (context,index)
                {
                  return Dismissible(
                    key: Key(Appcubit.get(context).Donetasks[index]['id'].toString()),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.redAccent,
                                  child: Text('${Appcubit.get(context).Donetasks[index]['time']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white,),),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Expanded(
                                child: Column(
                                    children: [
                                      Text(Appcubit.get(context).Donetasks[index]['title'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Appcubit.get(context).b,),),
                                      SizedBox(height: 5,),
                                      Text(Appcubit.get(context).Donetasks[index]['date'],style: TextStyle(fontSize: 13,color: Appcubit.get(context).b)),
                                    ]
                                ),
                              ),
                              SizedBox(width: 15,),
                              IconButton(icon: Icon(Icons.cloud_done,color: Colors.red,), onPressed: (){
                                Appcubit.get(context).update_dataebase('Done',Appcubit.get(context).Donetasks[index]['id'] );
                              }),
                              SizedBox(width: 10,),
                              IconButton(icon: Icon(Icons.archive,color: Appcubit.get(context).b,), onPressed: (){
                                Appcubit.get(context).update_dataebase('Archived',Appcubit.get(context).Donetasks[index]['id'] );
                              }),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Container(
                            color: Appcubit.get(context).b,
                            height: 1,
                          )
                        ],
                      ),
                    ),
                    onDismissed: (direction){
                      Appcubit.get(context).delete_dataebase(Appcubit.get(context).Donetasks[index]['id']);
                    },
                  );
                },
                separatorBuilder:(context,index) => Container(
                  height: 10,
                ) ,
                itemCount: Appcubit.get(context).Donetasks.length),
            fallback: (context)=> Container(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu,size: 100,color: Appcubit.get(context).b),
                  Text('No Tasks Yet , Please Add Some Task',style: TextStyle(fontSize: 17,color: Appcubit.get(context).b,fontFamily: 'OpenSans'),),
                ],
              ),
            ),
          )
      ),
    );
  }
}

