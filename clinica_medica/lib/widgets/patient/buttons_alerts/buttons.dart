import 'package:flutter/material.dart';

nextButton(BuildContext context, Function next) => SizedBox(
      height: 48,
      width: 150,
      child: ElevatedButton(
        onPressed: next,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            primary: Theme.of(context).accentColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: const Text('Próximo')),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(0),
              child: const Icon(Icons.arrow_forward, size: 19.0),
            ),
          ],
        ),
      ),
    );

previousButton(BuildContext context, Function previous) => SizedBox(
      height: 48,
      width: 150,
      child: OutlinedButton(
        onPressed: previous,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        child: Text(
          'Voltar',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );

cancelButton(BuildContext context, Function cancel) => SizedBox(
      height: 48,
      width: 150,
      child: OutlinedButton(
        onPressed: cancel,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        child: Text(
          'Cancelar',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );

finishButton(BuildContext context, Function finish) => SizedBox(
      height: 48,
      width: 150,
      child: ElevatedButton(
        onPressed: finish,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            primary: Theme.of(context).accentColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: const Text('Finalizar')),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(0),
              child: const Icon(Icons.check, size: 19.0),
            ),
          ],
        ),
      ),
    );
