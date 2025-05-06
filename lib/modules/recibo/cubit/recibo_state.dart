import 'dart:typed_data';
import '../../../models/recibo_model.dart';

abstract class ReciboState {}

class ReciboInitial extends ReciboState {}

class ReciboLoading extends ReciboState {}

class ReciboLoaded extends ReciboState {
  final List<ReciboModel> recibos;

  ReciboLoaded(this.recibos);
}

class ReciboPdfGerado extends ReciboState {
  final Uint8List pdfBytes;

  ReciboPdfGerado(this.pdfBytes);
}

class ReciboFailure extends ReciboState {
  final String message;

  ReciboFailure(this.message);
}
