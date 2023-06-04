import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../constants/index.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController searchTextEditingController;
  final Stream<bool> buttonClearStream;
  final ValueChanged<String> onTextChanged;

  const CustomSearchBar({
    Key? key,
    required this.searchTextEditingController,
    required this.buttonClearStream,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late BehaviorSubject<bool> buttonClearController;

  @override
  void initState() {
    super.initState();
    buttonClearController = BehaviorSubject<bool>.seeded(false);
    widget.buttonClearStream.listen((event) {
      buttonClearController.add(event);
    });
  }

  @override
  void dispose() {
    buttonClearController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: Sizes.dimen_50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.appBg2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: Sizes.dimen_10,
          ),
          const Icon(
            Icons.search_rounded,
            color: AppColors.white,
            size: Sizes.dimen_24,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: widget.searchTextEditingController,
              onChanged: widget.onTextChanged,
              decoration: const InputDecoration.collapsed(
                hintText: 'Search here...',
                hintStyle: TextStyle(color: AppColors.white),
              ),
              cursorColor: AppColors.white,
              style: const TextStyle(color: AppColors.appText),
            ),
          ),
          StreamBuilder<bool>(
            stream: buttonClearController.stream,
            builder: (context, snapshot) {
              return snapshot.data == true
                  ? GestureDetector(
                      onTap: () {
                        widget.searchTextEditingController.clear();
                        buttonClearController.add(false);
                        widget.onTextChanged('');
                      },
                      child: const Icon(
                        Icons.clear_rounded,
                        color: AppColors.greyColor,
                        size: 20,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
