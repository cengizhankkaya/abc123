import 'dart:async';

import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';

/// İsim kaydetme akışı: boş değer kontrolü, inline checkmark geri bildirimi.
class ChildNameEditor extends StatefulWidget {
  const ChildNameEditor({
    required this.initialName,
    required this.onSave,
    required this.hintText,
    required this.saveText,
    required this.savedText,
    required this.emptyErrorText,
    super.key,
  });

  final String initialName;
  final ValueChanged<String> onSave;
  final String hintText;
  final String saveText;
  final String savedText;
  final String emptyErrorText;

  @override
  State<ChildNameEditor> createState() => _ChildNameEditorState();
}

class _ChildNameEditorState extends State<ChildNameEditor> {
  late final TextEditingController _controller;
  bool _showSuccess = false;
  bool _showError = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant ChildNameEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialName != widget.initialName && widget.initialName != _controller.text) {
      _controller.text = widget.initialName;
    }
  }

  void _onTextChanged() {
    if (_showError && _controller.text.trim().isNotEmpty) {
      setState(() => _showError = false);
    } else {
      setState(() {});
    }
  }

  void _save() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() => _showError = true);
      return;
    }

    widget.onSave(text);
    _timer?.cancel();
    setState(() {
      _showError = false;
      _showSuccess = true;
    });

    _timer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() => _showSuccess = false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = _controller.text.trim().isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Semantics(
                label: widget.hintText,
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.words,
                  style: HomeDesignTokens.cardTitle(
                    color: HomeDesignTokens.darkText,
                  ).copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: widget.hintText,
                    hintStyle: HomeDesignTokens.cardSubtitle(
                      color: HomeDesignTokens.mutedText,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: _showError
                            ? HomeDesignTokens.numbersCard
                            : HomeDesignTokens.settingsCardBorder,
                        width: _showError ? 2.0 : 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: _showError
                            ? HomeDesignTokens.numbersCard
                            : HomeDesignTokens.settingsCardBorder,
                        width: _showError ? 2.0 : 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color:
                            _showError ? HomeDesignTokens.numbersCard : HomeDesignTokens.headerBlue,
                        width: 2,
                      ),
                    ),
                  ),
                  onSubmitted: (_) => _save(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              ),
              child: _showSuccess
                  ? Container(
                      key: const ValueKey('saved_badge'),
                      constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: HomeDesignTokens.checkmarkGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: HomeDesignTokens.checkmarkGreen,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: HomeDesignTokens.checkmarkGreen,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.savedText,
                            style: HomeDesignTokens.cardSubtitle(
                              color: HomeDesignTokens.darkText,
                            ).copyWith(
                              color: HomeDesignTokens.checkmarkGreen,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Semantics(
                      button: true,
                      enabled: true,
                      label: widget.saveText,
                      child: ElevatedButton(
                        key: const ValueKey('save_btn'),
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HomeDesignTokens.headerBlue,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                              HomeDesignTokens.navInactive.withValues(alpha: 0.4),
                          disabledForegroundColor: Colors.white,
                          elevation: isEmpty ? 0 : 2,
                          minimumSize: const Size(88, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        child: Text(
                          widget.saveText,
                          style: HomeDesignTokens.cardTitle(
                            color: Colors.white,
                          ).copyWith(fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
            ),
          ],
        ),
        if (_showError) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.emptyErrorText,
              style: HomeDesignTokens.cardSubtitle(
                color: HomeDesignTokens.numbersCard,
              ).copyWith(fontSize: 12),
            ),
          ),
        ],
      ],
    );
  }
}
