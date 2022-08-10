import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:supplications_app/data/models/supplication.dart';

class SupplicationsShareButton extends StatefulWidget {
  final Supplication supplication;

  const SupplicationsShareButton({Key? key, required this.supplication}) : super(key: key);

  @override
  State<SupplicationsShareButton> createState() => _SupplicationsShareButtonState();
}

class _SupplicationsShareButtonState extends State<SupplicationsShareButton> {
  bool sharing = false;

  _share() async {
    setState(() {
      sharing = true;
    });

    String myUrl = '';

    try {
      final result = await http.post(Uri.parse('https://cleanuri.com/api/v1/shorten'), body: {
        'url': widget.supplication.audio,
      });

      if (result.statusCode == 200) {
        final jsonResult = jsonDecode(result.body);

        myUrl = jsonResult['result_url'];
      } else {
        throw ("status code not 200");
      }
    } catch (e) {
      print(e);
      myUrl = widget.supplication.audio;
    }

    Share.share(
      widget.supplication.arabicText + '\n\n' + widget.supplication.englishTranslation + '\n\n' + widget.supplication.romanArabic + '\n\nListen to audio here: ' + myUrl,
    );

    setState(() {
      sharing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _share,
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: (sharing == true)
            ? const SizedBox(width: 24, height: 24, child: Center(child: CircularProgressIndicator(strokeWidth: 3)))
            : const Icon(Icons.share, color: Color.fromRGBO(110, 110, 110, 1), size: 25),
      ),
    );
  }
}
