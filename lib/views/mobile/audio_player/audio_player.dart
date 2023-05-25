import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/repository/constant_data.dart';
import 'package:music/utils/utils.dart';

import '../../../provider/audio_player_provider.dart';

class AudioPlayerPage extends ConsumerStatefulWidget {
  const AudioPlayerPage(
      {super.key, required this.videoId, required this.image});
  final String? videoId;
  final String? image;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AudioPlayerPageState();
}

class _AudioPlayerPageState extends ConsumerState<AudioPlayerPage> {
  @override
  void initState() {
    ref.read(audioStateProvider).setUrl(widget.videoId ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.videoId);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: Colors.transparent,
        actions: const [
          Icon(
            Icons.share,
            size: 30,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Icon(
            Icons.more_vert,
            size: 30,
            color: Colors.white,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              opacity: .4,
              fit: BoxFit.cover,
              image: showBackgroudImageProvider(widget.image!),
            )),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: showBackgroudImageProvider(widget.image!),
                  )),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(139, 0, 0, 0),
                    ),
                    width: double.maxFinite,
                    child: const Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Easy On Me",
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "Pavan kumar",
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.download,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.favorite,
                                color: Colors.greenAccent,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                        PlayerControllers(),
                        SizedBox(height: 5),
                        Divider(color: Color.fromARGB(102, 158, 158, 158)),
                        ListTile(
                          leading: Icon(Icons.upcoming_rounded,
                              color: Colors.white, size: 40),
                          title: Text(
                            "Up-Coming Song",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          subtitle: Text(
                            "Today's Top Hits",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}

class PlayerControllers extends ConsumerWidget {
  const PlayerControllers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioStateProvider);
    //  print();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: StreamBuilder<Duration?>(
            stream: audioState.durationStream,
            builder: (context, durationSnapshot) {
              if (!durationSnapshot.hasData) {
                return CircularProgressIndicator();
              }
              final totalDuration =
                  durationSnapshot.data!.inMilliseconds.toDouble();

              return StreamBuilder<Duration>(
                stream: audioState.positionStream,
                builder: (context, positionSnapshot) {
                  if (!positionSnapshot.hasData) {
                    return Slider(
                      value: 0,
                      min: 0,
                      max: totalDuration,
                      onChanged: (value) {},
                    );
                  }

                  final currentPosition =
                      positionSnapshot.data!.inMilliseconds.toDouble();

                  return Slider(
                    value: currentPosition.clamp(0.0, totalDuration),
                    min: 0,
                    max: totalDuration +
                        0.01, // Add a small buffer to the max value
                    onChanged: (value) {
                      final seekPosition =
                          Duration(milliseconds: value.toInt());
                      audioState.seek(seekPosition);
                    },
                  );
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shuffle_rounded,
                  color: Colors.grey,
                  size: 40,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.skip_previous_rounded,
                  color: Colors.white,
                  size: 40,
                )),
            CircleAvatar(
              radius: 30,
              child: audioState.playerState().processingState ==
                      ProcessingState.loading
                  ? CircularProgressIndicator()
                  : audioState.playerState().playing
                      ? IconButton(
                          onPressed: () {
                            audioState.pause();
                          },
                          icon: const Icon(
                            Icons.pause,
                            color: Colors.white,
                            size: 40,
                          ))
                      : IconButton(
                          onPressed: () {
                            audioState.play();
                          },
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 40,
                          )),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.skip_next_rounded,
                  color: Colors.white,
                  size: 40,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.repeat,
                  color: Colors.grey,
                  size: 40,
                )),
          ],
        )
      ],
    );
  }
}
