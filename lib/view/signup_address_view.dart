import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/common/utils.dart';
import 'package:flutter_banking/model/place.dart';
import 'package:flutter_banking/view/search_place_delegate.dart';
import 'package:flutter_banking/view/signup_form.dart';
import 'package:flutter_banking/widgets/signup_title.dart';

class SignUpAddressView extends StatefulWidget {
  final String title;
  final VoidCallback nextPage;

  SignUpAddressView({this.title, this.nextPage});

  @override
  _SignUpAddressViewState createState() => _SignUpAddressViewState();
}

class _SignUpAddressViewState extends State<SignUpAddressView> {
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _houseNumberFocus = FocusNode();
  final FocusNode _postCodeFocus = FocusNode();
  final FocusNode _placeFocus = FocusNode();

  final SearchPlaceDelegate _delegate = SearchPlaceDelegate();

  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  PlaceNew place;

  @override
  Widget build(BuildContext context) {
    return place == null
        ? SignUpFormListView(
            children: [SignUpTitle(title: widget.title), _buildSearchField()])
        : SignUpFormListView(
            children: [
              SignUpTitle(title: widget.title),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SignUpFormField('Street',
                        controller: _streetController,
                        autofillHints: [AutofillHints.fullStreetAddress],
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        focusId: _streetFocus,
                        nextFocusId: _houseNumberFocus),
                  ),
                  SizedBox(
                    width: Dimens.inputFieldHorizontalPadding,
                  ),
                  Expanded(
                    flex: 1,
                    child: SignUpFormField('Number',
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.characters,
                        focusId: _houseNumberFocus,
                        nextFocusId: _postCodeFocus),
                  ),
                ],
              ),
              SignUpFormField('Postal code',
                  controller: _postalCodeController,
                  autofillHints: [AutofillHints.postalCode],
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.characters,
                  focusId: _postCodeFocus,
                  nextFocusId: _placeFocus),
              SignUpFormField(
                'City',
                controller: _cityController,
                autofillHints: [AutofillHints.addressCity],
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                focusId: _placeFocus,
                onFieldSubmitted: widget.nextPage,
              ),
            ],
          );
  }

  SignUpFormField _buildSearchField() {
    return SignUpFormField('Search',
        readonly: true,
        autofocus: false,
        focusId: AlwaysDisabledFocusNode(), onTap: () async {
      place = await showSearch<PlaceNew>(
        context: context,
        delegate: _delegate,
      );

      _streetController.text = place?.address?.street ?? '';
      _numberController.text = place?.address?.streetNumber ?? '';
      _postalCodeController.text = place?.address?.postalCode ?? '';
      _cityController.text = place?.address?.city ?? '';

      setState(() {});
      Utils.unfocus();
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
