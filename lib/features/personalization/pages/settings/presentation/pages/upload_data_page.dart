import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/cubits/cubit/upload_data_cubit.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/widgets/main_record_section.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/widgets/relationships_section.dart';
import 'package:t_store/utils/constants/sizes.dart';

class UploadDataPage extends StatelessWidget {
  const UploadDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadDataCubit(),
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            children: [
              const TSectionHeading(
                  title: 'Main Record', showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwItems),
              const MainRecordSection(),
              const SizedBox(height: AppSizes.spaceBtwSections),
              const TSectionHeading(
                  title: 'Relationships', showActionButton: false),
              Text(
                'Make sure you have already uploaded all the content above',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              const RelationshipsSection(),
              const SizedBox(height: AppSizes.spaceBtwSections * 2),
              Builder(
                builder: (context) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<UploadDataCubit>()
                            .deleteDummyData(collection: 'Products');
                      },
                      child: const Text('Delete Products'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TAppBar _appBar() {
    return const TAppBar(
      showBackArrow: true,
      title: Text(
        'Upload Data',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}
