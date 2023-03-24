import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Firestore',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Firestore'),
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<QuerySnapshot> _users = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _users,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Center(child: Text('Произошла ошибка \n${snapshot.error}', style: TextStyle(color: Colors.red, fontSize: 60)));

          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: Text('Загрузка...', style: TextStyle(color: Colors.green, fontSize: 80)));

          return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Material(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(right: 15, top: 10)),
                            Expanded(child: Text("UID: ${document.id}\n Почта: ${data['email']}\n Пароль: ${data['password']}", textAlign:TextAlign.start, style: const TextStyle(color: Colors.white),)),
                            const Padding(padding: EdgeInsets.only(right: 50)),
                            Material(
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                child: const Icon(Icons.edit),
                                onTap:() {
                                  _editDialog(context, document.id, data['email'], data['password']);
                                },
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(right: 5)),
                            Material(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                              child: InkWell(
                                child: const Icon(Icons.delete),
                                onTap:() {
                                  _deleteDialog(context, document.id);
                                },
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 25)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _addDialog(context);
        }),
    );
  }
}

Future<void> _addDialog(BuildContext context) {

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final user = FirebaseFirestore.instance.collection('users');

  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Добавление"),
        content: Column(
          children: [
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
                labelText: "Почта"),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              TextFormField(
                controller: pass,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Пароль"),
              )]),
            actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge),
                    child: const Text("Отмена"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge),
                    child: const Text("Подтвердить"),
                    onPressed: () {
                      if(email.text.isNotEmpty && pass.text.isNotEmpty){
                        
                        user.add({
                          'email': email.text,
                          'password': pass.text
                        }).then((value) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Успешно добавлено")));
                        }).catchError((error) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка: + $error")));
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Заполните все поля")));
                      }
                    },
                  )
                ],
      );
    }
  );
}

Future<void> _editDialog(BuildContext context, String uid, String e, String p) {

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final user = FirebaseFirestore.instance.collection('users');

  email.text = e;
  pass.text = p;

  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Изменение"),
        content: Column(
          children: [
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
                labelText: "Почта"),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              TextFormField(
                controller: pass,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Пароль"),
              )]),
              actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge),
                    child: const Text("Отмена"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge),
                    child: const Text("Подтвердить"),
                    onPressed: () {
                      if(email.text.isNotEmpty && pass.text.isNotEmpty){
                        user.doc(uid).set({
                          'email': email.text,
                          'password': pass.text
                        }).then((value) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Успешно изменено")));
                        }).catchError((error) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка: + $error")));
                        });
                      } else if(email.text.isEmpty && pass.text.isNotEmpty){
                        user.doc(uid).set({
                          'password': pass.text
                        }).then((value) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Пароль изменён")));
                        }).catchError((error) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка: + $error")));
                        });
                      } else if(email.text.isNotEmpty && pass.text.isEmpty){
                        user.doc(uid).set({
                          'email': email.text
                        }).then((value) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Почта изменена")));
                        }).catchError((error) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка: + $error")));
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Заполните хотябы одно поле")));
                      }
                    },
                  )
                ],
      );
    }
  );
}

Future<void> _deleteDialog(BuildContext context, String uid) {
  final user = FirebaseFirestore.instance.collection('users');

  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Удаление"),
        content: Column(
          children: [
              const Text("Вы уверены что хотите удалить?")]),
              actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge),
                    child: const Text("Отмена"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge),
                    child: const Text("Подтвердить"),
                    onPressed: () {
                      user.doc(uid).delete().then((value) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Успешно удалено")));
                        }).catchError((error) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка: + $error")));
                        });
                    },
                  )
                ],
      );
    }
  );
}