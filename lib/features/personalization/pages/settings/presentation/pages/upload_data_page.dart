import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/cubits/cubit/upload_data_cubit.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/widgets/main_record_section.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/widgets/relationships_section.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class UploadDataPage extends StatelessWidget {
  const UploadDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadDataCubit(),
      child: Scaffold(
        appBar: const TAppBar(
          showBackArrow: true,
          title: 
            'Upload Data',
           
        ),
        body: SingleChildScrollView(
          padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
          child: Column(
            children: [
              const TSectionHeading(
                  title: 'Main Record', showActionButton: false),
              ResponsiveGap.vertical(TSizes.spaceBtwItems),
              const MainRecordSection(),
              ResponsiveGap.vertical(TSizes.spaceBtwSections),
              const TSectionHeading(
                  title: 'Relationships', showActionButton: false),
              Text(
                'Make sure you have already uploaded all the content above',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwItems),
              const RelationshipsSection(),
              ResponsiveGap.vertical(TSizes.spaceBtwSections * 2),
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
                      child: const ResponsiveText(
                        'Delete Products',
                        style: TextStyle(fontSize: 14),
                      ),
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
}
