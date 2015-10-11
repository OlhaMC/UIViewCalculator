//
//  RationalNumbers.h
//  UIViewCalculator
//
//  Created by Admin on 01.10.15.
//  Copyright (c) 2015 Olha Fizer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RationalNumbers : NSObject<NSCopying>

@property (assign, nonatomic) NSInteger numerator;
@property (assign, nonatomic) NSInteger denominator;

- (id) initWithTwoParametersNumerator: (NSInteger) theNumerator Denominator: (NSInteger) theDenominator;
- (id) initWithOneParameterNumerator: (NSInteger) theNumerator;
- (id) init;

- (void) show;
- (id) lowestTermOfFraction;
- (NSInteger) compareTO: (RationalNumbers*) numberToCompare;

- (id) copyWithZone:(NSZone *)zone;

@end
