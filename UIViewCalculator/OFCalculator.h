//
//  OFCalculator.h
//  UIViewCalculator
//
//  Created by Admin on 02.10.15.
//  Copyright (c) 2015 Olha Fizer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RationalNumbers;

@interface OFCalculator : NSObject

+(id)createCalculator;

- (id) add: (RationalNumbers*) rationNum1 and: (RationalNumbers*) rationNum2;
- (id) subtract: (RationalNumbers*) rationNum1 and: (RationalNumbers*) rationNum2;
- (id) multiply: (RationalNumbers*) rationNum1 and: (RationalNumbers*) rationNum2;
- (id) divide: (RationalNumbers*) rationNum1 and: (RationalNumbers*) rationNum2;

@end
