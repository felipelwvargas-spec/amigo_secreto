import 'package:http/http.dart';

void main() {
  requestData();
}
requestData() {
  String url =
      "https://gist.githubusercontent.com/felipelwvargas-spec/b49d630bd597c03ed8b9b90d498e7f5a/raw/1c7f0619d6efe6f24506d2402bdab1c1ca936c4c/accounts.json";
  Future<Response> futureResponse = get(Uri.parse(url));

  futureResponse.then((Response response) {
  print(response.body);    
  },);
}
