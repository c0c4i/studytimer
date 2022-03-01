import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CountDownTimerPage extends StatefulWidget {
  const CountDownTimerPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<CountDownTimerPage> {

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(15),
  );

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// Display stop watch time
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snap) {
                final value = snap.data!;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: false, milliSecond: false, );
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),

            /// Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                onPrimary: Colors.white,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                _stopWatchTimer.onExecute
                    .add(StopWatchExecute.start);
              },
              child: const Text(
                'Start',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                _stopWatchTimer.onExecute
                    .add(StopWatchExecute.stop);
              },
              child: const Text(
                'Stop',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                _stopWatchTimer.onExecute
                    .add(StopWatchExecute.reset);
              },
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}