import 'package:dyeingcalculator/result_page.dart';
import 'package:dyeingcalculator/sample_page.dart';
import 'package:dyeingcalculator/sample_page_23.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:theme_provider/theme_provider.dart';

class VariablePage extends StatefulWidget {
  @override
  _VariablePageState createState() => _VariablePageState();
}

class _VariablePageState extends State<VariablePage> {
  var _wantedComplementPercent = 0;
  int currentLevel = 1;
  int wantedLevel = 1;
  int currentColorLevel = 1;
  int wantedColorLevel = 1;
  String currentColorName = '레드';
  String wantedColorName = '레드';
  String Complement_Color;
  int Complement_Level = 1;
  bool Decolorization = false;
  int Decolorization_value = 0;
  int Complementary_value = 0;
  int Technical_value = 0;
  Color _BoxColor = Colors.white;
  List<Color> _BoxColor_List = [];
  List _Decolorization_Percent = [];
  List<String> _ComplementaryColor_Name = [];
  List<String> _ComplementaryColor_Level = [];
  List<List<String>> _Complementary_PickList = [
    ['Lv1', 'Lv2', 'Lv3', 'Lv4', 'Lv5', 'Lv6', 'Lv7', 'Lv8', 'Lv9', 'Lv10', 'Lv11', 'Lv12', 'Lv13', 'Lv14'],
    ['블루', '그린'],
    ['10%','20%','30%','40%','50%','60%','70%','80%','90%','100%',]
  ];
  static List<String> _Initial_Data = ['Lv1', '그린', '10%'];

