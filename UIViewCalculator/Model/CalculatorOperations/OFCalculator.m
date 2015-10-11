//
//  OFCalculator.m
//  UIViewCalculator
//
//  Created by Admin on 02.10.15.
//  Copyright (c) 2015 Olha Fizer. All rights reserved.
//

#import "OFCalculator.h"
#import "RationalNumbers.h"

@implementation OFCalculator

@synthesize rationalNumbersArray=_rationalNumbersArray;
@synthesize mathematicOperationsArray=_mathematicOperationsArray;

+(id)createCalculator
{
    static OFCalculator * myCalculator=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        myCalculator = [[OFCalculator alloc]init];
        myCalculator.rationalNumbersArray = [[NSMutableArray alloc]init];
        //[myCalculator.rationalNumbersArray addObject:[[RationalNumbers alloc]init]];
        myCalculator.mathematicOperationsArray = [[NSMutableArray alloc]init];
    });
    return myCalculator;
}

#pragma mark - Calculator operations

- (id) add: (RationalNumbers*) rationNum1 and: (RationalNumbers*) rationNum2
{
    RationalNumbers * newFraction = [[RationalNumbers alloc]init];
    newFraction.numerator = rationNum1.numerator*rationNum2.denominator + rationNum2.numerator*rationNum1.denominator;
    newFraction.denominator = rationNum1.denominator*rationNum2.denominator;
    return [newFraction lowestTermOfFraction];
}

- (id) subtract: (RationalNumbers*) rationNum1 and: (RationalNumbers*) rationNum2
{
    RationalNumbers * newFraction = [[RationalNumbers alloc]init];
    newFraction.numerator = rationNum1.numerator*rationNum2.denominator - rationNum2.numerator*rationNum1.denominator;
    newFraction.denominator = rationNum1.denominator*rationNum2.denominator;
    return [newFraction lowestTermOfFraction];
}
- (id) multiply: (RationalNumbers*) rationNum1 and: (RationalNumbers*) rationNum2
{
    RationalNumbers * newFraction = [[RationalNumbers alloc]init];
    newFraction.numerator = rationNum1.numerator*rationNum2.numerator;
    newFraction.denominator = rationNum1.denominator*rationNum2.denominator;
    return [newFraction lowestTermOfFraction];
}
- (id) divide: (RationalNumbers*) rationNum1 and: (RationalNumbers*) rationNum2
{
    RationalNumbers * newFraction = [[RationalNumbers alloc]init];
    RationalNumbers * temporary = [[RationalNumbers alloc]initWithTwoParametersNumerator:rationNum2.denominator Denominator:rationNum2.numerator];
    newFraction=[self multiply:rationNum1 and:temporary];
    return [newFraction lowestTermOfFraction];
}

@end
