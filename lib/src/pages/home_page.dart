import 'package:flutter/material.dart';
import 'package:dialogflowexample/src/providers/provider.dart';
import 'package:dialogflowexample/src/widgets/mic_button_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProviderProvider>(context);

    String response = (provider.queryResult!=null) ? provider.queryResult.fulfillmentText : '';

    return Scaffold(
      body: Center(
        child:(Text(response)),
      ),
      floatingActionButton: MicWidget(provider: provider,),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
