/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_02_a06_07

  @Level:         1

  @Assertion:       1.3.2(6) The syntax of floating point literals is:
                       FloatLiteralSuffix
                           : 'f16' | 'f32' | 'f64'
                           ;
                       FloatLiteral
                           : (DecimalLiteral DecimalExponent
                                | DecimalFraction DecimalExponent?
                                | (DecimalLiteral DecimalFraction) DecimalExponent?) FloatLiteralSuffix?
                           | (Hexadecimalprefix (HexadecimalDigits
                                                | HexadecimalFraction
                                                | (HexadecimalDigits HexadecimalFraction)) HexadecimalExponent)
                       DecimalFraction
                           : '.' DecimalFragment
                           ;
                       DecimalFragment
                           : DecimalDigit (DecimalDigit | '_')*
                           ;
                       DecimalExponent
                           : FloatE Sign? DecimalFragment
                           ;
                       HexadecimalFraction
                           : '.' HexadecimalDigits
                           ;
                       HexadecimalExponent
                           : FloatP Sign? DecimalFragment
                           ;
                    FloatE
                    : [eE]
                    ;
                    FloatP
                    : [pP]
                    ;
                    Sign
                    : [-]
                    ;
                    Hexadecimalprefix
                        : '0' [xX]
                        ;

  @Description:     Check positive cases for `(DecimalLiteral DecimalExponent
                                            | DecimalFraction DecimalExponent?
                                            | (DecimalLiteral DecimalFraction) DecimalExponent?) FloatLiteralSuffix?`
                    with the 'f64' suffix.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    // DecimalLiteral DecimalExponent
    let a = 1e0f64 + 10e00f64 + 1_e0_f64 + 100e000f64 + 10_e00_f64 + 1_0e0_0f64 + 1__e0__f64 + 1000E0f64 + 100_E00f64 +
            10_0E0_f64 + 10__E000f64 + 1_00E00_f64 + 1_0_E0_0f64 + 1__0E0__f64 + 1___e-0f64 + 2e-00f64 + 3e-0_f64 +
            4e-000f64 + 5e-00_f64 + 6e-0_0f64 + 7e-0__f64 + 8E-0f64 + 9E-00f64 + 11E-0_f64 + 12E-000f64 + 13E-00_f64 +
            14E-0_0f64 + 15E-0__f64
    Assert.approxEquals(1573.0, a)
    // DecimalFraction DecimalExponent?
    let b = .0f64 - .00e0f64 - .0_e00f64 - .000e0_f64 - .00_e000f64 - .0_0e00_f64 - .0__e0_0f64 - .0000e0__f64 -
            .000_E0f64 - .00_0E00f64 - .00__E0_f64 - .0_00E000f64 - .0_0_E00_f64 - .0__0E0_0f64 - .0___E0__f64 -
            .1e-0f64 - .2e-00f64 - .3e-0_f64 - .4e-000f64 - .5e-00_f64 - .6e-0_0f64 - .7e-0__f64 - .8E-0f64 -
            .9E-00f64 - .01E-0_f64 - .02E-000f64 - .03E-00_f64 - .04E-0_0f64 - .05E-0__f64
    Assert.approxEquals(-4.65, b)
    // (DecimalLiteral DecimalFraction) DecimalExponent?
    let c = 1.0f64 + 10.00e0f64 + 1_.0_E0f64 + 100.000e-0f64 + 10_.00_E-0f64 + 1_0.0_0e00f64 + 1__.0__E00f64 +
            1000.0000e-00f64 + 100_.000_E-00f64 + 10_0.00_0e0_f64 + 10__.00__E0_f64 + 1_00.0_00e-0_f64 +
            1_0_.0_0_E-0_f64 + 1__0.0__0e000f64 + 1___.0___E000f64 + 2.1e-000f64
    Assert.approxEquals(1466.1, c)
}
