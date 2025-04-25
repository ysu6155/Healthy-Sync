import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> messages = [];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      messages.insert(0, {'text': _messageController.text, 'sender': 'You'});
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: Text("Medical Chat", style: TextStyles.font20DarkBlueBold),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  var message = messages[index];
                  bool isMe = message['sender'] == 'You';
                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 5.w,
                        horizontal: 10.sp,
                      ),
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        color: isMe ? AppColor.mainBlue : Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                          bottomLeft:
                              isMe ? Radius.circular(15.r) : Radius.circular(0),
                          bottomRight:
                              isMe
                                  ? Radius.circular(0.r)
                                  : Radius.circular(15.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text']!,
                            style: TextStyles.font16DarkBlueW500.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            message['sender']!,
                            style: TextStyles.font16DarkBlueW500.copyWith(
                              fontSize: 12.sp,
                              color: AppColor.mainPink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 20.sp),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _messageController,
                      hintText: "Type a message...",
                      borderColor: AppColor.mainPink,
                    ),
                  ),
                  IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
