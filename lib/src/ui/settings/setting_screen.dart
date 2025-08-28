import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/ui/settings/setting_action.dart';
import 'package:hr_self_service/src/ui/settings/setting_provider.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingViewModelProvider);
    final viewModel = ref.read(settingViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Theme Color'),
            trailing: CircleAvatar(backgroundColor: state.currentSetting.seedColor),
            onTap: () async {
              Color pickedColor = state.currentSetting.seedColor;
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Pick Theme Color'),
                  content: ColorPicker(
                    pickerColor: pickedColor,
                    onColorChanged: (newColor) {
                      pickedColor = newColor;
                    },
                    enableAlpha: true,
                    displayThumbColor: true,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(pickedColor),
                      child: const Text('Select')
                    )
                  ],
                )
              ).then((selectedColor) { // Save the returned Color
                if (selectedColor != null && selectedColor is Color) {
                  viewModel.onAction(OnPickingSeedColor(selectedColor));
                }
              });
            },
          ),

          ListTile(
            title: const Text('Font Family'),
            trailing: Text(state.currentSetting.fontFamily),
            onTap: () async {
              final fonts = ['Roboto', 'Open Sans', 'Lato', 'Montserrat', 'Noto Sans'];
              final selectedFont = await showModalBottomSheet(
                context: context,
                builder: (context) => ListView(
                  children: fonts.map((font) => ListTile(
                    title: Text(font, style: TextStyle(fontFamily: font)),
                    onTap: () => Navigator.pop(context, font),
                  )).toList(),
                )
              );

              if (selectedFont != null) {
                viewModel.onAction(OnPickingFontFamily(selectedFont));
              }
            } ,
          ),
        ],
      ),
    );
  }
}