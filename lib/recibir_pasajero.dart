import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecibirPasajeroPage extends StatefulWidget {
  const RecibirPasajeroPage({super.key});

  @override
  _RecibirPasajeroPageState createState() => _RecibirPasajeroPageState();
}

class _RecibirPasajeroPageState extends State<RecibirPasajeroPage> {
  double tarifa = 0;
  double cargos = 0;
  int calificacion = 0;
  bool mostrarFormulario = false;
  bool mostrarModal = false;

  final formatoMoneda = NumberFormat.currency(locale: "es_CO", symbol: "\$");

  double get iva => tarifa * 0.16;
  double get totalPasajero => tarifa + cargos;
  double get ganancias => tarifa - iva;

  void actualizarValores(double nuevaTarifa, double nuevosCargos) {
    setState(() {
      tarifa = nuevaTarifa;
      cargos = nuevosCargos;
      mostrarFormulario = false;
    });
  }

  void calificar(int valor) {
    setState(() {
      calificacion = valor;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        mostrarModal = false;
        calificacion = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f9fb),
      body: Center(
        child: Container(
          width: 360,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Card azul
              Container(
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Color(0xff0064ff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text("Recibir del pasajero", style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                    Text(formatoMoneda.format(totalPasajero),
                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // Detalles
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xfff4f6fa),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    filaDetalle("Tarifa del Viaje", formatoMoneda.format(tarifa)),
                    filaDetalle("Descuento del pasajero (IVA 16%)", formatoMoneda.format(iva)),
                    filaDetalle("Cargos", formatoMoneda.format(cargos)),
                  ],
                ),
              ),

              // Ganancias
              Text("Tus ganancias: ${formatoMoneda.format(ganancias)}",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),

              SizedBox(height: 15),

              // Botones
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                      onPressed: () => setState(() => mostrarFormulario = true),
                      child: Text("Otro monto", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xff0064ff)),
                      onPressed: () => setState(() => mostrarModal = true),
                      child: Text("Pago recibido"),
                    ),
                  ),
                ],
              ),

              // Formulario
              if (mostrarFormulario) ...[
                SizedBox(height: 15),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Tarifa del viaje"),
                  onChanged: (value) => tarifa = double.tryParse(value) ?? 0,
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Cargos"),
                  onChanged: (value) => cargos = double.tryParse(value) ?? 0,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => actualizarValores(tarifa, cargos),
                  child: Text("Aceptar"),
                ),
              ],

              // Modal
              if (mostrarModal)
                Center(
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Califica el viaje:"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () => calificar(index + 1),
                              child: Icon(Icons.star,
                                  color: index < calificacion ? Colors.amber : Colors.grey, size: 30),
                            );
                          }),
                        ),
                        if (calificacion > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text("✅ Viaje finalizado",
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filaDetalle(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(titulo), Text(valor)],
      ),
    );
  }
}