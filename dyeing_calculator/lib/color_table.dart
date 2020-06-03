import 'package:flutter/material.dart';

class ColorTable extends StatefulWidget {
  ColorTable({
    @required this.pickerColor,
    @required this.pickerLevel,
    @required this.onColorChanged,
    @required this.onActualLevelChanged,
    @required this.onLevelChanged,
    @required this.onColorLevelChanged,
    @required this.onColorNameChanged
  });

  final Color pickerColor;
  final int pickerLevel;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<int> onActualLevelChanged;
  final ValueChanged<int> onColorLevelChanged;
  final ValueChanged<int> onLevelChanged;
  final ValueChanged<String> onColorNameChanged;

  @override
  _ColorTableState createState() => _ColorTableState();
}

class _ColorTableState extends State<ColorTable> {
  var _levelName = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14'];
  var _Actual_Level = [1,2,3,4,5,6,7,8,9,10,11,12,13,14];
  static List<int> _level = [14,13,12,11,10,9,8,7,6,5,4,3,2,1];
  //['14', '13', '12', '11', '10', '9', '8', '7', '6', '5', '4', '3', '2', '1'];
  final _Colors = [Colors.red, Colors.green, Colors.yellow, Colors.blue, Colors.orange, Colors.purple, Colors.brown];
  final _ColorsNameList = ['레드', '그린', '옐로우', '블루', '오렌지', '퍼플', '브라운'];
  final List<int> _ColorLevelList = [10, 0, 0, 0, 7, 0, 0];
  final List<List<Color>> _Colors_List = [_Red_Colors, _Green_Colors, _Yellow_Colors, _Blue_Colors, _Orange_Colors, _Purple_Colors, _Brown_Colors];
  static List<Color> _Yellow_Colors = [Colors.yellow[50], Colors.yellow[100],Colors.yellow[200],Colors.yellow[300],Colors.yellow[400],Colors.yellow[500],Colors.yellow[600],Colors.yellow[700],Colors.yellow[800],Colors.yellow[900],];
  static List<Color> _Blue_Colors = [Colors.blue[50], Colors.blue[100],Colors.blue[200],Colors.blue[300],Colors.blue[400],Colors.blue[500],Colors.blue[600],Colors.blue[700],Colors.blue[800],Colors.blue[900],];
  static List<Color> _Orange_Colors = [Colors.orange[50], Colors.orange[100],Colors.orange[200],Colors.orange[300],Colors.orange[400],Colors.orange[500],Colors.orange[600],Colors.orange[700],Colors.orange[800],Colors.orange[900],];
  static List<Color> _Purple_Colors = [Colors.purple[50], Colors.purple[100],Colors.purple[200],Colors.purple[300],Colors.purple[400],Colors.purple[500],Colors.purple[600],Colors.purple[700],Colors.purple[800],Colors.purple[900],];
  static List<Color> _Brown_Colors = [Colors.brown[50], Colors.brown[100],Colors.brown[200],Colors.brown[300],Colors.brown[400],Colors.brown[500],Colors.brown[600],Colors.brown[700],Colors.brown[800],Colors.brown[900],];
  static List<Color> _Red_Colors = [Colors.red[50], Colors.red[100],Colors.red[200],Colors.red[300],Colors.red[400],Colors.red[500],Colors.red[600],Colors.red[700],Colors.red[800],Colors.red[900],];
  static List<Color> _Green_Colors = [Colors.green[50], Colors.green[100],Colors.green[200],Colors.green[300],Colors.green[400],Colors.green[500],Colors.green[600],Colors.green[700],Colors.green[800],Colors.green[900],];
  static List<Color> _White_Colors = [];
  static List _color = _White_Colors;
  var _actual_level = 1;
  var _SelectedColorName = '레드';
  int _ColorLevel;
  Color _selectedColor;
  Color _selectedShadow;
  int _Level = 14;


  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all()
        ),
        width: 350,
        height: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _colorList(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: _pickedColorList(),
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _colorList(){
    return Container(
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.grey[300], width: 1.0)),
      ),
      width: 60,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _Colors.length,
          itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _Level = _level[index];
                  _color = _Colors_List[index];
                  _ColorLevel = _ColorLevelList[index];
                  _selectedShadow = _Colors[index];
                  _SelectedColorName = _ColorsNameList[index];
                });
              },
              child: Align(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      boxShadow:
                      [_selectedShadow == _Colors[index] ?
                        BoxShadow(
                          color: _Colors[index],
                          blurRadius: 15
                        ):
                      BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 15
                      )
                      ],
                      color: _Colors[index],
                      borderRadius: BorderRadius.circular(60.0),
                    //border: Border.all(color: Theme.of(context).cardColor, width: 4)
                  ),
                ),
              ),
            ),
          );
          }),
    );
  }

  Widget _pickedColorList(){
    return ListView.builder(
        itemCount: _color.length,
        itemBuilder: (context, index){
          return
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10.0,0,10.0),
              child: InkWell(
                onTap: (){
                  setState(() {
                    _selectedColor = _color[index];
                    _actual_level = _Actual_Level[index];
                    _Level = _level[index];
                    widget.onColorChanged(_selectedColor);
                    widget.onActualLevelChanged(_actual_level);
                    widget.onColorLevelChanged(_ColorLevel);
                    widget.onColorNameChanged(_SelectedColorName);
                    widget.onLevelChanged(_Level);
                  });
                },
                child: Align(
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      boxShadow:
                      [_selectedColor == _color[index] ?
                      BoxShadow(
                          color: _color[index],
                          blurRadius: 15
                      ):
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 15
                      )
                      ],
                      color: _color[index],
                      //border:Border.all()
                    ),
                    width: 250,
                    height: 50,
                    child: Text('Lv ' + _levelName[index], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            );
        });
  }
}


