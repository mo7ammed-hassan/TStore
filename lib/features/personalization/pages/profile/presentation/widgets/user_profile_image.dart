import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/popups/loaders.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/personalization/cubit/user_state.dart';

class UserProfileImage extends StatefulWidget {
  const UserProfileImage({
    super.key,
    this.radius = 22,
    this.showEditButton = false,
    this.showBorder = false,
    this.borderColor = AppColors.darkGrey,
    this.borderWidth = 2,
    this.editButtonSize = 18,
    this.editButtonColor = Colors.black,
    this.editButtonBgColor = AppColors.softGrey,
    this.defaultAvatarIcon = Iconsax.user,
    this.onImageSelected,
  });

  final double radius;
  final bool showEditButton;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;
  final double editButtonSize;
  final Color editButtonColor;
  final Color editButtonBgColor;
  final IconData defaultAvatarIcon;
  final Function(String)? onImageSelected;

  @override
  State<UserProfileImage> createState() => _UserProfileImageState();
}

class _UserProfileImageState extends State<UserProfileImage> {
  bool _isUploading = false;
  String? _localPreviewPath;

  Future<void> _pickImage() async {
    FocusScope.of(context).unfocus();
    if (_isUploading) return;
    setState(() => _isUploading = true);

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null && mounted) {
        final path = pickedFile.path.replaceAll(' ', '-');
        setState(() => _localPreviewPath = path);
        widget.onImageSelected?.call(path);

        // Upload to API
        context
            .read<UserCubit>()
            .updateUserFiled({'profilePicture': path}, skipValidation: true);
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Image Selection Error',
        message: 'Failed to select image: ${e.toString()}',
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Widget _buildAvatar(UserState state) {
    final size = context.horzSize(widget.radius) * 2;
    final errorIconSize = context.horzSize(widget.radius) * 0.8;

    final imageUrl = _localPreviewPath ?? state.user?.profilePicture ?? '';

    if (state.status == UserStatus.loading &&
        state.action == UserAction.update) {
      return ClipOval(child: ShimmerWidget(width: size, height: size));
    }

    if (imageUrl.isEmpty) {
      return CircleAvatar(
        radius: context.horzSize(widget.radius),
        child: Image.asset(TImages.user),
      );
    }

    if (!imageUrl.startsWith('http')) {
      // Local file preview
      return FutureBuilder<bool>(
        future: File(imageUrl).exists(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ClipOval(child: ShimmerWidget(width: size, height: size));
          }
          if (snapshot.data == false) {
            return CircleAvatar(
              radius: context.horzSize(widget.radius),
              child: Image.asset(TImages.user),
            );
          }
          return CircleAvatar(
            radius: context.horzSize(widget.radius),
            backgroundImage: FileImage(File(imageUrl)),
            backgroundColor: Colors.white,
          );
        },
      );
    }

    // Network image
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (_, provider) => CircleAvatar(
        radius: context.horzSize(widget.radius),
        backgroundImage: provider,
        backgroundColor: Colors.white,
      ),
      placeholder: (_, __) =>
          ClipOval(child: ShimmerWidget(width: size, height: size)),
      errorWidget: (_, __, ___) => CircleAvatar(
        radius: context.horzSize(widget.radius),
        child: Icon(
          widget.defaultAvatarIcon,
          size: errorIconSize,
          color: AppColors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    widget.showBorder ? Border.all(color: Colors.grey) : null,
              ),
              child: _buildAvatar(state),
            ),
            if (widget.showEditButton)
              TextButton(
                onPressed: () => _pickImage(),
                child: _isUploading
                    ? SizedBox(
                        width: widget.editButtonSize,
                        height: widget.editButtonSize,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.blue,
                        ),
                      )
                    : const ResponsiveText(
                        'Change Profile Picture',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
              ),
          ],
        );
      },
    );
  }
}


// Stack(
//             clipBehavior: Clip.none,
//             children: [
//               _buildAvatar(state),
//               TextButton(
//                 onPressed: () => _pickImage(),
//                 child: const ResponsiveText(
//                   'Change Profile Picture',
//                   fontSize: 11.5,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               if (widget.showEditButton)
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: Semantics(
//                     label: 'Edit profile picture',
//                     button: true,
//                     child: InkWell(
//                       onTap: _pickImage,
//                       borderRadius: BorderRadius.circular(
//                           context.horzSize(widget.radius)),
//                       child: Container(
//                         padding: EdgeInsets.all(
//                             context.horzSize(widget.radius) * 0.17),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: widget.editButtonBgColor,
//                         ),
//                         child: _isUploading
//                             ? SizedBox(
//                                 width: widget.editButtonSize,
//                                 height: widget.editButtonSize,
//                                 child: const CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.blue,
//                                 ),
//                               )
//                             : Icon(
//                                 Iconsax.edit_2,
//                                 size: widget.editButtonSize,
//                                 color: widget.editButtonColor,
//                               ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           );