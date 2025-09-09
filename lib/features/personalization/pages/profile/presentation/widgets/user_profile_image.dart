import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/images/circular_image.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/upload_user_profile_image_cubit.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/upload_user_profile_image_state.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/popups/loaders.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    this.width,
    this.height,
    this.image,
    this.showEditBtn = false,
  });
  final double? width, height;
  final String? image;
  final bool showEditBtn;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadUserProfileImageCubit(),
      child: Column(
        children: [
          BlocConsumer<UploadUserProfileImageCubit,
              UploadUserProfileImageState>(
            listener: (context, state) {
              if (state is UploadUserProfileImageSuccessState) {
                Loaders.successSnackBar(
                  title: 'Congratulations',
                  message: 'Success Uploaded image',
                );
              }
              if (state is UploadUserProfileImageFailureState) {
                Loaders.errorSnackBar(
                  title: 'Error',
                  message: 'Failed to upload image',
                );
              }
            },
            builder: (context, state) {
              if (state is UploadUserProfileImageSuccessState) {
                return TCircularImage(
                  padding: 0,
                  isNetworkImage: true,
                  image: state.url,
                  width: context.horzSize(width ?? 75),
                  height: context.horzSize(width ?? 75),
                );
              } else if (state is UploadUserProfileImageFailureState) {
                return TCircularImage(
                  padding: 0,
                  isNetworkImage: context.read<UserCubit>().previousImage != '',
                  image: context.read<UserCubit>().previousImage != ''
                      ? context.read<UserCubit>().previousImage
                      : TImages.user,
                  width: context.horzSize(width ?? 75),
                  height: context.horzSize(width ?? 75),
                );
              } else if (state is UplaodUserProfileImageLoadingState) {
                return ShimmerWidget(
                  height: context.horzSize(width ?? 75),
                  width: context.horzSize(width ?? 75),
                  shapeBorder: const CircleBorder(),
                );
              } else {
                return TCircularImage(
                  padding: 0,
                  isNetworkImage: (image != '') ? true : false,
                  image: (image != '')
                      ? context.read<UserCubit>().previousImage
                      : TImages.user,
                  width: context.horzSize(width ?? 75),
                  height: context.horzSize(width ?? 75),
                );
              }
            },
          ),
          if (showEditBtn)
            Builder(
              builder: (context) {
                return TextButton(
                  onPressed: () {
                    // Trigger change picture logic
                    context
                        .read<UploadUserProfileImageCubit>()
                        .uploadUserImage();
                  },
                  child: const ResponsiveText(
                    'Change Profile Picture',
                    style:
                        TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
