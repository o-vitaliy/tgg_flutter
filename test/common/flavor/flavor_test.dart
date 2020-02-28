import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/helpers/map_utils.dart';

import '../../data/mocks.dart';

main() {
  Flavor flavor;
  setUpAll(() {
    flavor = Flavor.create(merge(json.decode(mockedFlavorDefault),
        json.decode(mockedFlavorGame)["entries"]));
  });
  group("flavor", () {
    test("get", () {
      expect(flavor.get("facebook:color"), "#3b5998");
    });
    test("not existing key", () {
      expect(flavor.get("facebook:color:color"), "facebook:color:color");
    });

    test("with params", () {
      final key = "modes:head_to_head:home:your_pin";
      final pin = "3333";
      final params = {"pin": pin};
      expect(flavor.get(key, params: params), "Your code is: $pin");
    });

    test("with int params", () {
      final key = "modes:head_to_head:home:your_pin";
      final pin = 3333;
      final params = {"pin": pin};
      expect(flavor.get(key, params: params), "Your code is: $pin");
    });
  });

  group("iterable", () {
    test("get ", () {
      expect(flavor.iterable(tryAgainText, 6),
          "No dice. {{given}} is incorrect. Try again.");
      expect(flavor.iterable(tryAgainText, 9),
          "{{given}} is incorrect. Try again.");
    });

    test("with params", () {
      final given = "3333";
      final params = {"given": given};
      expect(flavor.iterable(tryAgainText, 6, params: params),
          "No dice. $given is incorrect. Try again.");

      expect(flavor.iterable(tryAgainText, 9, params: params),
          "$given is incorrect. Try again.");
    });
  });

  group("applyParams", () {
    test("with no arguments", () {
      final text = "lorem";
      expect(flavor.applyParams(text, null), text);
    });
    test("with single argument", () {
      final text = "lorem {{given1}}";
      final given1 = "1111";
      final params = {"given1": given1};
      expect(flavor.applyParams(text, params), "lorem $given1");
    });
    test("with two arguments", () {
      final text = "lorem {{given1}}   {{given0}}";
      final given1 = "1111";
      final given0 = "0000";
      final params = {"given0": given0, "given1": given1};
      expect(flavor.applyParams(text, params), "lorem $given1   $given0");
    });

    test("extra arguments ", () {
      final text = "lorem";
      final given1 = "1111";
      final given0 = "0000";
      final params = {"given0": given0, "given1": given1};
      expect(flavor.applyParams(text, params), "lorem");
    });
  });

  group("get color", () {
    test("background", () {
      /// "background:color": "#A600F9" 10879225 0xFFA600F9
      final color = flavor.color("background:color");
      expect(color.color, Color(4289069305));
    });
  });
}
