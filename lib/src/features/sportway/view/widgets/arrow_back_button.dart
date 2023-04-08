import 'package:flutter/material.dart';

class ArrowBackAppBarButton extends StatelessWidget {
  const ArrowBackAppBarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return canPop
        ? Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(12),
            child: OutlinedButton(
                style:
                    OutlinedButton.styleFrom(padding: const EdgeInsets.all(8)),
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 18,
                )),
          )
        : const SizedBox.shrink();
  }
}
