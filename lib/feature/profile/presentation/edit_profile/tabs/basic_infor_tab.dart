part of '../edit_profile_screen.dart';

class BasicInforTab extends StatefulWidget {
  const BasicInforTab({super.key});

  @override
  State<BasicInforTab> createState() => _BasicInforTabState();
}

class _BasicInforTabState extends State<BasicInforTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              TextFormFieldWidget(
                textInputType: TextInputType.name,
                colorTheme: AppColors.textColor,
                labelText: 'First name',
                initialValue: state.tempProfile!.firstName,
              ),
              TextFormFieldWidget(
                textInputType: TextInputType.name,
                colorTheme: AppColors.textColor,
                labelText: 'Last name',
                initialValue: state.tempProfile!.lastName,
              ),
            ],
          ),
        );
      },
    );
  }
}
