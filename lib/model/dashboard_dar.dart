class DashboardModel {
  int? year;
  int? paket;
  int? user;
  List<Run>? run;
  List<Idle>? idle;
  List<Task>? task;
  List<Activity>? activity;

  DashboardModel(
      {this.year,
      this.paket,
      this.user,
      this.run,
      this.idle,
      this.task,
      this.activity});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    paket = json['paket'];
    user = json['user'];
    if (json['run'] != null) {
      run = <Run>[];
      json['run'].forEach((v) {
        run!.add(Run.fromJson(v));
      });
    }
    if (json['idle'] != null) {
      idle = <Idle>[];
      json['idle'].forEach((v) {
        idle!.add(Idle.fromJson(v));
      });
    }
    if (json['task'] != null) {
      task = <Task>[];
      json['task'].forEach((v) {
        task!.add(Task.fromJson(v));
      });
    }
    if (json['activity'] != null) {
      activity = <Activity>[];
      json['activity'].forEach((v) {
        activity!.add(Activity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['paket'] = paket;
    data['user'] = user;
    if (run != null) {
      data['run'] = run!.map((v) => v.toJson()).toList();
    }
    if (idle != null) {
      data['idle'] = idle!.map((v) => v.toJson()).toList();
    }
    if (task != null) {
      data['task'] = task!.map((v) => v.toJson()).toList();
    }
    if (activity != null) {
      data['activity'] = activity!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  toString() => 'year: $year, paket: $paket, user: $user, activity: $activity';
}

class Run {
  int? id;
  String? username;
  int? number;

  Run({this.id, this.username, this.number});

  Run.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['number'] = number;
    return data;
  }
}

class Idle {
  int? id;
  String? username;

  Idle({this.id, this.username});

  Idle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    return data;
  }
}

class Task {
  int? proses;
  int? done;

  Task({this.proses, this.done});

  Task.fromJson(Map<String, dynamic> json) {
    proses = json['proses'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['proses'] = proses;
    data['done'] = done;
    return data;
  }

  @override
  toString() => "{proses: $proses, done: $done}";
}

class Activity {
  int? jan;
  int? feb;
  int? mar;
  int? apr;
  int? may;
  int? jun;
  int? jul;
  int? aug;
  int? sep;
  int? oct;
  int? nov;
  int? dec;

  Activity(
      {this.jan,
      this.feb,
      this.mar,
      this.apr,
      this.may,
      this.jun,
      this.jul,
      this.aug,
      this.sep,
      this.oct,
      this.nov,
      this.dec});

  Activity.fromJson(Map<String, dynamic> json) {
    jan = json['Jan'];
    feb = json['Feb'];
    mar = json['Mar'];
    apr = json['Apr'];
    may = json['May'];
    jun = json['Jun'];
    jul = json['Jul'];
    aug = json['Aug'];
    sep = json['Sep'];
    oct = json['Oct'];
    nov = json['Nov'];
    dec = json['Dec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Jan'] = jan;
    data['Feb'] = feb;
    data['Mar'] = mar;
    data['Apr'] = apr;
    data['May'] = may;
    data['Jun'] = jun;
    data['Jul'] = jul;
    data['Aug'] = aug;
    data['Sep'] = sep;
    data['Oct'] = oct;
    data['Nov'] = nov;
    data['Dec'] = dec;
    return data;
  }

  @override
  toString() => "{jan: $jan, feb: $feb}";
}
