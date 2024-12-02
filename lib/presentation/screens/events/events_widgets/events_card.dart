import 'package:flutter/material.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/resources/styles_manager.dart';
import 'package:sccult_media/presentation/shared_components/shared_components_styles.dart';

class CustomHomePageCard extends StatefulWidget {
  final String cardImage;
  final String cardTitle;
  final String cardContent;
  final String actionBtnMsg;
  final VoidCallback onPressed;

  const CustomHomePageCard({
    Key? key,
    required this.cardImage,
    required this.cardTitle,
    required this.cardContent,
    required this.actionBtnMsg,
    required this.onPressed
  }) : super(key: key);

  @override
  State<CustomHomePageCard> createState() => _CustomHomePageCardState();
}

class _CustomHomePageCardState extends State<CustomHomePageCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: MediaQuery.of(context).size.height * 0.10),
            decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.cardImage),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(const Color(0xFFf2f2f2).withOpacity(0.25), BlendMode.colorDodge)
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border.all(width: 1.2, color: const Color(0x40d9d9d9)),
            ),
            child: Center(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  width: 264,
                  decoration: BoxDecoration(
                    color: Color(0x80f2f2f2),
                    borderRadius: BorderRadius.all(Radius.circular(8),),),
                  child: Center(
                    child: Text(widget.cardTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, )),
                  )
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 24,),
                    Icon(Icons.calendar_today, size: 16, color: const Color(0xFF666666),),
                    SizedBox(width: 4,),
                    Text('Mar 16, 2024', style: const TextStyle(color: const Color(0xFF666666))),
                    SizedBox(width: 32,),
                    Icon(Icons.location_on_outlined, size: 18, color: const Color(0xFF666666),),
                    SizedBox(width: 4,),
                    Text('Nairobi', style: const TextStyle(color: const Color(0xFF666666))),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 48, bottom: 20.0, left: 24),
                  child: Text(widget.cardContent,
                    style: TextStyle(color: ColorManager.paleBlack, fontSize: 14.8),),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 24.0, bottom: 32),
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: CustomAppButton(
                //       onPressed: widget.onPressed,
                //       label: widget.actionBtnMsg,
                //       width: 236,
                //       isPrimary: true,
                //       showArrow: false,
                //     ),
                //   ),
                // ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: <Widget>[
                //     TextButton(
                //       child: const Text('BUY TICKETS'),
                //       onPressed: () {/* ... */},
                //     ),
                //     const SizedBox(width: 8),
                //     TextButton(
                //       child: const Text('LISTEN'),
                //       onPressed: () {/* ... */},
                //     ),
                //     const SizedBox(width: 8),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
