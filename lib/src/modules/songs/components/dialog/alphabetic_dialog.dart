import 'package:flutter/material.dart';
import 'package:music_player/src/modules/common/components/grid_widget.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';
import 'package:music_player/src/modules/common/views/curved_scaffold.dart';
import 'package:music_player/src/modules/songs/blocs/song_label_bloc.dart';
import 'package:music_player/src/res/colors.dart';
import 'package:music_player/src/res/styles.dart';

class AlphabeticDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(null);
      },
      child: Material(
        color: Colors.white.withOpacity(0.9),
        child: Center(
          child: SizedBox(
            height: h * 0.8,
            width: w * 0.8,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GridWidget(
                crossCount: 4,
                spacing: 3,
                itemCount: SongLabelBloc.titles.length,
                builder: (c, w, i) {
                  var cur = SongLabelBloc.titles[i];
                  return TapEffect(
                    onClick: () {
                      Navigator.of(context).pop(cur);
                    },
                    child: Container(
                      width: w,
                      height: w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: scaffoldColor.withOpacity(0.2)),
                      ),
                      child: Center(
                        child: Text(
                          cur,
                          style: titleStyle,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<String?> showAlphabeticDialog(BuildContext context) => showDialog(
      context: context,
      builder: (c) => CurvedScaffold(child: AlphabeticDialog()),
      barrierColor: Colors.transparent,
    );
