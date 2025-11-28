/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a01_01

  @Level:         1
  @Assertion:       2.1.1.3(1) Except bitwise operations, all operations defined on integer types are defined for
                    floating-point types, including arithmetic operation, relational operation,
                    self-increment/decrement operation, unary plus (minus) number operation, conditional operation, and
                    (compound) assignment operation.

  @Description:     Check that operators +, -, *, /, **, <, >, <=, >=, ==, !=, ++, --, unary +, unary -, =, +=, -=, *=,
                    /=, **= work as expected for Float64/32/16.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Comment:         See the comment on issue 6166. % is covered in another (negative) tests since remainder is not
                    meaningful for floating-point numbers even though Spec does not explicitly prohibit using it.
                    Conditional operations cannot be tested because they are not defined in Spec. ++, -- and + (unary)
                    are covered in this test because they are specifically mentioned in the excerpt from Spec this
                    assertion was based on despite not being recognized by the compiler.
  @Issue:           0006166
*/

import utils.assert.Assert

main() {
    var lhsF64: Float64 = 541197228.8974903
    let rhsF64: Float64 = 450464703.9508853
    var lhsF32: Float32 = 185328.64
    let rhsF32: Float32 = -698890.89
    var lhsF16: Float16 = 78.5
    let rhsF16: Float16 = 45.5

    Assert.approxEquals(991661932.8483756, lhsF64 + rhsF64)
    Assert.approxEquals(-513562.24, lhsF32 + rhsF32)
    Assert.approxEquals(124.0, lhsF16 + rhsF16)

    Assert.approxEquals(90732524.94660497, lhsF64 - rhsF64)
    Assert.approxEquals(884219.54, lhsF32 - rhsF32)
    Assert.approxEquals(33.0, lhsF16 - rhsF16)

    Assert.approxEquals(2.4379024949434746e17, lhsF64 * rhsF64)
    Assert.approxEquals(-129524503808.4447, lhsF32 * rhsF32)
    Assert.approxEquals(3571.75, lhsF16 * rhsF16)

    Assert.approxEquals(1.2014198318998544, lhsF64 / rhsF64)
    Assert.approxEquals(-0.265175364, lhsF32 / rhsF32)
    Assert.approxEquals(1.7252, lhsF16 / rhsF16)

    Assert.approxEquals(1.6465289910834967468655889830893e86, Float64(lhsF16) ** Float64(rhsF16))
    Assert.approxEquals(lhsF64, lhsF64 ** 1)

    Assert.isFalse(lhsF64 < rhsF64)
    Assert.isFalse(lhsF32 < rhsF32)
    Assert.isFalse(lhsF16 < rhsF16)

    Assert.isTrue(lhsF64 > rhsF64)
    Assert.isTrue(lhsF32 > rhsF32)
    Assert.isTrue(lhsF16 > rhsF16)

    Assert.isFalse(lhsF64 <= rhsF64)
    Assert.isFalse(lhsF32 <= rhsF32)
    Assert.isFalse(lhsF16 <= rhsF16)
    Assert.isTrue(lhsF64 <= lhsF64)
    Assert.isTrue(rhsF32 <= rhsF32)
    Assert.isTrue(lhsF16 <= lhsF16)
    Assert.isTrue(rhsF16 <= rhsF16)

    Assert.isTrue(lhsF64 >= rhsF64)
    Assert.isTrue(lhsF32 >= rhsF32)
    Assert.isTrue(lhsF16 >= rhsF16)
    Assert.isTrue(rhsF64 >= rhsF64)
    Assert.isTrue(lhsF32 >= lhsF32)
    Assert.isTrue(rhsF16 >= rhsF16)

    Assert.isTrue(lhsF64 == lhsF64)
    Assert.isTrue(rhsF64 == rhsF64)
    Assert.isTrue(lhsF32 == lhsF32)
    Assert.isTrue(rhsF32 == rhsF32)
    Assert.isTrue(lhsF16 == lhsF16)
    Assert.isTrue(rhsF16 == rhsF16)
    Assert.isFalse(lhsF64 == rhsF64)
    Assert.isFalse(lhsF32 == rhsF32)
    Assert.isFalse(lhsF16 == rhsF16)

    Assert.isFalse(lhsF64 != lhsF64)
    Assert.isFalse(rhsF64 != rhsF64)
    Assert.isFalse(lhsF32 != lhsF32)
    Assert.isFalse(rhsF32 != rhsF32)
    Assert.isFalse(lhsF16 != lhsF16)
    Assert.isFalse(rhsF16 != rhsF16)
    Assert.isTrue(lhsF64 != rhsF64)
    Assert.isTrue(lhsF32 != rhsF32)
    Assert.isTrue(lhsF16 != rhsF16)

    Assert.approxEquals(-541197228.8974903, -lhsF64)
    Assert.approxEquals(-185328.64, -lhsF32)
    Assert.approxEquals(-78.5, -lhsF16)

    lhsF64 = -26932.8977523
    lhsF32 = -355.56
    lhsF16 = -52.0
    Assert.equals(-26932.8977523, lhsF64)
    Assert.equals(-355.56, lhsF32)
    Assert.equals(-52.0, lhsF16)

    lhsF64 += rhsF64
    lhsF32 += rhsF32
    lhsF16 += rhsF16
    Assert.approxEquals(450437771.053133, lhsF64)
    Assert.approxEquals(-699246.45, lhsF32)
    Assert.approxEquals(-6.5, lhsF16)

    lhsF64 -= rhsF64
    lhsF32 -= rhsF32
    lhsF16 -= rhsF16
    Assert.approxEquals(-26932.8977523, lhsF64)
    Assert.approxEquals(-355.56, lhsF32)
    Assert.approxEquals(-52.0, lhsF16)

    lhsF64 *= rhsF64
    lhsF32 *= rhsF32
    lhsF16 *= rhsF16
    Assert.approxEquals(-12132319812529.283, lhsF64)
    Assert.approxEquals(248497644.84, lhsF32)
    Assert.approxEquals(-2366.0, lhsF16)

    lhsF64 /= rhsF64
    lhsF32 /= rhsF32
    lhsF16 /= rhsF16
    Assert.approxEquals(-26932.8977523, lhsF64)
    Assert.approxEquals(-355.56, lhsF32)
    Assert.approxEquals(-52.0, lhsF16)

    lhsF64 *= -1.0 // To raise a positive number to a power, not a negative one.
    lhsF64 **= -1.0
    Assert.approxEquals(3.71293133474508e-05, lhsF64)
    lhsF64 **= 1
    Assert.approxEquals(3.71293133474508e-05, lhsF64)

    // lhsF64++
    // lhsF32++
    // lhsF16++
    Assert.approxEquals(3.712931334747147444274792404961e-05, lhsF64)
    Assert.approxEquals(-355.56254, lhsF32)
    Assert.approxEquals(-52.0, lhsF16)

    Assert.approxEquals(3.712931334747147444274792404961e-05, lhsF64)
    Assert.approxEquals(-355.56254, lhsF32)
    Assert.approxEquals(-52.0, lhsF16)
}
