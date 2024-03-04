import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/login/login_bloc.dart';
import 'package:global_gathering_application_1/repository/auth/auth_repository.dart';
import 'package:global_gathering_application_1/repository/auth/auth_repository_impl.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';
import 'package:global_gathering_application_1/screens/register/register-screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  // Form
  final _formLogin = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

  late AuthRepository authRepository;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _loginBloc = LoginBloc(authRepository);
    super.initState();
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BlocProvider.value(
          value: _loginBloc,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocConsumer<LoginBloc, LoginState>(
              buildWhen: (context, state) {
                return state is LoginInitial ||
                    state is DoLoginSuccess ||
                    state is DoLoginError ||
                    state is DoLoginLoading;
              },
              builder: (context, state) {
                if (state is DoLoginSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  });
                } else if (state is DoLoginError) {
                  return const Text('Login error');
                } else if (state is DoLoginLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(child: _buildLoginForm());
              },
              listener: (BuildContext context, LoginState state) {},
            ),
          ),
        ),
      ],
    );
  }

  _buildLoginForm() {
    return Column(
      children: [
        Center(
          child: Image.network(
            'https://static.vecteezy.com/system/resources/previews/018/742/271/original/3d-minimal-airplane-white-aircraft-3d-illustration-free-png.png',
            width: double.infinity,
            height: 150,
          ),
        ),
        Form(
          key: _formLogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Welcome Back! 👋',
                textAlign: TextAlign.start,
                style: GoogleFonts.manrope(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Hello again, you've been missed!",
                textAlign: TextAlign.start,
                style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 153, 158, 161),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Username',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(255, 20, 12, 71),
                ),
              ),
              const SizedBox(
                height: 4, // Reducir la altura del SizedBox
              ),
              TextFormField(
                controller: userTextController,
                textAlign: TextAlign.start, // Alinear el texto a la izquierda
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal:
                        16, // Ajustar la altura y el espaciado a la izquierda
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.red), // Color del borde de error
                    borderRadius: BorderRadius.circular(19.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Password',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(255, 20, 12, 71),
                ),
              ),
              const SizedBox(
                height: 4, // Reducir la altura del SizedBox
              ),
              TextFormField(
                controller: passTextController,
                obscureText: true,
                textAlign: TextAlign.start, // Alinear el texto a la izquierda
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal:
                        16, // Ajustar la altura y el espaciado a la izquierda
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.red), // Color del borde de error
                    borderRadius: BorderRadius.circular(19.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                        0xFF140C47), // Color deseado (en formato hexadecimal ARGB)
                  ),
                  child: Text(
                    'Login',
                    style:
                        GoogleFonts.manrope(color: Colors.white, fontSize: 17),
                  ),
                  onPressed: () {
                    if (_formLogin.currentState!.validate()) {
                      _loginBloc.add(DoLoginEvent(
                        userTextController.text,
                        passTextController.text,
                      ));
                    }
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 153, 158, 161),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.manrope(
                            color: Color.fromARGB(255, 65, 6,
                                175), // Puedes ajustar el color según tu preferencia
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
