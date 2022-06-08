import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smct/game/game.dart';
import 'package:smct/widgets/widgets.dart';

part 'gameselectview.dart';
part 'gameselectstate.dart';
part 'gameselectbloc.dart';

enum OfflineType { Timer, Survive, Endurance }
