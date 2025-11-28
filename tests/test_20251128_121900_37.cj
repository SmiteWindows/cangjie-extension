/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a23_07

  @Level:         1

  @Comment:      It is a header of a list of assetions which include current assertion: 
                 In addition to the preceding syntax definitions, local variables may be introduced 
                 in the following scenarios:

  @Assertion:    3.3.1(23) Pattern after case in the match expression. For details, see Pattern Matching Expressions.

  @Description:  Check that introduced with typePattern local variable is not visible out of scope: 
                 before match expression.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

open class Figure { 
    var x: Int32 = 1 
    var y: Int32 = 2 

    init(x: Int32, y: Int32) { 
        this.x = x 
        this.y = y 
    } 
} 

func getFigureArea(figure: Figure) {
    print("${myTmpFigure.x}")
    var figureArea: Int32 = match (figure) { 
        case myTmpFigure: Figure => 
            myTmpFigure.x * myTmpFigure.y
        case _ => 0 
    } 

    return figureArea
}

main() {
    let myFigure = Figure(5, 12) 
    var myFigureArea = getFigureArea(myFigure)
}
