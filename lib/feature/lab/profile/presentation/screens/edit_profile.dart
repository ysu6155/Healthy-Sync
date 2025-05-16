import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/core/widgets/show_dialog.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/cubit/profile_cubit.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileLab extends StatefulWidget {
  const EditProfileLab({super.key});

  @override
  State<EditProfileLab> createState() => _EditProfileLabState();
}

class _EditProfileLabState extends State<EditProfileLab> {
  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.read<SignUpCubit>();
    final profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.mainPink),
          onPressed: () {
            context.pop();
            context.read<ProfileCubit>().getProfileData();
          },
        ),
        title: Text(
          LocaleKeys.editProfile.tr(),
          style: TextStyles.font20WhiteBold.copyWith(color: AppColor.mainPink),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateLoading) {
            showLoadingDialog(context);
          } else if (state is ProfileUpdateSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile updated successfully!")),
            );
          } else if (state is ProfileUpdateError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.sp),
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: _showImagePicker,
                        child: CircleAvatar(
                          radius: 70.r,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : AssetImage(AppAssets.personImage)
                                  as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: AppColor.white,
                          child: Icon(Icons.edit, color: AppColor.mainPink),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(22),
                CustomTextField(
                  controller: signUpCubit.nameController,
                  hintText: LocaleKeys.name.tr(),
                ),
                Gap(22),
                CustomTextField(
                  controller: signUpCubit.phoneController,
                  hintText: LocaleKeys.phone.tr(),
                ),
                Gap(22),
                CustomTextField(
                  controller: signUpCubit.addressController,
                  hintText: LocaleKeys.address.tr(),
                ),
                Gap(22),
                CustomButton(
                  name: "Update Profile",
                  onTap: () {
                    profileCubit.updateProfile(
                      _imageFile,
                      signUpCubit.nameController,
                      signUpCubit.phoneController,
                      signUpCubit.addressController,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.all(16),
        height: 150,
        child: Column(
          children: [
            Text(
              "Choose Profile Picture",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.photo,
                    size: 40,
                    color: AppColor.mainPink,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: AppColor.mainPink,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
