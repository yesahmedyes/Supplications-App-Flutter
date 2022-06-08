import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supplications_app/data/models/supplication.dart';
import 'package:supplications_app/logic/audio/audio_bloc.dart';

class SupplicationCard extends StatelessWidget {
  final Supplication supplication;
  final bool playing;

  const SupplicationCard({Key? key, required this.supplication, required this.playing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: (playing) ? BorderSide(color: Colors.blue.withOpacity(0.7), width: 1.5) : const BorderSide(color: Colors.grey, width: 0.2),
        ),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            context.read<AudioBloc>().add(AudioStartEvent(url: supplication.audio));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              children: [
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    supplication.arabicText,
                    style: GoogleFonts.notoSansArabic(
                      fontSize: 15,
                      height: 2,
                      color: const Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    supplication.englishTranslation,
                    style: const TextStyle(fontSize: 14, height: 1.6, color: Color.fromRGBO(51, 51, 51, 1)),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    supplication.romanArabic,
                    style: const TextStyle(fontSize: 14, height: 1.6, color: Color.fromRGBO(119, 119, 119, 1)),
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      elevation: 1,
                      color: const Color.fromRGBO(85, 85, 85, 1),
                      margin: const EdgeInsets.only(top: 16, right: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.play_arrow, color: Colors.white, size: 25),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
