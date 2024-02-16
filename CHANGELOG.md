## 1.0.2

- **Refactor:** Replaced `part of` directives with _string_ to prevent dart analysis warnings.<br>
- **Vendor"** Added `lints` package to dev dependencies to ensure consistent linting rules across the project.<br>
- **Vendor"** Update `flutter_lints` in dev dependencies.
- **Chore:** Update _example_ lint version.<br>

## 1.0.1

- **Fix:** `onTap` was not detected on mobile.<br>
- **Fix:** Overflow on Dynamic example.<br>
- **Chore:** Remove default to Material 3 on example.<br>

## 1.0.0 Production release

- **Feature:** `onHoverExit` property has been added to _Circulito_.<br>
- **Docs:** Update _Circulito_ documentation.<br>
- **Docs:** Update _README_ with examples.<br>
- **Docs:** Update _CHANGELOG_.<br>
- **Test:** Add _Utils_ test.<br>
- **Test:** Update main test files.<br>
- **Chore:** Update example main file with new examples.<br>
- **Chore:** Add example Genders.<br>
- **Chore:** Add example Apple fitness.<br>
- **Chore:** Add example Countdown.<br>
- **Chore:** Add example Dynamic pie.<br>
- **Chore:** Reorganize files and folders.<br>

## 0.8.0

- **Feature:** `CirculitoBorder` property has been added to _CirculitoDecoration_. Now the _background_ of _Circulito_ or each _section_ can have its own _border_.<br>
- **Docs:** Update documentation to _CirculitoDecoration_.<br>
- **Docs:** Update _README_.<br>

## 0.7.0

- **Feature:** `CirculitoShadow` property has been added to _CirculitoDecoration_. Now the _background_ of _Circulito_ or each _section_ can have its own _shadow_.<br>
- **Docs:** Update documentation to _CirculitoDecoration_.<br>
- **Docs:** Update _README_.<br>
- **Chore:** Update main example to add shadow to background.<br>

## 0.6.0

- **Feature:** `ChildStackingOrder` property has been added.<br>
- **Fix:** Resolved an issue where _child_ interactions with the _Circulito_ widget were not functioning correctly.<br>
- **Fix:** Mouse pointer was not changing on Circulito child on hover.<br>
- **Performance:** Prevent unnecessary draws when no animation is provided.<br>
- **Performance:** Delete unnessary _if condition_ on _CirculitoPainter_.<br>
- **Docs:** Update _README_.<br>
- **Refactor:** `Circulito` main file.<br>
- **Chore:** Update main example.<br>

## 0.5.0

- **BREAKING CHANGE:** `color` and `hoverColor` are now included in `CirculitoDecoration` for _CirculitoSection_ and _CirculitoBackground_.<br>
- **Feature:** `gradient` decoration has been added for _CirculitoSection_ and _CirculitoBackground_.<br>
- **Performance:** Delete unnessary sentences on _CirculitoPainter_.<br>
- **Docs:** Update Documentation.<br>
- **Docs:** Update _README_.<br>
- **Test:** Update main test.<br>
- **Chore:** Update main example.<br>

## 0.4.0

- **Feature:** `animation` has been added.<br>
- **Performance:** Prevent _Circulito_ redraw when parent calls _setState_.<br>
- **Docs:** Update Documentation.<br>
- **Docs:** Update _README_.<br>
- **Chore:** Reorganize files and folders.<br>

## 0.3.2

- **Chore:** Allow values as zero (`0`) on _sections_.<br>

## 0.3.1

- **Performance:** Making `Circulito` Statefull widget for better practice.<br>
- **Performance:** Delete unnessary sentence on _Utils_.<br>
- **Chore:** Delete default export _Utils_ in Circulito.<br>

## 0.3.0

- **BREAKING CHANGE:** `percentage` is now called `value` in `Circulito Section`.<br>
- **BREAKING CHANGE:** `backgroundColor` has been changed to `CirculitoBackground`.<br>
- **BREAKING CHANGE:** `padding` has been changed from `EdgeInset` to `double`
  to make _hover_ selections more precise.<br>
- **Feature:** Now the percentage can be calculated automatically passing `amount` arguments.<br>
- **Feature:** _Sections_ are now interactable.<br>
- **Feature:** _Background_ is now interactable.<br>
- **Feature:** `onTap` on _sections_ has been added.<br>
- **Feature:** `onTap` on _background_ has been added.<br>
- **Feature:** `onHover` on _sections_ has been added.<br>
- **Feature:** `onHover` on _background_ has been added.<br>
- **Feature:** `Change Mouse Pointer` when _onTap_ is not null.<br>
- **Chore:** Reorganize files and folders.<br>

## 0.2.0

- **Feature:** `child`: Now a widget can be shown over the wheel.<br>
- **Docs:** Update _README_.<br>

## 0.1.0

- **Feature:** `startPoint`: Defines the starting point to draw the wheel.<br>
- **Feature:** `circulitoDirection`: Determines the direction of the wheel.<br>
- **Docs:** Update _README_.<br>
- **Docs:** Update circulito classes documentation.<br>

## 0.0.2

- **BREAKING CHANGE:** `radius` is now called `maxSize` and required.<br>
- **Fix:** Some issues when drawing `Circulito` inside an infinite size parent like
- **Feature:** `isCenter`: Allow to center the widget.<br>
- **Feature:** `padding`: Add a padding to the widget.<br>
- **Docs:** Update _README_ and _example_.<br>
- **Docs:** Add Circulito painter class documentation.<br>

## 0.0.1 First release

- **Feature:** `background`.
- **Feature:** `section` with colors.
