abstract class DataBaseRequest{
  /// Таблица Роли
  ///
  /// Поля таблицы: Название роли
  static const String tableRole = 'Role';

  /// Таблица Пользователи
  ///
  /// Поля таблицы: Логин, Пароль, Роль
  static const String tableUsers = 'Users';

  static const List<String> tableList = [
    tableRole,
    tableUsers
  ];
  static const List<String> tableCreateList = [
    _createTableRole,
    _createTableUsers
  ];

  static const String _createTableRole =
      'CREATE TABLE "$tableRole" ("id" INTEGER,"role" TEXT NOT NULL UNIQUE, PRIMARY KEY("id" AUTOINCREMENT))';

  /// Запрос для создания таблицы Users
  static const String _createTableUsers =
      'CREATE TABLE "$tableUsers" ("id" INTEGER,"login" TEXT NOT NULL UNIQUE,"password" TEXT NOT NULL,"id_role" INTEGER,FOREIGN KEY("id_role") REFERENCES "Role"("id"),PRIMARY KEY("id"))';
}