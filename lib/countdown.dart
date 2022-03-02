import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:studytimer/components/dot.dart';

import 'utils/constant.dart';

enum FlowType { work, pause }

class CountDownTimerPage extends StatefulWidget {
  const CountDownTimerPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<CountDownTimerPage> {
  late final StopWatchTimer _stopWatchTimer;

  int nFlow = 0;
  int nPause = 0;
  FlowType flowType = FlowType.work;
  bool isWorkStarted = false;

  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      onEnded: onEnded,
    );
    _stopWatchTimer.setPresetSecondTime(kWorkTime);
    super.initState();
  }

  void resetFlow() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    setState(() {
      nFlow = 0;
      nPause = 0;
      flowType = FlowType.work;
      _stopWatchTimer.clearPresetTime();
      _stopWatchTimer.setPresetSecondTime(kWorkTime);
    });
  }

  void playPauseTimer() {
    if (_stopWatchTimer.isRunning) {
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    } else {
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    }
    setState(() {});
  }

  void onEnded() {
    print("I ended!");
    int time;

    switch (flowType) {
      case FlowType.work:
        setState(() {
          nFlow++;
          flowType = FlowType.pause;
          isWorkStarted = false;
        });
        time = kPauseTime;
        break;
      case FlowType.pause:
        setState(() {
          nPause++;
          flowType = FlowType.work;
        });
        time = kWorkTime;
        break;
    }

    _stopWatchTimer.clearPresetTime();
    _stopWatchTimer.setPresetSecondTime(time);
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                final displayTime = StopWatchTimer.getDisplayTime(
                  value,
                  hours: false,
                  milliSecond: false,
                );

                if (!isWorkStarted &&
                    value != 0 &&
                    value < kWorkTime * 1000 &&
                    flowType == FlowType.work) {
                  isWorkStarted = true;
                }

                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: resetFlow,
                          icon: const Icon(Icons.replay_rounded),
                        ),
                      ],
                    ),
                    Text(flowType.toString()),
                    Text(
                      displayTime,
                      style: const TextStyle(
                          fontSize: 64, fontWeight: FontWeight.normal),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 1; i <= 4; i++)
                          if (i <= nFlow)
                            const Dot(status: DotStatus.end)
                          else if (i > nFlow + 1 || nPause != nFlow)
                            const Dot(status: DotStatus.empty)
                          else if (nPause == nFlow &&
                              flowType == FlowType.work &&
                              isWorkStarted)
                            const Dot(status: DotStatus.active)
                          else
                            const Dot(status: DotStatus.empty)
                      ],
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 16),

            IconButton(
              onPressed: playPauseTimer,
              alignment: Alignment.center,
              iconSize: 48,
              icon: Icon(
                _stopWatchTimer.isRunning
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
