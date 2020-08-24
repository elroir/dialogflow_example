import 'package:flutter/cupertino.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class DialogflowProvider{

  final String fileJson;

  DialogflowProvider({@required this.fileJson});

Future<QueryResult> response(query) async {
  AuthGoogle authGoogle = await AuthGoogle(
  fileJson: fileJson
  ).build();

  Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle, language: Language.spanishLatinAmerica,);
  AIResponse aiResponse = await dialogflow.detectIntent(query);
  return aiResponse.queryResult;

}

// Future bundle() async {
// var json = await rootBundle.loadString("assets/nlp-topicos-69f3af93ac35.json");
// return json;
//}

}
