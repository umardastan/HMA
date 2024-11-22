class Variable {
  static const appName = 'HMA APP';
  static const harusDiisi = 'Harus Diisi';
  static const regexForValidationEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
}

class Url {
  static const base = 'darbe.hanatekindo.com';
}

class PathUrl {
  static const task = '/task/list-task-user/';
  static const login = '/login';
  static const dataDashboard = '/list-dashboard-v2';
  static const updateStatusTask = '/task/update-status-task';
  static const getUserById = '/list-user/';
  static const updateUser = '/update-user/';
  static const updatePassword = '/update-password/';
  static const dashboardPaket = '/my-paket-progres';
  static const taskList = '/task/list-task';
  static const users = '/list-user';
  static const listRole = '/list-role';
  static const listPaket = '/list-paket';
  static const createUser = '/create-user';
}

enum MessageType { success, error, warning, info }
