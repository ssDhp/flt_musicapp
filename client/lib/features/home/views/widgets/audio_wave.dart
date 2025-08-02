import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class AudioWave extends StatefulWidget {
  final String path;
  const AudioWave({super.key, required this.path});

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  void initAudioPlayer() async {
    await playerController.preparePlayer(path: widget.path);
    await playerController.setFinishMode(finishMode: FinishMode.stop);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: playAndPause,
          icon: Icon(
            playerController.playerState.isPlaying
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded,
          ),
        ),
        Expanded(
          child: AudioFileWaveforms(
            size: Size(double.infinity, 100),
            playerController: playerController,
          ),
        ),
      ],
    );
  }

  Future<void> playAndPause() async {
    setState(() {
      if (!playerController.playerState.isPlaying) {
        playerController.startPlayer();
      } else if (!playerController.playerState.isPaused) {
        playerController.pausePlayer();
      }
    });
  }
}
