import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class TestingPage extends StatefulWidget {
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {

  List<List<String>> _Complementary_PickList = [
    ['Lv1', 'Lv2', 'Lv3', 'Lv4', 'Lv5', 'Lv6', 'Lv7', 'Lv8', 'Lv9', 'Lv10', 'Lv11', 'Lv12', 'Lv13', 'Lv14'],
    ['블루', '그린'],
    ['10%','20%','30%','40%','50%','60%','70%','80%','90%','100%',]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 100,),
          Container(
            child: RaisedButton(
              child: Text('ㅂㄷㅈㄱㅂ'),
              onPressed: (){
                setState(() {
                  showPickerArray(context);
                });
              },
            ),
          )
        ],
      ),
    );
  }
  showPickerArray(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: _Complementary_PickList, isArray: true),
        hideHeader: true,
        title: new Text("보색 설정"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
        }
    ).showDialog(context);
  }

}
