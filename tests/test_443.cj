/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_04_01_a02_03

  @Level:         1

  @Assertion:    2.4.1(2) 
                    func test() {
                    type Point2D = (Float64, Float64) // error: type alias can only be defined at top-level
                    type Point3D = (Float64, Float64, Float64) // error: type alias can only be defined at top-level
                    }

  @Description:  Negative example of the test, case 2

  @Mode:         compileonly

  @Negative:     yes

*/

func test() {
    type Point3D = (Float64, Float64, Float64) // error: type alias can only be defined at top-level
}

main(): Unit {}

