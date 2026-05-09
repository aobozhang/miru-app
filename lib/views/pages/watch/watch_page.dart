import 'package:flutter/material.dart';
import 'package:miru_app/models/extension.dart';
import 'package:miru_app/views/pages/watch/reader/comic/comic_reader.dart';
import 'package:miru_app/views/pages/watch/reader/novel/novel_reader.dart';
import 'package:miru_app/utils/extension.dart';
import 'package:miru_app/utils/external_player.dart';
import 'package:miru_app/utils/miru_storage.dart';
import 'dart:io';

class WatchPage extends StatelessWidget {
  const WatchPage({
    super.key,
    required this.playList,
    required this.package,
    required this.title,
    required this.playerIndex,
    required this.episodeGroupId,
    required this.detailUrl,
    required this.anilistID,
    this.cover,
  });
  final List<ExtensionEpisode> playList;
  final int playerIndex;
  final String title;
  final String package;
  final String detailUrl;
  final int episodeGroupId;
  final String? cover;
  final String anilistID;

  @override
  Widget build(BuildContext context) {
    final runtime = ExtensionUtils.runtimes[package]!;
    switch (runtime.extension.type) {
      case ExtensionType.bangumi:
        // For bangumi, redirect to external player
        final player = MiruStorage.getSetting(SettingKey.videoPlayer);
        launchDesktopExternalPlayer(
          playList[playerIndex].url,
          player,
          {},
          [],
        );
        return const SizedBox.shrink();
      case ExtensionType.manga:
        return ComicReader(
          title: title,
          playList: playList,
          detailUrl: detailUrl,
          playerIndex: playerIndex,
          episodeGroupId: episodeGroupId,
          runtime: runtime,
          cover: cover,
          anilistID: anilistID,
        );
      default:
        return NovelReader(
          playList: playList,
          runtime: runtime,
          episodeGroupId: episodeGroupId,
          playerIndex: playerIndex,
          title: title,
          detailUrl: detailUrl,
          cover: cover,
          anilistID: anilistID,
        );
    }
  }
}
