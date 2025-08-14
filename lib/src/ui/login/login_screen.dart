import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/ui/login/login_action.dart';
import 'package:hr_self_service/src/ui/login/login_provider.dart';
import '../personnel/personnel_list_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginViewModelProvider, (previous, next) { // Listen to state change
      if (next.isLoginSuccessful && !next.isLoading && next.error.isEmpty) {
        // Successful login
        if (mounted) {
          Navigator.of(context).pushReplacement( // Use push() to keep the departed screen on the nav stack
            MaterialPageRoute(builder: (_) => const PersonnelListScreen())
          );
        }
      }
    });

    final viewModel = ref.read(loginViewModelProvider.notifier);
    final state = ref.watch(loginViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to HR Self Service'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'george.bluth@reqres.in',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofocus: true,
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.password),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    viewModel.onAction(OnTogglePasswordVisibility());
                  },
                  icon: Icon(
                    state.isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              ),
              textInputAction: TextInputAction.done,
              obscureText: state.isPasswordHidden,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isLoading ? null : _onLoginPressed, // Make sure there is only one ongoing request
                child: state.isLoading
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text('Login'),
              ),
            ),

            const SizedBox(height: 24),

            if (state.error.isNotEmpty)
              Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              )
          ],
        ),
      ),
    );
  }

  Future<void> _onLoginPressed() async {
    final viewModel = ref.read(loginViewModelProvider.notifier);
    await viewModel.onAction(
      OnLoginClick(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }
}