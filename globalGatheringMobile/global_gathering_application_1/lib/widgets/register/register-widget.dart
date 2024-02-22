import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/register/register_bloc.dart';
import 'package:global_gathering_application_1/model/dto/register_dto.dart';
import 'package:global_gathering_application_1/repository/auth/auth_repository.dart';
import 'package:global_gathering_application_1/repository/auth/auth_repository_impl.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';
import 'package:global_gathering_application_1/screens/login/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  //Form

  final _formRegister = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final nameTextController = TextEditingController();

  late AuthRepository authRepository;
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _registerBloc = RegisterBloc(authRepository);
    super.initState();
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    emailTextController.dispose();
    nameTextController.dispose();
    _registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _registerBloc,
      child: ListView(
        children: [
          BlocConsumer<RegisterBloc, RegisterState>(
            buildWhen: (context, state) {
              return state is RegisterInitial ||
                  state is DoRegisterSuccess ||
                  state is DoRegisterError ||
                  state is DoRegisterLoading;
            },
            builder: (context, state) {
              if (state is DoRegisterSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomePage(name: state.userRegister.nombre!),
                    ),
                  );
                });
              } else if (state is DoRegisterError) {
                return const Text('Register failure');
              } else if (state is DoRegisterLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(child: _buildRegisterForm());
            },
            listener: (BuildContext context, RegisterState state) {},
          )
        ],
      ),
    );
  }

  _buildRegisterForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formRegister,
        child: Column(
          children: [
            Center(
              child: Image.network(
                'https://rodrigovarejao.com/wp-content/uploads/2020/03/e1b15bb6c52837a140a593a99a3c3066-sticker.png',
                width: double.infinity,
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Text(
                    'Create an account',
                    style: GoogleFonts.manrope(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Connect with your friends today!",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 153, 158, 161),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
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
            const SizedBox(height: 16),
            Text(
              'Name',
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
              controller: nameTextController,
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
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            Text(
              'Email',
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
              controller: emailTextController,
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
            const SizedBox(height: 46),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF140C47),
                ),
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                onPressed: () {
                  if (_formRegister.currentState!.validate()) {
                    _registerBloc.add(DoRegisterEvent(
                      registerDto: RegisterDto(
                        email: emailTextController.text,
                        fullName: nameTextController.text,
                        password: passTextController.text,
                        username: userTextController.text,
                        verifyPassword: passTextController.text,
                      ),
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
                      "Already have an account? ",
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
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
    );
  }
}
