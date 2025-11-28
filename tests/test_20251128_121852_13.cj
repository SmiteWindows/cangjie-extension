/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_02_a01_01

  @Level:         1

  @Assertion:    2.3.2(1) For an instance of the class/interface, using obj as TargetType to cast its (static) type
                 to TargetType. See section The as Operator for the usuage of the as operator and the type cast rules.

  @Description:  Check that using the as operator can cast the obj of class/interface to a another type

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

interface BaseI {}
interface ImplI <: BaseI{}

open class BaseCls <: BaseI {}
class ImplCls <: BaseCls & ImplI {}

main(): Unit {

    let b = BaseCls()
    let i = ImplCls()

    var i2b = i as BaseCls
    var i2bI = i as BaseI

    Assert.isTrue((i2b).getOrThrow() is BaseCls)
    Assert.isTrue((i2b).getOrThrow() is BaseI)
    
    Assert.isTrue((i2bI).getOrThrow() is ImplCls)
    Assert.isTrue((i2bI).getOrThrow() is BaseI)
}
