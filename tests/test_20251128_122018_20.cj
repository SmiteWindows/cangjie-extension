/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a17_01

  @Level:         1

  @Assertion:    1.2(17) For multi-line comment, the comment is terminated by the first '*'/

  @Description:  Check the first '*'/ terminates the multi-line comment with different content. 

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

*/

main() {
    // test case #1
    /*
    */
    
    // test case #2
    /*
    Check
    the
    first
    '*'
    /
    terminates
    the
    multi-line
    comment
    with
    different
    content.
    */
    
    // test case #3
    /*
    var
    
    
    override:
    
    ?(
    
    Nothing)```
    */
    
    // test case #4
    /*
    ==> 244200459522493820227781095590357143637.cj <==
    //𝔞﬽
    ==> 275669310775175098681111152149961760852.cj <==
    //꬏
    ==> 30600532430747210007274032816483287986.cj <==
    //𐭖
    ==> 307574722125307647447334773110855757863.cj <==
 / / ౸ 
    ==> 310600060999260779359248432955673468001.cj <==
    //Ⰰ௃𑑞
    ==> 312971187273887133103756125507554657282.cj <==
    //ꬁ
    ==> 31386376688274848544794569170674943136.cj <==
    //𞥐݋࡞𞹽𪜀ຨ྾
    ==> 32204115288680768118638101654321461007.cj <==
 / / ౸ 
    ==> 331565552725811871460447800306217940512.cj <==
    //᏶
    ==> 43371823034507294180482797127190269222.cj <==
    //𝒻𛲚
    ==> 7171357426175145539010342171550780189.cj <==
    //ࢵ᪠𞀫੃𞹐஖꫷꒍𝟎⶯
    */
    
    // test case #5
    /*
    ==> 132759489394298806529940531201123322675.cj <==
    0b10__i16
    ==> 137994609878431790584473683140207240007.cj <==
    0B1
    ==> 144765197114291284709601802724657104132.cj <==
    0x8
    ==> 53494809387412412450625668733335499613.cj <==
    0o6i16
    ==> 67375621833862186035450081529211963777.cj <==
    0xbe_F_1_Au8
    */
}