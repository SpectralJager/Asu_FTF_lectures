import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smct/gameselect/gameselect.dart';

part 'gamemodel.dart';
part 'gameview.dart';
part 'gamestate.dart';
part 'gameevent.dart';
part 'gamebloc.dart';
part 'gamepage.dart';

enum Mode {
  Summation,
  Subtraction,
  Multiplication,
  Division,
}
