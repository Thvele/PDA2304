import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'firebase_options.dart';

final storage = FirebaseStorage.instanceFor(bucket: 'gs://test-479c3.appspot.com');
final cloud = FirebaseFirestore.instance.collection('images');

List<imageDetails> imgUrl = <imageDetails>[];

class imageDetails {
  String? downloadPath;
  String? name;
  int? size;

  imageDetails(this.downloadPath, this.name, this.size);
}

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  storage.ref('images').listAll().then((snap) {
    for (var item in snap.items) {
      var tempDetails =  imageDetails("", "", -1); 
      item.getMetadata().then((img) {
        tempDetails.name = img.name;
        tempDetails.size = img.size;
      });
      item.getDownloadURL().then((img) {
        tempDetails.downloadPath = img;
      });

      imgUrl.add(tempDetails);
    }
  });

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Storage',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<QuerySnapshot> _images = cloud.snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _images,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height
              ),
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 5),
                children: List.generate(snapshot.data!.docs.length, (i) {
                  Map<String, dynamic> data = snapshot.data!.docs[i].data()! as Map<String, dynamic>;

                  return Material(
                    borderRadius: BorderRadius.circular(15),
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.black12,
                      child: InkWell(
                        onTap: () {
                            imageDetailsDialog(context, ((snapshot.data!.docs[i].id).toString() + (data['date']).toString() + data['name']), data['downloadURL'], data['size'], snapshot.data!.docs[i].id);
                        },
                        child: Image.network(data['downloadURL']),
                      ),
                    ),
                  );
                })
              ),
            );
          }
      
          if (snapshot.hasError) return Center(child: Text('Произошла ошибка \n${snapshot.error}', style: const TextStyle(color: Colors.red, fontSize: 60)));
      
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: Text('Загрузка...', style: TextStyle(color: Colors.green, fontSize: 60)));
      
          if(!snapshot.hasData) return const Center(child: Text("Нед данных!", style: TextStyle(color: Colors.red, fontSize: 60)));
      
          return const Center(child: Text("Нед данных!", style: TextStyle(color: Colors.red, fontSize: 60)));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try{
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'png', 'jpeg', 'gif']
            );

            if (result != null) {
              
              int timestamp = DateTime.now().millisecondsSinceEpoch;

              cloud.add({
                'name': result.files.first.name,
                'size': result.files.first.size,
                'downloadURL': "",
                'date': timestamp
              }).then((firestoreValue) async {
                await storage.ref('images/${firestoreValue.id + timestamp.toString() + result.files.first.name}').putData(result.files.first.bytes!).then((value){
                  storage.ref('images/${firestoreValue.id + timestamp.toString() + result.files.first.name}').getDownloadURL().then((url) {
                    cloud.doc(firestoreValue.id).set({
                      'name': result.files.first.name,
                      'size': result.files.first.size,
                      'downloadURL': url,
                      'date': timestamp
                    }).then((suc) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Успешно добавлено")));
                    }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка: $e")));
                    });
                  }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка: $e")));
                    });
                }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка: $e")));
                  });
              });
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка")));
            }
          }catch(e){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка: $e")));
          }
        },
        tooltip: 'Add image',
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> imageDetailsDialog(BuildContext context, String name, String downloadPath, int size, String id){
  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Подробнее'),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: window.physicalSize.width/5,
            maxHeight: window.physicalSize.height/5
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("id: $id"),
              const Text("Название: "),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(name),
              ),
              Text("Размер: ${(size/1048576).toStringAsFixed(2)} Мбайт"),
            ]
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
            child: const Text("Закрыть"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge),
            child: const Text("Удалить", style: TextStyle(color: Colors.red)),
            onPressed: () {
              storage.ref("images/$name").delete().then((value) {
                cloud.doc(id).delete().then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Успешно удалено")));
                  Navigator.of(context).pop();
                }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при удалении: $error")));
                Navigator.of(context).pop();
                });
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при удалении: $error")));
                Navigator.of(context).pop();
              });
            },
          ),
          TextButton(
            style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
            child: const Text("Скачать", style: TextStyle(color: Colors.green)),
            onPressed: () {
              launchUrl(Uri.parse(downloadPath));
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка началась")));
            },
          ),

        ],
      );
    }
  );
}