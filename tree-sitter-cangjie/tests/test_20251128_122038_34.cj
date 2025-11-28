/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Structure:       complex-aux
  @Dependencies:
*/
package test

var vf32_11: Float32 = Init.initFloat32("A1")
var vf32_12: Float32 = Init.initFloat32("A2") + foo3()
var vf32_13: Float32 = Init.initFloat32("A3")

func foo1(): Float32 {
    1.1
}
