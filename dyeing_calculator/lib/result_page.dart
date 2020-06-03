import 'package:dyeingcalculator/sample_page.dart';
import 'package:dyeingcalculator/variable_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int currentValue;
  int wantedValue;
  int Decolorization_value;
  int Complementary_value;
  int Technical_value;
  int result;
  int current_ColorLevel;
  int wanted_ColorLevel;
  int Value1;
  int Value2;
  int Final_Value;
  Color Final_Color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadInfo();
  }

  _loadInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentValue = (prefs.getInt('Current_Level') ??0);
      wantedValue = (prefs.getInt('Wanted_Level') ?? 0);
      Decolorization_value = (prefs.getInt('Decolorization_Value') ?? 0);
      Complementary_value = (prefs.getInt('Complementary_Value') ?? 0);
      Technical_value = (prefs.getInt('Technical_Value') ?? 0);
      current_ColorLevel = (prefs.getInt('Current_Color') ?? 0);
      wanted_ColorLevel = (prefs.getInt('Wanted_Color') ?? 0);
      Value1 = currentValue + current_ColorLevel;
      Value2 = wantedValue + wanted_ColorLevel;
    });
  }


  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    Final_Value = Value1 - Value2 - Decolorization_value - Complementary_value - Technical_value;
    if(Final_Value > -6){
      Final_Color = Colors.red;
    }else{
      Final_Color = Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('결과'),
      ),
      body: _buildBody(),
      floatingActionButton:
      Container(
        width: 320,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            /*RaisedButton(
              child: Text('이전'),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ThemeConsumer(child: VariablePage())));
              },
            ),*/
            RaisedButton(
              child: Text('샘플 테마'),
              onPressed: (){
                //_loadInfo();
                showDialog(context: context, builder: (_)=>ThemeConsumer(child: ThemeDialog(),));
              },
            ),
            RaisedButton(
              child: Text('다시하기'),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ThemeConsumer(child: SamplePage())));
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 180,
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    child: CircleAvatar(
                      backgroundColor: Final_Color,
                      child: Text('$Final_Value', style: TextStyle(fontSize: 80),),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    child: Text('보색 추가하기'),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ThemeConsumer(child: VariablePage())));
                    },
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _variables(){
    return Column(
      children: <Widget>[
        Container(
          child: Text(
              '최종값' + '$Final_Value'
          ),
        ),
        Container(
          child: Text(
              '현재값' + '$Value1'
          ),
        ),
        Container(
          child: Text(
              '타겟값' + '$Value2'
          ),
        ),
        Container(
          child: Text(
              '탈색값' + '$Decolorization_value'
          ),
        ),
        Container(
          child: Text(
              '보색값' + '$Complementary_value'
          ),
        ),
        Container(
          child: Text(
              '기술 값' + '$Technical_value'
          ),
        ),
      ],
    );
  }
}
