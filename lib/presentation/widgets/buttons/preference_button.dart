import 'package:flutter/material.dart';

class PreferenceButton extends StatefulWidget {
  final String text;
  final ValueChanged<bool> onPressed;
  final bool isSelected;

  const PreferenceButton({
    required this.text,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  _PreferenceButtonState createState() => _PreferenceButtonState();
}

class _PreferenceButtonState extends State<PreferenceButton> {
  late bool _isPressed;

  @override
  void initState() {
    super.initState();
    _isPressed = widget.isSelected;
  }

  void _toggleColor() {
    setState(() {
      _isPressed = !_isPressed;
      widget.onPressed(_isPressed); // Actualiza el valor en PreferencesScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleColor,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isPressed ? Color(0xFF7889A1) : Color(0xFFE3EDFB),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 14,
          color: _isPressed ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}


/*
class PreferenceButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const PreferenceButton({
    Key? key, 
    required this.text, 
    required this.onPressed}) : super(key: key);

  @override
  _PreferenceButtonState createState() => _PreferenceButtonState();
}

class _PreferenceButtonState extends State<PreferenceButton> {
  bool _isSelected = false;

  // Esta función se llama cada vez que se presiona el botón.
  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
    widget.onPressed(); // Llamamos al evento pasado como parámetro.
  }

  // Método que devuelve si el botón está seleccionado o no.
  bool isSeleccionado() {
    return _isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleSelection,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isSelected ? Colors.black : Colors.white, // Color de fondo
        foregroundColor: _isSelected ? Colors.white : Colors.black, // Color del texto
      ),
      child: Text(widget.text),
    );
  }
}
*/


/*
class PreferenceButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isPressed = false;

  const PreferenceButton({
    required this.text,
    required this.onPressed,
    Color? backgroundColor,
    Color? textColor,
  })  : backgroundColor = backgroundColor ?? const Color(0xFFE3EDFB),
        textColor = textColor ?? Colors.black;

  @override
  _PreferenceButtonState createState() => _PreferenceButtonState();

  // retornar si el objeto esta presionado
  bool get_isPressed() {
    return _PreferenceButtonState().get_isPressed();
  }


}

class _PreferenceButtonState extends State<PreferenceButton> {
  bool _isPressed = false;

  void _toggleColor() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  bool get_isPressed() {
    return _isPressed;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
        _toggleColor();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isPressed ? Color(0xFF7889A1) : Color(0xFFE3EDFB),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 14,
          color: _isPressed ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
*/


/*
class PreferenceButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const PreferenceButton({
    required this.text,
    required this.onPressed,
    Color? backgroundColor,
    Color? textColor,
  })  : backgroundColor =
            backgroundColor ?? const Color(0xFFE3EDFB), //Colors.teal[400];
        textColor = textColor ?? Colors.black;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        //shape: RoundedRectangleBorder(
        //  borderRadius: BorderRadius.circular(30),
        //),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: textColor,
        ),
      ),
    );
  }
}
*/