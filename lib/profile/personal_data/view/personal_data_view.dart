// lib/personal_data/view/personal_data_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../models/user_profile.dart';
import '../cubit/personal_data_cubit.dart';
// import '../../profile/models/user_profile.dart';

class PersonalDataView extends StatefulWidget {
  const PersonalDataView({super.key});

  @override
  State<PersonalDataView> createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _dateController;

  final List<String> _genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void initState() {
    super.initState();
    final user = context.read<PersonalDataCubit>().state;
    if (user is PersonalDataLoaded) {
      _nameController = TextEditingController(text: user.user.name);
      _emailController = TextEditingController(text: user.user.email);
      _phoneController = TextEditingController(text: user.user.phoneNumber ?? '');
      _dateController = TextEditingController(
        text: user.user.dateOfBirth != null
            ? DateFormat('dd/MM/yyyy').format(user.user.dateOfBirth!)
            : '',
      );
    } else {
      _nameController = TextEditingController();
      _emailController = TextEditingController();
      _phoneController = TextEditingController();
      _dateController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: BlocConsumer<PersonalDataCubit, PersonalDataState>(
        listener: (context, state) {
          if (state is PersonalDataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is PersonalDataSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Personal data saved successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            // Return the updated user to the previous screen
            Navigator.of(context).pop(state.user);
          }
        },
        builder: (context, state) {
          if (state is PersonalDataLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PersonalDataLoaded ||
              state is PersonalDataSaving ||
              state is PersonalDataImageUploading) {

            UserProfile user;
            bool isSaving = false;
            bool isImageUploading = false;

            if (state is PersonalDataLoaded) {
              user = state.user;
            } else if (state is PersonalDataSaving) {
              user = state.user;
              isSaving = true;
            } else if (state is PersonalDataImageUploading) {
              user = state.user;
              isImageUploading = true;
            } else {
              return const SizedBox();
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildProfileSection(context, user, isImageUploading),
                      const SizedBox(height: 30),
                      _buildFormFields(context, user, state),
                      const SizedBox(height: 40),
                      _buildSaveButton(context, state, isSaving),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                if (isSaving)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: const Text(
        'Personal Data',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, UserProfile user, bool isUploading) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade100,
              backgroundImage: user.profileImageUrl != null
                  ? CachedNetworkImageProvider(user.profileImageUrl!)
                  : null,
              child: user.profileImageUrl == null
                  ? Icon(Icons.person, size: 50, color: Colors.grey.shade400)
                  : null,
            ),
          ),
          if (isUploading)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => context.read<PersonalDataCubit>().uploadProfileImage(),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: user.hasNotifications ? Colors.orange : Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  user.hasNotifications ? Icons.notifications : Icons.camera_alt,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields(BuildContext context, UserProfile user, PersonalDataState state) {
    return Column(
      children: [
        _buildTextField(
          label: 'Full Name',
          controller: _nameController,
          onChanged: (value) => context.read<PersonalDataCubit>().updateName(value),
        ),
        const SizedBox(height: 20),
        _buildDateField(
          label: 'Date of birth',
          controller: _dateController,
          user: user,
        ),
        const SizedBox(height: 20),
        _buildGenderField(
          label: 'Gender',
          currentGender: user.gender ?? 'Male',
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: 'Phone',
          controller: _phoneController,
          onChanged: (value) => context.read<PersonalDataCubit>().updatePhoneNumber(value),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: 'Email',
          controller: _emailController,
          onChanged: (value) => context.read<PersonalDataCubit>().updateEmail(value),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.orange, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required UserProfile user,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context, user),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              controller.text.isNotEmpty ? controller.text : 'Select date',
              style: TextStyle(
                fontSize: 16,
                color: controller.text.isNotEmpty ? Colors.black : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderField({
    required String label,
    required String currentGender,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showGenderPicker(context, currentGender),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentGender,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context, PersonalDataState state, bool isSaving) {
    final isEnabled = state is PersonalDataLoaded && state.isEdited && !isSaving;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () => context.read<PersonalDataCubit>().savePersonalData()
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Colors.orange : Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: isSaving
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2,
          ),
        )
            : Text(
          'Save',
          style: TextStyle(
            color: isEnabled ? Colors.white : Colors.grey.shade600,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, UserProfile user) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: user.dateOfBirth ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.orange,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
      context.read<PersonalDataCubit>().updateDateOfBirth(picked);
    }
  }

  void _showGenderPicker(BuildContext context, String currentGender) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Gender',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              ..._genderOptions.map((gender) {
                return ListTile(
                  title: Text(gender),
                  trailing: currentGender == gender
                      ? const Icon(Icons.check, color: Colors.orange)
                      : null,
                  onTap: () {
                    context.read<PersonalDataCubit>().updateGender(gender);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}