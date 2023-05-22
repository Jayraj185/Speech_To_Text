/// answer : "Flutter is an open-source mobile app development framework developed by Google in 2017. It allows developers to create high-quality, high-performance mobile apps for both Android and iOS platforms using a single codebase. Flutter uses a reactive programming model to build user interfaces, which makes it easy to build customizable widgets and visually appealing interfaces. Additionally, Flutter incorporates various features and tools, including hot reload, widget library, a rich set of customizable widgets, and platform-specific APIs to enable developers to build apps with native-like performance. Flutter has gained popularity because it enables developers to build beautiful, fast, and high-performance mobile apps with reduced development time and effort."

class HomeModel {
  HomeModel({
      String? answer,}){
    _answer = answer;
}

  HomeModel.fromJson(dynamic json) {
    _answer = json['answer'];
  }
  String? _answer;
HomeModel copyWith({  String? answer,
}) => HomeModel(  answer: answer ?? _answer,
);
  String? get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer'] = _answer;
    return map;
  }

}