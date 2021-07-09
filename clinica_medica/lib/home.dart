import 'package:clinic_app_01/login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  // ignore: non_constant_identifier_names
  final _LTabs = <Tab> [
    Tab(text: 'Menu'),
    Tab(icon: Icon(Icons.people), text: 'Conta')
  ];




  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _LTabs.length, 
      child: Scaffold(
        appBar: AppBar(
        
          centerTitle: true,
          title: Text('Home',
          style: TextStyle(
            fontSize: 15
            ),
          ),
          backgroundColor: Color(0xff72D5C0),
          toolbarHeight: 140,

          bottom: TabBar(
            tabs: _LTabs,
          ),
        ),

          body: TabBarView(
            children: [
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children:[ 
                    Padding(padding: EdgeInsets.only(top: 40)),

 ///////////////////////////////////////// PRIMEIRA ROW //////////////////////////////////////////////////////                   
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 90,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0,2),
                              blurRadius: 7
                            )
                          ]
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/IconAtendente.png', width: 40),
                            Text('Gerenciar Atendente',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400
                            ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0,2),
                              blurRadius: 7
                            )
                          ]
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/IconMedico.png', width: 40),
                            Text('Gerenciamento Médico',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400
                            ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0,2),
                              blurRadius: 7
                            )
                          ]
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/IconPaciente.png', width: 40),
                            Text('Gerenciar Paciente',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10
                              )
                              )
                          ],
                        ),
                      ),
                    ],
                  ),

/////////////////////////////////////////////// SEGUNDA ROW /////////////////////////////////////////////////
                      Padding(padding: EdgeInsets.all(30)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 90,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0,2),
                              blurRadius: 7
                            )
                          ]
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/IconAgendamentos.png', width: 40),
                            Text('Gerenciar Agendamento',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w400
                              )
                              )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0,2),
                              blurRadius: 7
                            )
                          ]
                        ),
                         padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/IconConsultas.png', width: 40),
                            Text('Gerenciar Consultas',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400
                              )
                              )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0,2),
                              blurRadius: 7
                            )
                          ]
                        ),
                         padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/IconExames.png', width: 40),
                            Text('Gerenciar Exames',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400
                              )
                              )
                          ],
                        ),
                      ),
                    ],
                  ),

/////////////////////////////////////////////// TERCEIRA E ULTIMA ROW ///////////////////////////////////////////////
            
             Padding(padding: EdgeInsets.all(30)),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.all(16)),
                      Container(
                        width: 90,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0,2),
                              blurRadius: 7
                            )
                          ]
                        ),
                         padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/IconMedicamentos.png', width: 40),
                            Text('Gerenciar Medicamentos',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w400
                              )
                              )
                          ],
                        ),
                      ),

                      Padding(padding: EdgeInsets.all(16)),
                      Container(
                        width: 90,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0,2),
                              blurRadius: 7
                            )
                          ]
                        ),
                         padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/iconProntuarios.png', width: 40),
                            Text('Gerenciar Prontuários',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w400
                              )
                              )
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                  ]
              ),







//////////////////////////////////////////// MINHA CONTA //////////////////////////////////////////////////////////////
 
              new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 25)),
                    Image.asset('assets/images/account.png', width: 100),
                    Padding(padding: EdgeInsets.only(bottom: 50)),


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      
                       children: [
                         Padding(padding: EdgeInsets.only(top: 0, left: 40, bottom: 0)),
                         Icon(Icons.people_alt, size: 18),
                         Padding(padding: EdgeInsets.all(5)),
                         
                        Text('Nome',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14
                        )
                        ),
                       ]
                    ),
                    Padding(padding: EdgeInsets.only(top:10)),

                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Padding(padding: EdgeInsets.only(left: 68)),
                         
                         
                        Text('John Doe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12
                        )
                        ),
                       ]
                   ),
                    Padding(padding: EdgeInsets.only(top:20)),
                    

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Padding(padding: EdgeInsets.only(left: 40)),
                         Icon(Icons.mail, size: 18),
                         Padding(padding: EdgeInsets.all(5)),
                         
                        Text('Email',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14
                        )
                        ),
                       ]
                    ),
                    Padding(padding: EdgeInsets.only(top:10)),

                    Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Padding(padding: EdgeInsets.only(left: 68)),
                         
                         
                        Text('john_Doe@gmail.com',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12
                        )
                        ),
                       ]
                   ),
                   Padding(padding: EdgeInsets.all(10)),
                   // ignore: deprecated_member_use
                   FlatButton(
                     height: 35,
                     minWidth: 370,
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4.0)
                    ),
                    onPressed: (){
                      Navigator.push(
                              context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                        ));
                                },
                                color: Color(0xff001623),
                                child: Text(
                                        'Sair',
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.0,
                                    ),
                                    )
                                    )

                  ],
                  

              ),
                ],
              ),
      ),
      );
  }
}