import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 40
  color: "transparent"

  ClippingWrapperRectangle {
    id: rectangle
    antialiasing: true
    anchors.fill: parent
    bottomLeftRadius: 10
    bottomRightRadius: 10
    color: "#fab387"
  }

  Text {
    id: clock
    anchors.centerIn: rectangle

    Process {
      // give the process object an id so we can talk
      // about it from the timer
      id: dateProc

      command: [ "date", "+%T | %A" ]
      running: true

      stdout: StdioCollector {
        onStreamFinished: clock.text = this.text
      }
    }

    // use a timer to rerun the process at an interval
    Timer {
      // 1000 milliseconds is 1 second
      interval: 1000

      // start the timer immediately
      running: true

      // run the timer again when it ends
      repeat: true

      // when the timer is triggered, set the running property of the
      // process to true, which reruns it if stopped.
      onTriggered: dateProc.running = true
    }
  }
}
