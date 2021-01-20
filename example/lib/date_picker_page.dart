import 'dart:math';

import 'package:example/demo/pic_help.dart';
import 'package:example/widget/my_app_bar.dart';
import 'package:example/widget/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/more_pickers/init_data.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';

class DatePickerPage extends StatefulWidget {
  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  String stateText = '';

  final divider = Divider(height: 1, indent: 20);
  final rightIcon = Icon(Icons.keyboard_arrow_right);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '测试demo'),
      body: ListView(
        children: [
//          MyText(stateText ?? '内容'),
//          RaisedButton(onPressed: () => show(context, 'yyyyMMdd', '20201112'), child: MyText('text')),
//          Container(
//            height: 200,
//            color: Colors.grey[200],
//            child: CupertinoTimerPicker(
//                initialTimerDuration: Duration(hours: 23, minutes: 3, seconds: 56),
//                onTimerDurationChanged: (Duration duration) {}),
//          ),
//          Divider(),
//          Container(
//            height: 200,
//            color: Colors.grey[200],
//            child: CupertinoDatePicker(
//              initialDateTime: DateTime(2020,3),
//              onDateTimeChanged: (data) {
//                print('longer >>> $data');
//              },
//            ),
//          ),

          // Container(height: _height, child: picker()),

          _item('测试选择器', PickerDataType.sex, 'selectSex'),
          Container(height: _height, child: picker())
        ],
      ),
    );
  }

  ////////////////////////start
  var date1 = [1, 2, 3];
  var date2 = ['aa', 'aaaa', 'aaaaa'];
  var date3 = ['哈哈哈', '是是是', '水电费'];
  double _height = 300;

  FixedExtentScrollController scrollController1, scrollController2, scrollController3;

  @override
  void initState() {
    super.initState();
    scrollController1 = FixedExtentScrollController(initialItem: 0);
    scrollController2 = FixedExtentScrollController(initialItem: 0);
    scrollController3 = FixedExtentScrollController(initialItem: 0);
  }

  Widget picker() {
    return Row(
      children: <Widget>[
        Expanded(
          child: CupertinoPicker.builder(
            scrollController: scrollController1,
            itemExtent: 40,
            onSelectedItemChanged: (int selectIndex) => _setPicker1(selectIndex),
            childCount: date1.length,
            itemBuilder: (_, index) {
              return Align(alignment: Alignment.center, child: Text(date1[index].toString()));
            },
          ),
        ),
        Expanded(
          child: CupertinoPicker.builder(
            scrollController: scrollController2,
            itemExtent: 40,
            onSelectedItemChanged: (int selectIndex) => _setPicker2(selectIndex),
            childCount: date2.length,
            itemBuilder: (_, index) {
              return Align(alignment: Alignment.center, child: Text(date2[index].toString()));
            },
          ),
        ),
        Expanded(
          child: CupertinoPicker.builder(
            scrollController: scrollController3,
            itemExtent: 40,
            onSelectedItemChanged: (int selectIndex) {},
            childCount: date3.length,
            itemBuilder: (_, index) {
              return Align(alignment: Alignment.center, child: Text(date3[index].toString()));
            },
          ),
        )
      ],
    );
  }

  void _setPicker1(int selectIndex) {
    if (selectIndex % 2 == 0) {
      setState(() {
        date2.clear();
        date2.addAll(['new', 'longer']);
        scrollController2.animateToItem(1, duration: Duration(seconds: 1),curve: Curves.bounceOut);
//        scrollController2.jumpToItem(1);
        _height = 300.0 + Random().nextDouble() / 100000000;
      });
    } else {
      setState(() {
        date2.clear();
        date2.addAll(['xxx']);
        scrollController2.animateToItem(0, duration: Duration(seconds: 1),curve: Curves.bounceOut);
//        scrollController2.jumpToItem(0);
        _height = 300.0 + Random().nextDouble() / 100000000;
      });
    }
  }

  void _setPicker2(int selectIndex) {
    print('触发了picker2的change()');
    if (selectIndex % 2 == 0) {
      setState(() {
        date3.add('add');
        _height = 300.0 + Random().nextDouble() / 100000000;
      });
    } else {
      setState(() {
        date3.removeLast();
        _height = 300.0 + Random().nextDouble() / 100000000;
      });
    }
  }

  ////////////////////////end

  void show(context, timeFormat, dateParam) {
    PickHelper.openDateTimePicker(
      context,
      maxValue: DateTime.now().add(Duration(days: 999)),
      minValue: DateTime.now(),
      onConfirm: (_, __) {},
    );
  }

  Widget _item(title, var data, var selectData, {String label}) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: ListTile(
            title: Text(title),
            onTap: () => _onClickItem(),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              MyText(selectData.toString() ?? '暂无', color: Colors.grey, rightpadding: 18),
              rightIcon
            ]),
          ),
        ),
        divider,
      ],
    );
  }

  void _onClickItem() {
    Pickers.showDatePicker(
      context,
      mode: DateMode.YMDHMS,
      suffix: Suffix.normal(),
      showTitleBar: true,
      onConfirm: (p) {
        print('longer >>> 返回数据：$p');
      },
      onChanged: (p) {
//        print(p);
      },
    );
  }
}
