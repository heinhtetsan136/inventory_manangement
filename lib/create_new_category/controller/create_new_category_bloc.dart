import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/create_new_category/controller/create_new_category_event.dart';
import 'package:inventory_management_app/create_new_category/controller/create_new_category_state.dart';
import 'package:inventory_management_app/repo/category_repo/category_entity.dart';
import 'package:inventory_management_app/repo/category_repo/category_repo.dart';

class CreateNewCategoryBloc
    extends Bloc<CreateNewCategoryEvent, CreateNewCategoryState> {
  final SqliteCategoryRepo categoryRepo;
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState>? formkey = GlobalKey<FormState>();
  CreateNewCategoryBloc(super.initialState, this.categoryRepo) {
    on<CreateNewCategoryEvent>(_createNewCategoryEventListener);
  }

  FutureOr<void> _createNewCategoryEventListener(_, emit) async {
    if (state is CreateNewCategoryCreatingState) return;
    assert(formkey?.currentState?.validate() == true);
    emit(CreateNewCategoryCreatingState());
    final result = await categoryRepo
        .create(CategoryParams.create(name: nameController.text));
    if (result.hasError) {
      emit(CreateNewCategoryErrorState(
          result.exception?.message ?? result.toString()));
      return;
    }
    emit(CreateNewCategoryCreatedState());
  }

  @override
  Future<void> close() {
    nameController.dispose();
    formkey == null;
    // TODO: implement close
    return super.close();
  }
}
