/*
==========================================================
 UserState - Unified State Management Pattern OR Single State Class Pattern, Generalized State Pattern, Enum-based State Management
==========================================================

📌 Concept:
Instead of creating a separate State Class for each case
(Loading / Success / Failure / Error …etc),
we use a "single unified state" that represents 
all possible situations.

----------------------------------------------------------
🎯 Principles behind this approach:
1) Unified / Generalized State Pattern
   - One state class holding (Action + Status + Data).
2) DRY Principle (Don’t Repeat Yourself)
   - Avoids repeating very similar State classes.
3) Single Source of Truth
   - A single state that always reflects the user’s real state.
4) Finite State Machine (FSM)
   - Each state is a limited condition (initial, loading, success, failure)
     combined with an Action (fetch, update, logout).

----------------------------------------------------------
🛠️ How it works:
- UserAction → Type of operation (fetch / update / logout).
- UserStatus → Status of operation (initial / loading / success / failure).
- UserEntity / message / error → Extra data depending on the action.

----------------------------------------------------------
✅ Benefits:
- Less boilerplate code.
- Cleaner and easier to maintain.
- Clearer UI handling: one state contains both action + status.
- Flexible: if you add a new operation (e.g. changePassword),
  you just add a new Action without creating new State classes.

----------------------------------------------------------
📌 Summary:
This file implements the principle of:
"Unified State with Enums (Generalized State Pattern)"
Based on DRY + Single Source of Truth + FSM concepts.
==========================================================
*/

import 'package:t_store/features/personalization/domain/entites/user_entity.dart';

enum UserAction { fetch, update, logout }

enum UserStatus { initial, loading, success, failure }

class UserState {
  final UserAction action;
  final UserStatus status;
  final UserEntity? user;
  final String? message;
  final String? error;

  const UserState({
    this.action = UserAction.fetch,
    this.status = UserStatus.initial,
    this.user,
    this.message,
    this.error,
  });

  UserState copyWith({
    UserAction? action,
    UserStatus? status,
    UserEntity? user,
    String? message,
    String? error,
  }) {
    return UserState(
      action: action ?? this.action,
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'UserState(action: $action, status: $status, user: $user, message: $message, error: $error)';
}
