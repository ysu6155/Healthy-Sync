import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:healthy_sync/feature/patients/home/data/models/doctor_visit.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({
    super.key,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    // إضافة رسائل تجريبية باستخدام بيانات الزيارة
    messages = [
      {
        'text': 'مرحباً، هل يمكنني تحديد موعد معك غداً؟',
        'sender': 'me',
        'time': '09:30',
        'isRead': true,
      },
      {
        'text': 'نعم بالتأكيد، ما هو الوقت المناسب لك؟',
        'sender': 'user',
        'time': '09:34',
        'isRead': true,
      },
    ];
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      messages.insert(0, {
        'text': _messageController.text,
        'sender': 'me',
        'time': DateTime.now().toString().substring(11, 16),
        'isRead': false,
      });
    });
    _messageController.clear();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        // إضافة رسالة جديدة تحتوي على الملف المرفق
        setState(() {
          messages.insert(0, {
            'text': 'تم إرفاق ملف: ${result.files.single.name}',
            'sender': 'me',
            'time': DateTime.now().toString().substring(11, 16),
            'isRead': false,
            'isFile': true,
            'fileName': result.files.single.name,
            'fileSize': result.files.single.size,
            'filePath': result.files.single.path,
          });
        });
      }
    } catch (e) {
      // عرض رسالة خطأ للمستخدم
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء اختيار الملف'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.mainBlue,
        centerTitle: true,
        toolbarHeight: 48.sp,
        title: Text(
          "شات طبي",
          style: TextStyle(
            fontSize: 22.sp,
            color: AppColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: AppColor.white),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    bool isMe = message['sender'] == 'me';
                    bool isFile = message['isFile'] ?? false;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 4.h,
                      ),
                      child: Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!isMe) ...[
                            Container(
                              width: 32.sp,
                              height: 32.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.mainBlue.withOpacity(0.1),
                              ),
                              child: Icon(
                                Icons.person_outline_rounded,
                                color: AppColor.mainBlue,
                                size: 20.sp,
                              ),
                            ),
                            8.W,
                          ],
                          Flexible(
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75,
                              ),
                              padding: EdgeInsets.all(12.sp),
                              decoration: BoxDecoration(
                                color: isMe ? AppColor.mainBlue : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                  bottomLeft: isMe
                                      ? Radius.circular(16.r)
                                      : Radius.circular(4.r),
                                  bottomRight: isMe
                                      ? Radius.circular(4.r)
                                      : Radius.circular(16.r),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: (isMe
                                            ? AppColor.mainBlue
                                            : AppColor.grey)
                                        .withOpacity(0.4),
                                    blurRadius: 16,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (isFile) ...[
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.attach_file_rounded,
                                          color: isMe
                                              ? Colors.white
                                              : AppColor.mainBlue,
                                          size: 20.sp,
                                        ),
                                        8.W,
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: isMe
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                message['fileName']!,
                                                style: TextStyle(
                                                  color: isMe
                                                      ? Colors.white
                                                      : AppColor.mainBlueDark,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                '${(message['fileSize']! / 1024).toStringAsFixed(1)} KB',
                                                style: TextStyle(
                                                  color: isMe
                                                      ? Colors.white
                                                          .withOpacity(0.7)
                                                      : AppColor.mainBlue
                                                          .withOpacity(0.7),
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ] else
                                    Text(
                                      LocaleKeys.message.tr(),
                                      style: TextStyle(
                                        color: isMe
                                            ? Colors.white
                                            : AppColor.mainBlueDark,
                                        fontSize: 15.sp,
                                        height: 1.4,
                                      ),
                                    ),
                                  4.H,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        message['time']!,
                                        style: TextStyle(
                                          color: isMe
                                              ? Colors.white.withOpacity(0.7)
                                              : AppColor.mainBlue
                                                  .withOpacity(0.7),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      if (isMe) ...[
                                        4.W,
                                        Icon(
                                          message['isRead']!
                                              ? Icons.done_all_rounded
                                              : Icons.done_rounded,
                                          color: message['isRead']!
                                              ? Colors.blue[200]
                                              : Colors.white.withOpacity(0.7),
                                          size: 16.sp,
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isMe) ...[
                            8.W,
                            Container(
                              width: 32.sp,
                              height: 32.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.mainBlue.withOpacity(0.1),
                              ),
                              child: Icon(
                                Icons.person_outline_rounded,
                                color: AppColor.mainBlue,
                                size: 20.sp,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.attach_file_rounded,
                        color: AppColor.mainBlue,
                        size: 24.sp,
                      ),
                      onPressed: _pickFile,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: _messageController,
                        hintText: "اكتب رسالتك هنا...",
                        borderColor: AppColor.mainBlue.withOpacity(0.2),
                        fillColor: Colors.grey[50],
                        borderRadius: 25.r,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                      ),
                    ),
                    12.W,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.mainBlue,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.mainBlue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
