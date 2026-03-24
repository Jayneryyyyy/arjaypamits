import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SoundboardPage(),
      ),
    );
  }
}

class SoundboardPage extends StatefulWidget {
  const SoundboardPage({super.key});

  @override
  State<SoundboardPage> createState() => _SoundboardPageState();
}

class _SoundboardPageState extends State<SoundboardPage> {
  late AudioPlayer _audioPlayer;

  // Sound file names
  final List<String> soundFiles = [
    '1.mp3',
    '2.mp3',
    '3.mp3',
    '4.mp3',
    '5.mp3',
    '6.mp3',
    '7.mp3',
    'applepay.mp3',
    'among-us-role-reveal-sound.mp3',
    'dry-fart.mp3',
    'HAHAHA.mp3',
    'REFEREE.mp3',
  ];

  // Color palette for 4 rows (3 colors per row)
  final List<List<Color>> buttonColors = [
    // Green row
    [Color(0xFFAEE571), Color(0xFF9BFF2E), Color(0xFF6FD741)],
    // Orange row
    [Color(0xFFFFDFA5), Color(0xFFFFB86F), Color(0xFFFF8C42)],
    // Red/Pink row
    [Color(0xFFFF6B6B), Color(0xFFFF9999), Color(0xFFFFBBBB)],
    // Blue row
    [Color(0xFFB3E5FC), Color(0xFF4FC3F7), Color(0xFF0288D1)],
  ];

  // Border colors for each button
  final List<List<Color>> buttonBorders = [
    [Color(0xFF5FA833), Color(0xFF4FA800), Color(0xFF3B8C1F)],
    [Color(0xFFD49C4A), Color(0xFFC88B3A), Color(0xFFCC7F2E)],
    [Color(0xFFD94444), Color(0xFFD96666), Color(0xFFD99999)],
    [Color(0xFF7FB8D4), Color(0xFF2196F3), Color(0xFF0277BD)],
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void playSound(int index) async {
    // Stop any currently playing sound
    await _audioPlayer.stop();

    // Play the new sound
    await _audioPlayer.play(
      AssetSource('onlinesounds/${soundFiles[index]}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8E8E8),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            // Title
            Text(
              'ARJAY SOUNDBOARD',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 40),
            // Grid - 3x4 compact layout
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 80,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  final rowIndex = index ~/ 3;
                  final colIndex = index % 3;
                  final color = buttonColors[rowIndex][colIndex];
                  final borderColor = buttonBorders[rowIndex][colIndex];

                  return SoundButton(
                    color: color,
                    borderColor: borderColor,
                    onPressed: () => playSound(index),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class SoundButton extends StatefulWidget {
  final Color color;
  final Color borderColor;
  final VoidCallback onPressed;

  const SoundButton({
    super.key,
    required this.color,
    required this.borderColor,
    required this.onPressed,
  });

  @override
  State<SoundButton> createState() => _SoundButtonState();
}

class _SoundButtonState extends State<SoundButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        widget.onPressed();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: _isPressed
              ? widget.color.withAlpha(180)
              : widget.color,
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.borderColor,
            width: 3,
          ),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(120),
                    blurRadius: 3,
                    offset: const Offset(1, 1),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
        ),
      ),
    );
  }
}
