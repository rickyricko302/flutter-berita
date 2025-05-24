import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:info_a1/app/data/services/remote_database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/profile_model.dart';

class AuthServices {
  final SupabaseClient supabaseClient;
  final RemoteDatabaseService remoteDatabaseService;

  String? get uid => supabaseClient.auth.currentUser?.id;

  AuthServices({
    required this.supabaseClient,
    required this.remoteDatabaseService,
  });

  /// Listens for changes in the authentication state. When the user is signed in,
  /// goHome is called. When the user is signed out, goLogin is called.
  void listenAuth({
    required VoidCallback goHome,
    required VoidCallback goLogin,
  }) {
    supabaseClient.auth.onAuthStateChange.listen((state) {
      Session? session = state.session;
      if (session != null) {
        log(session.user.toString());
        goHome();
      } else {
        goLogin();
      }
      if (state.event == AuthChangeEvent.signedOut) {
        goLogin();
      }
    });
  }

  /// Signs in a user with the provided email and password.
  ///
  /// Returns [AuthResponse] with the user's data.
  ///
  /// Throws [AuthApiException] if the request fails.
  ///
  /// Requires the user to be registered.
  ///
  /// Example:
  ///
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Signs in a user with Google.

  /// Returns [AuthResponse] with the user's data.

  /// Throws [AuthApiException] if the request fails.

  /// Requires the user to have a Google account.

  ///
  Future<AuthResponse> googleSignIn() async {
    const webClientId =
        '337702781329-6n6ii59vgghj9gu8dcs0l1s29mffkm22.apps.googleusercontent.com';
    const iosClientId =
        '337702781329-fr55cs442qt2u2fsu60svosu9bchklab.apps.googleusercontent.com';
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  /// Registers a user with the provided email and password.
  ///
  /// Returns [AuthResponse] with the user's data.
  ///
  /// Throws [AuthApiException] if the request fails.
  ///
  /// Requires the user not to be registered.
  ///
  Future<AuthResponse> register({
    required String email,
    required String password,
  }) async {
    return await supabaseClient.auth.signUp(email: email, password: password);
  }

  /// Inserts a profile into the profiles table.
  ///
  /// Throws [AuthApiException] if the request fails.
  ///
  /// Requires the user to be registered.
  ///
  Future<void> insertProfiles({required ProfileModel model}) async {
    return await remoteDatabaseService.insertProfiles(model: model);
  }

  /// Gets a profile from the profiles table.
  ///
  /// Throws [AuthApiException] if the request fails.
  ///
  /// Requires the user to be registered.
  ///
  /// Returns `null` if the user has no profile.
  ///
  Future<ProfileModel?> getProfile({required String userId}) async {
    return await remoteDatabaseService.getProfile(userId: userId);
  }

  /// Signs out the user.
  ///
  /// Throws [AuthApiException] if the request fails.
  ///
  /// Requires the user to be signed in.
  ///
  /// Returns a [Future] that resolves when the user is signed out.
  ///
  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }
}
