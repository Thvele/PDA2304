import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_package_intro/operation.dart';
import 'package:new_package_intro/state/cubit/update_user_cubit.dart';
import 'package:new_package_intro/state/cubit/user_operations_cdu_cubit.dart';
import 'state/cubit/auth_cubit_cubit.dart';
import 'user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widget/locator_service.dart';
import 'state/cubit/get_user_data_cubit.dart';

String userName = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserOperationsCduCubit>(),
      child: BlocProvider(
        create: (context) => sl<GetUserDataCubit>(),
        child: BlocProvider(
          create: (context) => sl<AuthCubitCubit>(),
          child: BlocProvider(
            create: (context) => sl<UpdateUserCubit>(),
            child: MaterialApp(
              title: 'conduit api auth',
              theme: ThemeData(
                  primarySwatch: Colors.blue, brightness: Brightness.dark),
              routes: {
                '/signin': (context) => const MyHomePage(title: 'Авторизация'),
                '/signup': (context) => BlocProvider(
                      create: (context) => sl<AuthCubitCubit>(),
                      child: const Registration(),
                    ),
                '/profile': (context) => const Profile(
                      user: User(userName: ''),
                    ),
              },
              home: const MyHomePage(title: 'Авторизация'),
            ),
          ),
        ),
      ),
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
  @override
  Widget build(BuildContext context) {
    final TextEditingController login = TextEditingController();
    final TextEditingController password = TextEditingController();

    login.text = "testUser";
    password.text = "123456";

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: BlocConsumer<AuthCubitCubit, AuthCubitState>(
          listener: (context, state) {
            if (state is ErrorState) {
              login.text = state.message;
              password.text = "";
            } else if (state is SuccessState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            user: state.user,
                          )));
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 500,
                  height: 50,
                  child: TextFormField(
                    controller: login,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Логин"),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                SizedBox(
                  width: 500,
                  height: 50,
                  child: TextFormField(
                      controller: password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Пароль")),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 35)),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: Material(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () async {
                        try {
                          if (login.text.isEmpty || password.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Заполните все поля!")));
                          } else {
                            BlocProvider.of<AuthCubitCubit>(context).signIn(
                                User(
                                    userName: login.text,
                                    password: password.text));
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Неизвестная ошибка!")));
                        }
                      },
                      highlightColor: Colors.white.withOpacity(0.3),
                      splashColor: Colors.indigo.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text("Войти", textAlign: TextAlign.center)),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 35)),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: Material(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Registration()));
                      },
                      highlightColor: Colors.white.withOpacity(0.3),
                      splashColor: Colors.indigo.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                      child: const Align(
                          alignment: Alignment.center,
                          child:
                              Text("Регистрация", textAlign: TextAlign.center)),
                    ),
                  ),
                )
              ],
            );
          },
        )),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    int page = 1;
    TextEditingController search = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthCubitCubit, AuthCubitState>(
          builder: (context, state) {
            if (state is SuccessState) {
              return Center(
                  child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                          width: 500,
                          height: 50,
                          child: Text("Добро пожаловать!",
                              textAlign: TextAlign.center)),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: Material(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(5),
                          child: InkWell(
                            onTap: () async {
                              _editOrAddBuilder(
                                  context, 0, user, -1, "", "", "", "", "");
                            },
                            highlightColor: Colors.white.withOpacity(0.3),
                            splashColor: Colors.indigo.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text("Добавить опрерацию",
                                    textAlign: TextAlign.center)),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 5)),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: Material(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(5),
                          child: InkWell(
                            onTap: () async {
                              _editProfileBuilder(context, user);
                            },
                            highlightColor: Colors.white.withOpacity(0.3),
                            splashColor: Colors.indigo.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text("Редактировать профиль",
                                    textAlign: TextAlign.center)),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 5)),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: Material(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(5),
                          child: InkWell(
                            onTap: () async {
                              BlocProvider.of<AuthCubitCubit>(context).logOut();
                              BlocProvider.of<GetUserDataCubit>(context).logOut();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage(
                                          title: "Авторизация")));
                            },
                            highlightColor: Colors.white.withOpacity(0.3),
                            splashColor: Colors.indigo.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            child: const Align(
                                alignment: Alignment.center,
                                child:
                                    Text("Выход", textAlign: TextAlign.center)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<GetUserDataCubit, GetUserDataState>(
                      builder: (context, state) {
                    if (state is GUDInitialState) {
                      BlocProvider.of<GetUserDataCubit>(context)
                          .getUserOperations(user.token!, page, search.text);
                    }

                    if (state is GUDSuccessState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Row(
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      minWidth: 100,
                                      minHeight: 50,
                                      maxWidth: 800,
                                      maxHeight: 50),
                                  child: TextFormField(
                                    controller: search,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Поиск по наименованию"),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 5)),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      minWidth: 50,
                                      minHeight: 50,
                                      maxWidth: 100,
                                      maxHeight: 50),
                                  child: Material(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      onTap: () async {
                                        BlocProvider.of<GetUserDataCubit>(
                                                context)
                                            .getUserOperations(
                                                user.token!, page, search.text);
                                      },
                                      highlightColor:
                                          Colors.white.withOpacity(0.3),
                                      splashColor:
                                          Colors.indigo.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Icon(Icons.search),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: 200,
                                    minHeight: 200,
                                    maxWidth: 800,
                                    maxHeight: 800),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.all(8),
                                    itemCount: context
                                        .read<GetUserDataCubit>()
                                        .counter,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5),
                                          child: Material(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Row(
                                              children: [
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15)),
                                                Expanded(
                                                  child: Text(
                                                    (context
                                                            .read<
                                                                GetUserDataCubit>()
                                                            .operations)[index]
                                                        .toString(),
                                                    textAlign:
                                                        TextAlign.start,
                                                  ),
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 50)),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Material(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5),
                                                      child: InkWell(
                                                        child: const Icon(
                                                            Icons.edit),
                                                        onTap: () {
                                                          _editOrAddBuilder(
                                                              context,
                                                              1,
                                                              user,
                                                              int.parse((context.read<GetUserDataCubit>().operations)[index]
                                                                      .toString()
                                                                      .split(
                                                                          ": ")[1]
                                                                      .split(
                                                                          ":")[0]
                                                                      .split("Наименование")[
                                                                  0]),
                                                              (context.read<GetUserDataCubit>().operations)[index]
                                                                      .toString()
                                                                      .split(
                                                                          ": ")[2]
                                                                      .split(
                                                                          ":")[0]
                                                                      .split("Описание")[
                                                                  0],
                                                              (context.read<GetUserDataCubit>().operations)[index].toString().split(": ")[3].split(":")[0].split(
                                                                  "Тип")[0],
                                                              (context.read<GetUserDataCubit>().operations)[index].toString().split(": ")[4].split(":")[0].split(
                                                                  "Дата")[0],
                                                              (context
                                                                      .read<GetUserDataCubit>()
                                                                      .operations)[index]
                                                                  .toString()
                                                                  .split(": ")[5]
                                                                  .split(":")[0]
                                                                  .split("Сумма")[0],
                                                              (context.read<GetUserDataCubit>().operations)[index].toString().split(": ")[6]);
                                                        },
                                                      ),
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 5)),
                                                    Material(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5),
                                                      child: InkWell(
                                                        child: const Icon(
                                                            Icons.delete),
                                                        onTap: () {
                                                          _deleteDialogBuilder(
                                                              context,
                                                              0,
                                                              user,
                                                              int.parse((context
                                                                          .read<
                                                                              GetUserDataCubit>()
                                                                          .operations)[
                                                                      index]
                                                                  .toString()
                                                                  .split(
                                                                      ": ")[1]
                                                                  .split(
                                                                      "Н")[0]));
                                                        },
                                                      ),
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 5)),
                                                    Material(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5),
                                                      child: InkWell(
                                                        child: const Icon(Icons
                                                            .delete_forever),
                                                        onTap: () {
                                                          _deleteDialogBuilder(
                                                              context,
                                                              1,
                                                              user,
                                                              int.parse((context
                                                                          .read<
                                                                              GetUserDataCubit>()
                                                                          .operations)[
                                                                      index]
                                                                  .toString()
                                                                  .split(
                                                                      ": ")[1]
                                                                  .split(
                                                                      "Н")[0]));
                                                        },
                                                      ),
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 5)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ));
                                    }),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Material(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      onTap: () async {
                                        if (page > 1) {
                                          page--;
                                          BlocProvider.of<GetUserDataCubit>(
                                                  context)
                                              .getUserOperations(user.token!,
                                                  page, search.text);
                                        }
                                      },
                                      highlightColor:
                                          Colors.white.withOpacity(0.3),
                                      splashColor:
                                          Colors.indigo.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5),
                                      child: const Align(
                                          alignment: Alignment.center,
                                          child: Text("<",
                                              textAlign: TextAlign.center)),
                                    ),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 5)),
                                Text(
                                  page.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 5)),
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Material(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      onTap: () async {
                                        page++;
                                        BlocProvider.of<GetUserDataCubit>(
                                                context)
                                            .getUserOperations(
                                                user.token!, page, search.text);
                                      },
                                      highlightColor:
                                          Colors.white.withOpacity(0.3),
                                      splashColor:
                                          Colors.indigo.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5),
                                      child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(">",
                                              textAlign: TextAlign.center)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }

                    if (state is GUDErrorState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Row(
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      minWidth: 100,
                                      minHeight: 50,
                                      maxWidth: 800,
                                      maxHeight: 50),
                                  child: TextFormField(
                                    controller: search,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Поиск по наименованию"),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 5)),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      minWidth: 50,
                                      minHeight: 50,
                                      maxWidth: 100,
                                      maxHeight: 50),
                                  child: Material(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      onTap: () async {},
                                      highlightColor:
                                          Colors.white.withOpacity(0.3),
                                      splashColor:
                                          Colors.indigo.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Icon(Icons.search),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: 200,
                                    minHeight: 200,
                                    maxWidth: 800,
                                    maxHeight: 800),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.all(8),
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return Center(
                                          child: Container(
                                        width: 200,
                                        child: const Text(
                                          "Данных нет",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26,
                                          ),
                                        ),
                                      ));
                                    }),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Material(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      onTap: () async {
                                        if (page > 1) {
                                          page--;
                                          BlocProvider.of<GetUserDataCubit>(
                                                  context)
                                              .getUserOperations(user.token!,
                                                  page, search.text);
                                        }
                                      },
                                      highlightColor:
                                          Colors.white.withOpacity(0.3),
                                      splashColor:
                                          Colors.indigo.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5),
                                      child: const Align(
                                          alignment: Alignment.center,
                                          child: Text("<",
                                              textAlign: TextAlign.center)),
                                    ),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 5)),
                                Text(
                                  page.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 5)),
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Material(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      onTap: () async {
                                        page++;
                                        BlocProvider.of<GetUserDataCubit>(
                                                context)
                                            .getUserOperations(
                                                user.token!, page, search.text);
                                      },
                                      highlightColor:
                                          Colors.white.withOpacity(0.3),
                                      splashColor:
                                          Colors.indigo.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5),
                                      child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(">",
                                              textAlign: TextAlign.center)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }

                    return const Text("Список пуст!",
                        textAlign: TextAlign.center);
                  })
                ],
              ));
            }

            return const Center(child: Text("Ошибка"));
          },
        ),
      ),
    );
  }
}

