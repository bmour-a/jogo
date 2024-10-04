import 'dart:math'; 
import 'package:flutter/material.dart'; 

class HomeView extends StatefulWidget { 
  @override
  _HomeViewState createState() => _HomeViewState(); 
}

class _HomeViewState extends State<HomeView> { 
  int randomNumber = Random().nextInt(60) + 1; // sorteia um numero aleatorio 
  final TextEditingController _guessController = TextEditingController(); // controla o campo onde o jogador digita o palpite
  String feedbackMessage = ""; // guarda a mensagem que sera mostrada ao jogador

  // funcao chamada quando o jogador envia um palpite
  void _submitGuess() {
    setState(() {
      int guess = int.tryParse(_guessController.text) ?? 0; // converte o texto digitado em numero ou 0 se a conversao falhar
      
      // verifica se o palpite esta correto, maior ou menor que o numero 
      if (guess == randomNumber) {
        feedbackMessage = "Parabéns, você acertou!"; // se o palpite estiver correto
        _restartGame(); // inicia um novo jogo apos o acerto
      } else if (guess > randomNumber) {
        feedbackMessage = "Seu palpite foi maior que o número sorteado. Tente novamente!"; // se o palpite for maior que o numero sorteado
      } else {
        feedbackMessage = "Seu palpite foi menor que o número sorteado. Tente novamente!"; // se o palpite for menor que o numero sorteado
      }
    });
  }

  // funcao que reinicia o jogo apos o jogador acertar o numero
  void _restartGame() {
    Future.delayed(Duration(seconds: 2), () { // espera antes de reiniciar o jogo
      setState(() {
        randomNumber = Random().nextInt(60) + 1; // sorteia um novo numero entre 1 e 60
        feedbackMessage = "Novo jogo iniciado! Tente adivinhar o novo número."; // exibe uma mensagem de inicio de novo jogo
        _guessController.clear(); // limpa o campo de texto onde o jogador digita o palpite
      });
    });
  }

  @override
  Widget build(BuildContext context) { // interface do jogo
    return Scaffold(
      appBar: AppBar(title: Text("Jogo de Adivinhação")), // barra superior com o titulo do jogo
      body: Padding(
        padding: const EdgeInsets.all(20.0), // adiciona espacamento nas bordas da tela
        child: Column( // organiza os elementos da tela em uma coluna
          mainAxisAlignment: MainAxisAlignment.center, // centraliza os elementos verticalmente
          children: [
            Text(
              "Digite um número entre 1 e 60",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // estilo do texto tamanho e negrito
            ),
            SizedBox(height: 20), // adiciona espaco em branco entre os elementos
            TextField( // campo onde digita o numero
              controller: _guessController, // relaciona o campo de texto ao palpite
              keyboardType: TextInputType.number, // define o teclado 
              decoration: InputDecoration(
                border: OutlineInputBorder(), // define a borda ao redor do texto
                labelText: "Seu Palpite", // texto dentro para indicar o que o jogador deve fazer
              ),
            ),
            SizedBox(height: 20), // mais espaco em branco
            ElevatedButton(
              onPressed: _submitGuess, // funcao chamada quando o jogador clica no botao
              child: Text("Enviar Palpite"), // texto no botao
            ),
            SizedBox(height: 20), // espaco entre o botao e a mensagem
            Text(
              feedbackMessage, // exibe a mensagem que da a dica ou parabeniza 
              style: TextStyle(fontSize: 18, color: Colors.black), // estilo da mensagem 
            ),
          ],
        ),
      ),
    );
  }
}
