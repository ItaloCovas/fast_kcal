import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/main_page.dart';
import '../pages/success_page.dart';
import '../utils/snackbar.dart';

class LoginController {
  createAccount(context, name, email, password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((result) async {
      FirebaseFirestore.instance
          .collection('usuarios')
          .doc(result.user!.uid)
          .set(
        {
          'uid': result.user!.uid,
          'nome': name,
        },
      ).then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const SuccessPage(type: 'registration')));
      }).catchError((e) {
        switch (e.code) {
          case 'email-already-in-use':
            error(context, 'O email já foi cadastrado.');
            break;
          case 'invalid-email':
            error(context, 'O formato do email é inválido.');
            break;
          default:
            error(context, 'ERRO: ${e.code.toString()}');
        }
      });
    });
  }

  login(context, email, password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((result) {
      success(context, 'Usuário autenticado com sucesso.');

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          error(context, 'O formato do email é inválido.');
          break;
        case 'user-not-found':
          error(context, 'Usuário não encontrado.');
          break;
        case 'wrong-password':
          error(context, 'Senha incorreta.');
          break;
        default:
          error(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  forgotPassword(context, String email) {
    FirebaseAuth.instance
        .sendPasswordResetEmail(
      email: email,
    )
        .then((result) {
      success(context, 'Email enviado com sucesso.');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const SuccessPage(type: 'email')));
    }).catchError((e) {
      error(context, 'E-mail não encontrado.');
    });
  }

  logout() {
    FirebaseAuth.instance.signOut();
  }

  getUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<String> changeUsername(context, newName) async {
    var newUsername = newName;
    var userId = await getUserId();

    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .set({'nome': newUsername}, SetOptions(merge: true)).then((result) {
      success(context, 'Nome atualizado com sucesso!');
      Navigator.of(context).pop();
    }).catchError((e) => error(context, 'Erro na atualização'));

    return newUsername;
  }

  Future<String> loggedUser() async {
    var user = '';
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: getUserId())
        .get()
        .then(
      (result) {
        user = result.docs[0].data()['nome'] ?? '';
      },
    );
    return user;
  }
}
