

import 'dart:async';

class StreamsControl{

  /// stream used to control animation
  StreamController<void> _actionToggleController = StreamController();
  Function(void) get setActionToggle => _actionToggleController.sink.add;
  Stream get getActionToggle => _actionToggleController.stream;

  dispose(){
    _actionToggleController.close();
  }
}


class HiddenDrawerBloc {

  StreamsControl streamsControl = new StreamsControl();

  toggle(){
    streamsControl.setActionToggle('');
  }



  dispose(){
    streamsControl.dispose();
  }

}

