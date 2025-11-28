/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_04_02_a08_01

  @Level:         1

  @Assertion:    2.4.2(8)
                    enum TimeUnit {
                        Day | Month | Year
                    }
                    type Time = TimeUnit
                    var a = Time.Day
                    var b = Time.Month // Use type alias Time to access constructors in TimeUnit

  @Description:  Check example

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

enum TimeUnit {
    Day | Month | Year
}
type Time = TimeUnit
var a = Time.Day
var b = Time.Month // Use type alias Time to access constructors in TimeUnit

main(): Unit {
    Assert.isTrue(a is TimeUnit)
    Assert.isTrue(b is TimeUnit)
    Assert.isTrue(match (a) {
        case TimeUnit.Day => true
        case _ => false
    })
    Assert.isTrue(match (b) {
        case TimeUnit.Month => true
        case _ => false
    })
}
