import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/calculation.dart';
import '../utils/snackbar.dart';
import 'login_controller.dart';

class CalculationController {
  createCalculation(context, Calculation calculation) {
    FirebaseFirestore.instance
        .collection('calculos')
        .doc(calculation.uid)
        .set(calculation.toJson())
        .then((value) {})
        .catchError((e) {
      error(context, 'Erro na criação: ${e.code.toString()}');
    });
  }

  updateCalculation(context, Calculation calculation) {
    FirebaseFirestore.instance
        .collection('calculos')
        .doc(calculation.uid)
        .update(calculation.toJson())
        .catchError(
            (e) => error(context, 'Erro na atualização: ${e.code.toString()}'));
  }

  void deleteCalculation(context, id) async {
    await FirebaseFirestore.instance
        .collection('calculos')
        .doc(id)
        .delete()
        .then((value) => success(context, 'Cálculo excluído com sucesso!'))
        .catchError(
            (e) => error(context, 'Erro na deleção: ${e.code.toString()}'));
  }

  Future<List<Calculation>> listCalculations(context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('calculos')
          .where('userId', isEqualTo: LoginController().getUserId())
          .get();
      List<Calculation> calculations = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        Calculation calculation = Calculation.fromJson(data);
        calculations.add(calculation);
      }
      return calculations;
    } catch (e) {
      error(context, 'Erro no retorno do cálculo, tente novamente.');
      return [];
    }
  }
}
