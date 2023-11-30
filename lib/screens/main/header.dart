import 'package:admin_ecommerce_app/models/user.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({required this.currentUser, required this.openMenuCallback, super.key});

  final VoidCallback openMenuCallback;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(right: defaultPadding),
            child: IconButton(icon: const Icon(Icons.menu), onPressed: openMenuCallback),
          ),
          const Expanded(child: SearchBar()),
          ProfileCard(currentUser),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        fillColor: colorSecondary,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        suffixIcon: Container(
          width: 48,
          padding: const EdgeInsets.all(defaultPadding * 0.9),
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          decoration: const BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SvgPicture.asset('assets/icons/ic_search.svg'),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard(this.currentUser, {super.key});

  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(currentUser.pic!, height: 48, width: 48, fit: BoxFit.cover),
      ),
    );
  }
}
