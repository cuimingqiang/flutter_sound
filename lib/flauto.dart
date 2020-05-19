/*
 * This file is part of Flutter-Sound (Flauto).
 *
 *   Flutter-Sound (Flauto) is free software: you can redistribute it and/or modify
 *   it under the terms of the Lesser GNU General Public License
 *   version 3 (LGPL3) as published by the Free Software Foundation.
 *
 *   Flutter-Sound (Flauto) is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the Lesser GNU General Public License
 *   along with Flutter-Sound (Flauto).  If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:io' show Platform;
import 'dart:typed_data' show Uint8List;

import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/track_player.dart';
import 'package:flutter_sound/flutter_sound_recorder.dart';
import 'package:flutter_sound/flutter_sound_player.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

// this enum MUST be synchronized with fluttersound/AudioInterface.java  and ios/Classes/FlutterSoundPlugin.h
enum t_CODEC {
  DEFAULT,
  CODEC_AAC,
  CODEC_OPUS,
  CODEC_CAF_OPUS, // Apple encapsulates its bits in its own special envelope : .caf instead of a regular ogg/opus (.opus). This is completely stupid, this is Apple.
  CODEC_MP3,
  CODEC_VORBIS,
  CODEC_PCM,
}


/// This class is deprecated. It is just to keep backward compatibility.
/// New users must use the class TrackPlayer
@deprecated
class Flauto extends FlutterSound {
  Flauto() {
    initializeMediaPlayer();
  }

  void initializeMediaPlayer() async {
    if (soundPlayer == null) soundPlayer = TrackPlayer();
    if (soundRecorder == null) soundRecorder = FlutterSoundRecorder();
    await soundPlayer.initialize();
    await soundRecorder.initialize();
  }

  Future<String> startPlayerFromTrack(
    Track track, {
    t_CODEC codec,
    t_whenFinished whenFinished,
    t_whenPaused whenPaused,
    t_onSkip onSkipForward = null,
    t_onSkip onSkipBackward = null,
  }) async {
    TrackPlayer player = soundPlayer;
    await player.startPlayerFromTrack(
      track,
      whenFinished: whenFinished,
      onSkipBackward: onSkipBackward,
      onSkipForward: onSkipForward,
    );
  }
}