Future<void> _editOrAddBuilder(
    BuildContext context,
    int interactionType,
    User user,
    int id,
    String name,
    String desc,
    String type,
    String date,
    String amount) {
  final TextEditingController oName = TextEditingController();
  final TextEditingController oDesc = TextEditingController();
  final TextEditingController oType = TextEditingController();
  final TextEditingController oDate = TextEditingController();
  final TextEditingController oAmount = TextEditingController();
  final TextEditingController error = TextEditingController();

  oName.text = name.trim();
  oDesc.text = desc.trim();
  oType.text = type.trim();
  oDate.text = date.trim();
  oAmount.text = amount.trim();

  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<UserOperationsCduCubit, UserOperationsCduState>(
          builder: (context, state) {
            if (interactionType == 0) {
              return AlertDialog(
                title: const Text("Добавление операции"),
                content: Column(children: [
                  TextFormField(
                    controller: oName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Наименование операции"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    controller: oDesc,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Описание операции"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    controller: oType,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Тип операции"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    controller: oDate,
                    decoration: const InputDecoration(
                        hintText: "01.01.1990",
                        border: OutlineInputBorder(),
                        labelText: "Дата"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    controller: oAmount,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Сумма"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextField(
                    enabled: false,
                    controller: error,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ]),
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
                      if (oName.text.isEmpty ||
                          oDesc.text.isEmpty ||
                          oType.text.isEmpty ||
                          oDate.text.isEmpty ||
                          oAmount.text.isEmpty) {
                        error.text = "Заполните все поля";
                      } else {
                        BlocProvider.of<UserOperationsCduCubit>(context)
                            .addOperation(
                                user,
                                Operation(
                                    operationID: -1,
                                    operationName: oName.text,
                                    operationDescription: oDesc.text,
                                    operationType: oType.text,
                                    operationDate: oDate.text,
                                    operationAmount: oAmount.text));

                        if (state is UOCDUSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Успешно добавлено!")));
                          Navigator.of(context).pop();
                        } else if (state is UOCDUErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Произошла ошибка при добавлении!")));
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Успешно добавлено!")));
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  )
                ],
              );
            } else {
              return AlertDialog(
                title: const Text("Изменение операции"),
                content: Column(children: [
                  TextFormField(
                    controller: oName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Наименование операции"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    controller: oDesc,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Описание операции"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    controller: oType,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Тип операции"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    controller: oDate,
                    decoration: const InputDecoration(
                        hintText: "01.01.1990",
                        border: OutlineInputBorder(),
                        labelText: "Дата"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    controller: oAmount,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Сумма"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextField(
                    enabled: false,
                    controller: error,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ]),
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
                      if (oName.text.isEmpty ||
                          oDesc.text.isEmpty ||
                          oType.text.isEmpty ||
                          oDate.text.isEmpty ||
                          oAmount.text.isEmpty) {
                        error.text = "Заполните все поля";
                      } else {
                        BlocProvider.of<UserOperationsCduCubit>(context)
                            .editOperation(
                                user,
                                id,
                                Operation(
                                    operationID: id,
                                    operationName: oName.text,
                                    operationDescription: oDesc.text,
                                    operationType: oType.text,
                                    operationDate: oDate.text,
                                    operationAmount: oAmount.text));

                        if (state is UOCDUSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Успешно изменено!")));
                          Navigator.of(context).pop();
                        } else if (state is UOCDUErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Произошла ошибка при изменении!")));
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Успешно изменено!")));
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  )
                ],
              );
            }
          },
        );
      });
}

Future<void> _deleteDialogBuilder(
    BuildContext context, int type, User user, int id) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        if (type == 0) {
          return BlocBuilder<UserOperationsCduCubit, UserOperationsCduState>(
            builder: (context, state) {
              return AlertDialog(
                title: const Text("Скрытие операции"),
                content: const Text(
                    "Данное действие скроет данную операцию, для восстановления этих данных придётся обратиться к администратору. Запомните или запишите данные перед скрытием. Вы уверены что хотите сделать это?"),
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
                      BlocProvider.of<UserOperationsCduCubit>(context)
                          .logicalDeleteOperation(user, id);

                      if (state is UOCDUSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Успешно скрыто!")));
                        Navigator.of(context).pop();
                      } else if (state is UOCDUErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Произошла ошибка при скрытии!")));
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Успешно скрыто!")));
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        } else {
          return BlocBuilder<UserOperationsCduCubit, UserOperationsCduState>(
            builder: (context, state) {
              return AlertDialog(
                title: const Text("Полное удаление операции"),
                content: const Text(
                    "Данное действие полностью удалить операцию из системы, вы уверены что хотите сделать это?"),
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
                      BlocProvider.of<UserOperationsCduCubit>(context)
                          .deleteOperation(user, id);

                      if (state is UOCDUSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Успешно удалено!")));
                        Navigator.of(context).pop();
                      } else if (state is UOCDUErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Произошла ошибка при удалении!")));
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Успешно удалено!")));
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        }
      });
}

Future<void> _editProfileBuilder(BuildContext context, User user) {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController error = TextEditingController();

  username.text = user.userName;
  email.text = user.email!;

  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<UpdateUserCubit, UpdateUserState>(
          builder: (context, state) {
            return AlertDialog(
              title: const Text("Изменение профиля"),
              content: Column(children: [
                TextFormField(
                  controller: username,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Псевдоним"),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Почта"),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextField(
                  enabled: false,
                  controller: error,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ]),
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
                    if (username.text.isEmpty || email.text.isEmpty) {
                      error.text = "Заполните все поля";
                    } else {
                      BlocProvider.of<UpdateUserCubit>(context).updateProfile(
                          User(userName: username.text, email: email.text),
                          user.token!);

                      if (state is UpdateUserSuccess) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Успешно изменено")));
                      } else if (state is UpdateUserError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Произошла ошибка при изменении!")));
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Успешно изменено")));
                      }
                    }
                  },
                )
              ],
            );
          },
        );
      });
}

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController login = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController email = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<AuthCubitCubit, AuthCubitState>(
            listener: (context, state) {
              if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message.toString())));
              }
              if (state is SuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Успешная регистрация!")));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(user: state.user)));
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                      width: 500,
                      height: 50,
                      child: Text("Регистрация", textAlign: TextAlign.center)),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: TextFormField(
                      controller: login,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Логин"),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: TextFormField(
                        controller: password,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Пароль")),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Почта")),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 35)),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: Material(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () async {
                          try {
                            context.read<AuthCubitCubit>().signUp(User(
                                userName: login.text,
                                password: password.text,
                                email: email.text));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Ошибка регистрации!\n${e.toString()}")));
                          }
                        },
                        highlightColor: Colors.white.withOpacity(0.3),
                        splashColor: Colors.indigo.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                        child: const Align(
                            alignment: Alignment.center,
                            child: Text("Зарегестрироваться",
                                textAlign: TextAlign.center)),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: Material(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyHomePage(title: "Авторизация")));
                        },
                        highlightColor: Colors.white.withOpacity(0.3),
                        splashColor: Colors.indigo.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                        child: const Align(
                            alignment: Alignment.center,
                            child: Text("Назад", textAlign: TextAlign.center)),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
