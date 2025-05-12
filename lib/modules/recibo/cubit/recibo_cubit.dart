import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sge_flutter/core/services/recibo_service.dart';
import 'package:sge_flutter/models/recibo_model.dart';
import 'package:sge_flutter/modules/recibo/cubit/recibo_state.dart';

class ReciboCubit extends Cubit<ReciboState> {
  final Box<ReciboModel> reciboBox;
  final ReciboService reciboService;

  ReciboCubit(this.reciboBox, this.reciboService) : super(ReciboInitial());

  Future<void> carregarRecibos() async {
    emit(ReciboLoading());
    try {
      final recibos = reciboBox.values.toList();
      emit(ReciboLoaded(recibos));
    } catch (e) {
      emit(ReciboFailure('Erro ao carregar recibos: $e'));
    }
  }

  Future<void> gerarPdf(ReciboModel recibo) async {
    emit(ReciboLoading());
    try {
      final pdfBytes = await reciboService.gerarReciboPdf(
        nomeEmpresa: recibo.nomeEmpresa,
        nomeCliente: recibo.nomeCliente,
        produto: recibo.produto,
        quantidade: recibo.quantidade,
        valorTotal: recibo.valor,
      );
      emit(ReciboPdfGerado(Uint8List.fromList(pdfBytes)));
    } catch (e) {
      emit(ReciboFailure('Erro ao gerar PDF: $e'));
    }
  }
}
