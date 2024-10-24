import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // E-posta ile kayıt olma
  Future<User?> registerWithEmail(
      String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      await _firestore.collection('users').doc(userCredential.user?.uid).set(
        {
          'userId': userCredential.user?.uid,
          'userName': name,
          'userImage': user?.photoURL,
          'displayName': user?.displayName,
          'userEmail': user?.email,
          'createdDate': FieldValue.serverTimestamp(),
        },
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw 'Registration failed $e';
    }
  }

  // E-posta ile giriş yapma
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Firebase hatalarını yakalayıp yeniden fırlatın
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      // Diğer hataları yakalayıp yeniden fırlatın
      throw 'An unexpected error occurred';
    }
  }

// Firebase hata mesajlarını düzenlemek için yardımcı metod
  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'weak-password':
        return 'Password is too weak';
      case 'email-already-in-use':
        return 'This email is already registered';
      default:
        return 'Authentication failed';
    }
  }

  // Google ile giriş yapma
  Future<User?> signInWithGoogle() async {
    try {
      // Google Sign-In nesnesini oluştur
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Mevcut oturumları temizle
      await googleSignIn.signOut();

      // Yeni giriş isteği
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print('Google sign in cancelled');
        return null;
      }

      try {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          try {
            await _firestore.collection('users').doc(user.uid).set({
              'userId': user.uid,
              'userName': user.displayName,
              'userImage': user.photoURL,
              'displayName': user.displayName,
              'userEmail': user.email,
              'createdDate':
                  FieldValue.serverTimestamp(), // serverTimestamp kullan
            }, SetOptions(merge: true));
          } catch (firestoreError) {
            print('Firestore error: $firestoreError');
            // Firestore hatası olsa bile kullanıcı girişi başarılı sayılabilir
          }
          return user;
        }
      } catch (authError) {
        print('Firebase auth error: $authError');
        rethrow;
      }

      return null;
    } catch (e) {
      print('Google sign in error: $e');
      rethrow;
    }
  }

  Future<UserCredential?> signGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      return await _auth.signInWithCredential(cred);
    } catch (e) {
      print('Xeta Bash Verdi: ${e.toString()}');
    }
  }

  // Kullanıcı bilgilerini Firestore'a kaydetme
  Future<void> saveUserToFirestore(User user, String signInMethod) async {
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'signInMethod': signInMethod,
      'lastSignIn': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Çıkış yapma
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      print('Sign out error: ${e.toString()}');
    }
  }
}
