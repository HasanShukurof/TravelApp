import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // E-posta ile kayıt olma
  Future<void> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await saveUserToFirestore(user, 'email');
      }
    } catch (e) {
      print('Registration error: ${e.toString()}');
      // Hata yönetimi
    }
  }

  // E-posta ile giriş yapma
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await saveUserToFirestore(user, 'email');
        return user; // Kullanıcıyı geri döndürün
      }
    } catch (e) {
      print('Login error: ${e.toString()}');
      return null; // Hata durumunda null döndürün
    }
    return null; // Kullanıcı null ise de null döndürün
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
