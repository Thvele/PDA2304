import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Registration extends StatefulWidget{
  const Registration({super.key});

  @override
  State<Registration> createState() => RegistrationState();
}

class RegistrationState extends State<Registration>{

  final loginEditingController =  TextEditingController();
  final passwordEditingController = TextEditingController();
  final surnameEditingController = TextEditingController();
  final nameEditingController = TextEditingController();
  final middlenameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey,
          alignment: Alignment.center,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                width: 350,
                height: 100,
                child: TextField(
                controller: loginEditingController,
                maxLength: 100,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Логин'
                )
              ),),

              SizedBox(
                width: 350,
                height: 100,
                child: TextField(
                controller: passwordEditingController,
                maxLength: 100,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Пароль'
                )
              ),),

              SizedBox(
                width: 350,
                child: Row(children: [
              SizedBox(
                width: 125,
                height: 100,
                child: TextField(
                controller: surnameEditingController,
                maxLength: 100,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Фамилия'
                )
              ),),

              const Padding(padding: EdgeInsets.only(left: 3)),

              SizedBox(
                width: 94,
                height: 100,
                child: TextField(
                controller: nameEditingController,
                maxLength: 100,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Имя'
                )
              ),),

              const Padding(padding: EdgeInsets.only(left: 3)),

              SizedBox(
                width: 125,
                height: 100,
                child: TextField(
                controller: middlenameEditingController,
                maxLength: 100,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Отчество'
                )
              ),),
              ],),),

              SizedBox(
                width: 350,
                height: 100,
                child: TextField(
                controller: emailEditingController,
                maxLength: 100,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Почта'
                )
              ),),

              const Padding(padding: EdgeInsets.only(top: 15)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        height: 50,
                        child: const Text('Регистрация',
                          style: TextStyle(
                            color: Colors.black,
                          ),),
                      ),),
                  ),

              const Padding(padding: EdgeInsets.only(left: 5)),

                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 75,
                        height: 50,
                        child: const Text('Назад',
                          style: TextStyle(
                            color: Colors.black,
                          ),),
                      ),),
                  ),
                ],
              )
            ],
          ),)
      )
    );
  }
}