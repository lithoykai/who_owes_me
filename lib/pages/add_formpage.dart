import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:who_owes_me/model/debtor_list.dart';
import '../components/adaptative_date_picker.dart';
import '../model/debtor.dart';

class Add_Form_Page extends StatefulWidget {
  const Add_Form_Page({Key? key}) : super(key: key);

  @override
  State<Add_Form_Page> createState() => _Add_Form_PageState();
}

class _Add_Form_PageState extends State<Add_Form_Page> {
  final _formData = Map<String, Object>();
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final myController = TextEditingController();
  //FocusNode
  final _nameFocus = FocusNode();
  final _valuePayFocus = FocusNode();
  final _dataFocus = FocusNode();
  final _phoneNumberFocus = FocusNode();

  @override
  void dispose() {
    _nameFocus.dispose();
    _valuePayFocus.dispose();
    _dataFocus.dispose();
    _phoneNumberFocus.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final debtor = arg as Debtor;
        _formData['name'] = debtor.name;
        _formData['valuePay'] = debtor.valuePay;
        _formData['phoneNumber'] = debtor.number;
        _formData['data'] = debtor.datePay;
      }
    }
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    _formData['datePay'] = _selectedDate;

    Provider.of<DebtorList>(
      context,
      listen: false,
    ).saveData(_formData, _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar devedor.'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_nameFocus);
                // },
                textInputAction: TextInputAction.next,
                // onSaved: (name) => name ?? '',
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_name) {
                  final name = _name ?? '';

                  if (name.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  if (name.trim().length < 3) {
                    return 'O nome precisa de no mínimo 3 letras.';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _formData['name']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: const TextInputType.numberWithOptions(),
                // onSaved: (phoneNumber) => debtorValue?.number,
                onSaved: (phoneNumber) =>
                    _formData['phoneNumber'] = phoneNumber ?? '',
                validator: (_phoneNumber) {
                  final phoneNumber = _phoneNumber ?? '';

                  if (phoneNumber.trim().isEmpty) {
                    return 'O número é obrigatório.';
                  }
                  if (phoneNumber.trim().length < 3) {
                    return 'O telefone precisa de no mínimo 3 numeros.';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _formData['valuePay']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Valor',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                // onSaved: (valuePay) => debtorValue?.valueMouth,
                onSaved: (valuePay) => _formData['valuePay'] = valuePay ?? '',
              ),
              const SizedBox(
                height: 10,
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onChangeDate: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              TextButton(
                onPressed: _submitForm,
                child: Text('Salvar.'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