  int _lineCount = 0;
  List<int> _lineCountList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadInfo();
  }


  _loadInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentLevel = (prefs.getInt('Current_Level') ??0);
      wantedLevel = (prefs.getInt('Wanted_Level') ?? 0);
      currentColorLevel = (prefs.getInt('Current_Color') ?? 0);
      wantedColorLevel = (prefs.getInt('Wanted_Color') ?? 0);
      currentColorName = (prefs.getString('Current_ColorName') ?? 0);
      wantedColorName = (prefs.getString('Wanted_ColorName') ?? 0);
    });
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    Decolorization == true ? Decolorization_value = 5 : Decolorization_value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('변수1')
      ),
      body: _buildBody(),
      floatingActionButton:
      Container(
        width: 320,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              child: Text('이전'),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ThemeConsumer(child: SamplePage())));
              },
            ),
            /*RaisedButton(
              child: Text('리프레쉬'),
              onPressed: (){
                _loadInfo();
              },
            ),*/
            RaisedButton(
              child: Text('다음'),
              onPressed: (){
                _saveVariable();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ThemeConsumer(child: ResultPage())));
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 360,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all()
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          width: 80,
                            height: 50,
                            child: Text('보색', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          width: 80,
                          height: 50,
                          child: RaisedButton(
                            onPressed: _ComplementPercentDialog,
                            child: Text('$_wantedComplementPercent%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.black12)
                                ),
                                //borderRadius: BorderRadius.circular(10)
                            ),
                            width: 330,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('         ' + '탈색', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: 60,
                                    height: 50,
                                    child: Switch(
                                      value: Decolorization,
                                      onChanged: (value){
                                        setState(() {
                                          Decolorization = value;
                                          Decolorization == true ? Decolorization_value = 5 : Decolorization_value = 0;
                                        });
                                      },
                                    )
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                _Adding_Decolorization(),
              ],
            ),
          ),
          /*
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text(currentLevel.toString()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text(currentColorName),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text(currentColorLevel.toString()),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text(wantedLevel.toString()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text(wantedColorName),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text(wantedColorLevel.toString()),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text('$Decolorization_value'),
                  ),
                ),
              ],
            ),
          ),
          */
        ],
      ),
    );
  }

  Widget _Adding_Decolorization() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 64 * _lineCount.toDouble(),
            child: ListView.builder(
              itemCount: _lineCount,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: _BoxColor_List[index]
                                //border: Border.all(),
                                //borderRadius: BorderRadius.circular(10)
                            ),
                            width: 330,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment : Alignment.center,
                                    child: Text('         '+_ComplementaryColor_Level[index] + ' ' + _ComplementaryColor_Name[index] + ' ' + _Decolorization_Percent[index].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                                Container(
                                  width: 60,
                                  child: IconButton(
                                    icon: Icon(Icons.remove_circle_outline, color: Colors.red,size: 30,),
                                    onPressed: (){
                                      setState(() {
                                        _BoxColor_List.removeAt(index);
                                        _lineCount = _lineCount - 1;
                                        _lineCountList.removeAt(index);
                                        _ComplementaryColor_Level.removeAt(index);
                                        _ComplementaryColor_Name.removeAt(index);
                                        _Decolorization_Percent.removeAt(index);
                                      });
                                    },
                                  ),
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    child: Text('보색 추가하기'),
                    onPressed: (){
                      setState(() {
                        showPickerArray(context);
                      });
                    },
                  ),
                ),
                //SizedBox(width: 30,),
                /*Container(
                  width: 80,
                  height: 50,
                  child: DropdownButton<String>(
                    value: Complement_Color,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20, fontWeight: FontWeight.bold
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        Complement_Color = newValue;
                      });
                    },
                    items: <String>['블루', '그린']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }
                    ).toList(),
                  ),
                ),*/
                /*Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: 80,
                  height: 50,
                  child: RaisedButton(
                    onPressed: _ComplementPercentDialog,
                    child: Text('$_wantedComplementPercent%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ),*/
                /*Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  child: FloatingActionButton(
                    onPressed: (){
                      //_ComplementryColor_Name.add(Complement_Color.toString());//_Decolorization_Percent.add(_wantedComplementPercent.toString());
                      setState(() {
                        if(_ComplementaryColor_Level.length != _lineCountList.length){
                          _lineCount = _lineCount + 1;
                          _lineCountList.add(_lineCount);
                          _wantedComplementPercent = 0;
                          /*_ComplementaryColor_Level.add(_Initial_Data[0]);
                          _ComplementaryColor_Name.add(_Initial_Data[1]);
                          _Decolorization_Percent.add(_Initial_Data[2]);*/
                        }else{
                          _showAlertDialog(context);
                        }
                      });
                    },
                  ),
                )*/
              ],
            ),
          ),
        ),
      ],
    );
  }
  showPickerArray(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: _Complementary_PickList, isArray: true),
        confirmText: '확인',
        cancelText: '취소',
        columnPadding: EdgeInsets.all(16),
        itemExtent: 35,
        hideHeader: true,
        title: new Text("보색 설정 추가하기"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          setState(() {
            _lineCount = _lineCount + 1;
            _lineCountList.add(_lineCount);
            _wantedComplementPercent = 0;
            if(picker.getSelectedValues()[1] == '그린'){
              _BoxColor_List.add(Colors.green);
            }
            if(picker.getSelectedValues()[1] == '블루'){
              _BoxColor_List.add(Colors.blue);
            }
          });
          _ComplementaryColor_Level.add(picker.getSelectedValues()[0]);
          _ComplementaryColor_Name.add(picker.getSelectedValues()[1]);
          _Decolorization_Percent.add(picker.getSelectedValues()[2]);
        }
    ).showDialog(context);
  }


  void _showAlertDialog(BuildContext context) async{
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content: Text("보색을 설정해주세요."),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: (){
                  Navigator.pop(context, "OK");
                },
              )
            ],
          );
        }
    );
  }

  void _saveVariable() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('Decolorization_Value', Decolorization_value);
    prefs.setInt('Complementary_Value', Complementary_value);
    prefs.setInt('Technical_Value', Technical_value);
    /*prefs.setString('Current_ColorName', currentColorName);
    prefs.setString('Wanted_ColorName', wantedColorName);
    prefs.setInt('Current_Color', currentColorLevel);
    prefs.setInt('Wanted_Color', wantedColorLevel);
    prefs.setInt('Current_Level', currentLevel);
    prefs.setInt('Wanted_Level', wantedLevel);*/
  }

  void _ComplementPercentDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 0,
            maxValue: 100,
            step: 10,
            title: Text("보색"),
            initialIntegerValue: _wantedComplementPercent,
          );
        }
    ).then((onValue) {
      if (onValue != null) {
        setState(() => _wantedComplementPercent = onValue,
        );
      }
    });
  }

}
