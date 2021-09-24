import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:productivity_timer/productivity_button.dart';
import 'package:productivity_timer/settings.dart';
import 'package:productivity_timer/timer.dart';
import 'package:productivity_timer/timer_model.dart';

class TimerHome extends StatefulWidget {
  @override
  _TimerHomeState createState() => _TimerHomeState();
}

class _TimerHomeState extends State<TimerHome> {
  final CountDownTimer timer = CountDownTimer();

  void goToSettings(BuildContext context) {
    print('in gotoSettings');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Settings()));
  }

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();
    menuItems.add(
        PopupMenuItem(
          value: 'Settings',
          child: Text('Settings'),
        ));
    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: Text("Productivity Timer"),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              if(s=='Settings') {
                goToSettings(context);
              }
            },
          )
        ],
      ),
      body: LayoutBuilder(
          builder:(context,constrains){
            final double availableWidth = constrains.maxWidth;
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ProductivityButton(
                          text: "Work",
                          color: Color(0xff009688),
                          onPressed: () => timer.startWork(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ProductivityButton(
                          text: "Short Break",
                          color: Color(0xff607D8B),
                          onPressed: () => timer.startBreak(true),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ProductivityButton(
                          text: "Long Break",
                          color: Color(0xff455A64),
                          onPressed: () => timer.startBreak(false),
                        ),
                      ),
                    )
                  ],
                ),
                 StreamBuilder(
                     initialData: '00:00',
                     stream: timer.stream(),
                     builder: (context, snapshot) {
                       TimerModel timer = (snapshot.data == '00:00') ? TimerModel('00:00', 1) : snapshot.data;
                       return Expanded(
                           child: CircularPercentIndicator( radius: availableWidth / 2, lineWidth: 10.0,
                                 percent: timer.percent,
                                 center: Text( timer.time,
                                 style: Theme.of(context).textTheme.headline4),
                                 progressColor: Color(0xff009688),
                           ));
                     }),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ProductivityButton(
                          text: "Stop",
                          color: Color(0xff212121),
                          onPressed: () => timer.stopTimer(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ProductivityButton(
                          text: "Restart",
                          color: Color(0xff009688),
                          onPressed: () => timer.startTimer(),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }
      )
    );
  }
}
