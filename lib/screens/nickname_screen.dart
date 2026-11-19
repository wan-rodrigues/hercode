
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NicknameScreen extends StatefulWidget {
  final Future<void> Function(String nickname) onContinuar;

  const NicknameScreen({
    super.key,
    required this.onContinuar,
  });

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  final TextEditingController _nicknameController =
      TextEditingController();

  final RegExp _caracteresPermitidos = RegExp(r'[a-zA-Z0-9_]');

  bool _salvando = false;

  String? _validarNickname(String? valor) {
    final nome = valor?.trim() ?? '';

    if (nome.isEmpty) {
      return 'Digite um nickname para continuar.';
    }

    if (nome.length < 3) {
      return 'O nickname deve ter pelo menos 3 caracteres.';
    }

    if (nome.length > 16) {
      return 'O nickname pode ter no máximo 16 caracteres.';
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(nome)) {
      return 'Use apenas letras, números e _.';
    }

    return null;
  }

  Future<void> _continuar() async {
    final nome = _nicknameController.text.trim();
    final erro = _validarNickname(nome);

    if (erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(erro)),
      );
      return;
    }

    if (_salvando) return;

    setState(() {
      _salvando = true;
    });

    try {
      await widget.onContinuar(nome);
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível salvar seu nickname. Tente novamente.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _salvando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFFECE2FA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFF8127E8),
                      size: 55,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    'Como podemos te chamar?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF512B8B),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Escolha um nickname para usar durante '
                    'sua jornada no HerCode!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF77768A),
                    ),
                  ),

                  const SizedBox(height: 35),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Seu nickname',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF512B8B),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: _nicknameController,
                    maxLength: 16,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        _caracteresPermitidos,
                      ),
                    ],
                    onSubmitted: (_) {
                      _continuar();
                    },
                    style: GoogleFonts.poppins(fontSize: 17),
                    decoration: InputDecoration(
                      hintText: 'Ex.: CodeExplorer',
                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xFF99939F),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.alternate_email_rounded,
                        color: Color(0xFF8127E8),
                      ),
                      counterStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF77768A),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color(0xFFD7B8FA),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color(0xFF8127E8),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'De 3 a 16 caracteres: letras, números e _',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF77768A),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _salvando ? null : _continuar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8127E8),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _salvando
                          ? const SizedBox(
                              width: 23,
                              height: 23,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Continuar',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
