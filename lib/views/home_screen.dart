import 'dart:convert';

import 'package:api/model/api_model.dart';
import 'package:api/utils/exports.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Api_model> apiList = [];

Future<List<Api_model>> getApiList() async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map i in data) {
      apiList.add(Api_model.fromJson(i));
    }
    return apiList;
  } else {
    return apiList;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Example"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getApiList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  } else {
                    return ListView.builder(
                        itemCount: apiList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  child: Text(apiList[index].id.toString()),
                                ),
                                Text(
                                  apiList[index].title.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  apiList[index].body.toString(),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
