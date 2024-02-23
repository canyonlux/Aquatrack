import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaterDropButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;

  WaterDropButton({required this.onTap, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipPath(
        clipper: WaterDropClipper(),
        child: Container(
          width: 100, // Ajusta el ancho aquí
          height: 200, // Ajusta la altura aquí
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover, // Asegura que la imagen cubra todo el contenedor
          ),
        ),
      ),
    );
  }
}
class WaterDropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(size.width, size.height * 0.7, 0, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width / 2, size.height * 0.7, size.width / 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}