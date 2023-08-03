part of '../edit_profile_screen.dart';

class ProfileBasicInfoTab extends StatefulWidget {
  const ProfileBasicInfoTab({super.key});

  @override
  State<ProfileBasicInfoTab> createState() => _ProfileBasicInfoTabState();
}

class _ProfileBasicInfoTabState extends State<ProfileBasicInfoTab> {
  final firstNameController = TextEditingController(text: '');
  final lastNameController = TextEditingController(text: '');
  final dateOfBirthController = TextEditingController(text: '');
  final identityController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final phoneNumberController = TextEditingController(text: '');
  final addressController = TextEditingController(text: '');

  late ProfileBloc profileBloc;
  @override
  void initState() {
    super.initState();
    profileBloc = context.read<ProfileBloc>();
    firstNameController.text = profileBloc.state.tempProfile!.firstName ??
        ErrorMessage.isNotDetermined;
    lastNameController.text =
        profileBloc.state.tempProfile!.lastName ?? ErrorMessage.isNotDetermined;
    dateOfBirthController.text = profileBloc.state.tempProfile!.dateOfBirth ??
        ErrorMessage.isNotDetermined;
    identityController.text =
        profileBloc.state.tempProfile!.identity ?? ErrorMessage.isNotDetermined;
    emailController.text =
        profileBloc.state.tempProfile!.email ?? ErrorMessage.isNotDetermined;
    phoneNumberController.text = profileBloc.state.tempProfile!.phoneNumber ??
        ErrorMessage.isNotDetermined;
    addressController.text =
        profileBloc.state.tempProfile!.address ?? ErrorMessage.isNotDetermined;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormFieldWidget(
            onChanged: (_) => profileBloc.state.tempProfile!.firstName =
                firstNameController.text,
            controller: firstNameController,
            textInputType: TextInputType.name,
            colorTheme: AppColors.textColor,
            labelText: 'First name',
          ),
          8.vSpace,
          TextFormFieldWidget(
            onChanged: (_) => profileBloc.state.tempProfile!.lastName =
                lastNameController.text,
            controller: lastNameController,
            textInputType: TextInputType.name,
            colorTheme: AppColors.textColor,
            labelText: 'Last name',
          ),
          8.vSpace,
          Row(
            children: [
              Expanded(
                child: TextFormFieldWidget(
                  controller: dateOfBirthController,
                  textInputType: TextInputType.name,
                  colorTheme: AppColors.textColor,
                  labelText: 'Date of birth',
                  enabled: false,
                ),
              ),
              12.hSpace,
              InkWell(
                onTap: () async => selectDate(dateOfBirthController),
                child: Container(
                  height: 50.sf,
                  width: 50.sf,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    border: Border.all(
                      color: AppColors.accentColor,
                      width: 3.sf,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Icons.date_range_rounded),
                ),
              ),
              8.hSpace,
            ],
          ),
          8.vSpace,
          TextFormFieldWidget(
            onChanged: (_) => profileBloc.state.tempProfile!.identity =
                identityController.text,
            controller: identityController,
            textInputType: TextInputType.number,
            colorTheme: AppColors.textColor,
            labelText: 'Identity',
          ),
          8.vSpace,
          TextFormFieldWidget(
            onChanged: (_) =>
                profileBloc.state.tempProfile!.email = emailController.text,
            controller: emailController,
            textInputType: TextInputType.emailAddress,
            colorTheme: AppColors.textColor,
            labelText: 'Email',
          ),
          8.vSpace,
          TextFormFieldWidget(
            onChanged: (_) =>
                profileBloc.state.tempProfile!.address = addressController.text,
            controller: addressController,
            textInputType: TextInputType.text,
            colorTheme: AppColors.textColor,
            labelText: 'Address',
          ),
          8.vSpace,
        ],
      ),
    );
  }

  Future<DateTime?> selectDate(
    TextEditingController textEditingController,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      textEditingController.text = DateTimeConverter.getDate(
        picked.millisecondsSinceEpoch,
      );
      profileBloc.state.tempProfile!.dateOfBirth = picked.toIso8601String();
    }
    return DateTime.now();
  }
}
