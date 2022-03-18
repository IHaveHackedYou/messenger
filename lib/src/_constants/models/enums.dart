// is used by sign_up_screen.dart and sign_in_screen.dart to handle state management
enum AuthenticationState{
  // waiting for Firebase future
  loading,
  // initial state that shows forms
  start
}