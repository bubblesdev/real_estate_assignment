import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class BottomTabItem {
  BottomTabItem({
    this.stateMachine = "",
    this.artboard = "",
    this.status,
  });

  UniqueKey? id = UniqueKey();
  String stateMachine;
  String artboard;
  late SMIBool? status;

  static List<BottomTabItem> tabItemsList = [
    BottomTabItem(stateMachine: "SEARCH_Interactivity", artboard: "SEARCH"),
    BottomTabItem(stateMachine: "CHAT_Interactivity", artboard: "CHAT"),
    BottomTabItem(stateMachine: "HOME_interactivity", artboard: "HOME"),
    BottomTabItem(stateMachine: "BELL_Interactivity", artboard: "BELL"),
    BottomTabItem(stateMachine: "USER_Interactivity", artboard: "USER"),
  ];
}
