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

      await _firestore.collection('users').doc(userCredential.user?.uid).set(
        {
          'userId': userCredential.user?.uid,
          'userName': name,
          'displayName': userCredential.user?.displayName,
          'userEmail': userCredential.user?.email,
          'createdDate': DateTime.now(),
          'shifre': password
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
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      if (user != null) {
        await saveUserToFirestore(user, 'google');
      }
    } catch (e) {
      print('Google sign in error: ${e.toString()}');
      // Hata yönetimi
    }
    return null;
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
    await _auth.signOut();
  }
}
