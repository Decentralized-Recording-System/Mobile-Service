import 'dart:convert';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:ethers/signers/wallet.dart';
import 'package:hex/hex.dart';
import 'package:convert/convert.dart';

class Web3Dart {
  void getPrivateKey() async {
    final mnemonic =
        "that solve tourist food foster because slim banner duck dynamic daughter juice";
    // final mnemonic = mnemonics;
    final walletMnemonic = Wallet.fromMnemonic(mnemonic);
    print(walletMnemonic.privateKey);
  }
}
