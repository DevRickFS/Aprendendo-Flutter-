import '../models/moeda.dart';

class MoedaRepository {
  static List<Moedas>  tabela = [
      Moedas(
        icone: 'images/bitcoin.png', 
        nome: 'Bitcoin' , 
        sigla: "BTC", 
        preco: 138127.50),
      Moedas(
        icone: 'images/cardano.png',
        nome: 'Cardano',
        sigla: 'ADA',
        preco: 1.47),
      Moedas(
        icone: 'images/ethereum.png',
        nome: 'Ethereum',
        sigla: 'UTC',
        preco: 8794.32),
      Moedas(
        icone: 'images/litecoin.png', 
        nome: 'Litecoin', 
        sigla: 'LTC', 
        preco: 437.85),
      Moedas(
        icone: 'images/usdcoin.png', 
        nome: 'Usdcoin', 
        sigla: 'USDC', 
        preco: 4.73),
      Moedas(
        icone: 'images/xrp.png',
        nome: 'XRP', 
        sigla: 'XRP', 
        preco: 3.32)
    ];
  }

