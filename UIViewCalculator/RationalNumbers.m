//
//  RationalNumbers.m
//  UIViewCalculator
//
//  Created by Admin on 01.10.15.
//  Copyright (c) 2015 Olha Fizer. All rights reserved.
//

#import "RationalNumbers.h"

@implementation RationalNumbers

@synthesize numerator=_numerator;
@synthesize denominator=_denominator;

#pragma mark - Initializing
- (id) initWithTwoParametersNumerator: (NSInteger) theNumerator Denominator: (NSInteger) theDenominator
{
    self = [super init];
    if (self)
    {
        self.numerator = theNumerator;
        self.denominator = theDenominator;
    }
    return self;
}

- (id) initWithOneParameterNumerator: (NSInteger) theNumerator
{
    return[self initWithTwoParametersNumerator: theNumerator Denominator:1];
}
- (id) init
{
    return[self initWithTwoParametersNumerator: 0 Denominator:1];
}

#pragma mark - Additional methods

- (void) show
{
    NSLog(@"%ld/%ld", [self numerator], [self denominator]);
}
//function to make rational number simle (or in the lowest term)
- (id) lowestTermOfFraction
{
    NSInteger remainder = 0;
    NSInteger firstNumber = self.numerator;
    NSInteger secondNumber = self.denominator;
    while (secondNumber != 0)
    {
        remainder = firstNumber % secondNumber;
        firstNumber = secondNumber;
        secondNumber = remainder;
    }
    self.numerator = self.numerator / firstNumber;
    self.denominator = self.denominator / firstNumber;

    return  self;
}

- (NSInteger) compareTO: (RationalNumbers*) numberToCompare
{
    if (self.numerator * numberToCompare.denominator > numberToCompare.numerator * self.denominator)
        return 1;
    if (self.numerator * numberToCompare.denominator < numberToCompare.numerator * self.denominator)
        return -1;
    return 0;
}

#pragma mark - Copying

- (id) copyWithZone:(NSZone *)zone
{
    RationalNumbers * copiedFraction = [[[self class] allocWithZone:zone]initWithTwoParametersNumerator:[self numerator] Denominator:[self denominator]];
    return copiedFraction;
}

@end
