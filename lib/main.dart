
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todolist/Bloc/cubit.dart';
import 'package:flutter_todolist/Bloc/cubitstates.dart';
import 'Modules/myHomePage.dart';

import 'bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Appcubit()..create_database(),
      child: BlocConsumer<Appcubit,Appstates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            theme: ThemeData(
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,

                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.dark

                  ),
                )
            ),
            darkTheme: ThemeData(

                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Color.fromRGBO(34, 34, 34 , 1),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,

                ),
                scaffoldBackgroundColor:Color.fromRGBO(34, 34, 34 , 1),
                appBarTheme: AppBarTheme(
                  elevation: 0.0,
                  backgroundColor: Color.fromRGBO(34, 34, 34 , 1),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor:Color.fromRGBO(34, 34, 34 , 1),
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.light
                  ),
                )
            ),
            themeMode: Appcubit.get(context).isswitch?ThemeMode.dark:ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: MyHomePage(),
          );
        },
      )
    );
  }
}


