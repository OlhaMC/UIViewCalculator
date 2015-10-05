//
//  ViewController.m
//  UIViewCalculator
//
//  Created by Admin on 01.10.15.
//  Copyright (c) 2015 Olha Fizer. All rights reserved.
//

#import "ViewController.h"
#import "RationalNumbers.h"
#import "OFCalculator.h"

@interface ViewController ()

@property (strong, nonatomic) OFCalculator * myCalculator;
@property (strong, nonatomic) RationalNumbers * resultNumber;
@property (strong, nonatomic) RationalNumbers * nextNumber;
@property (assign, nonatomic) NSInteger temporaryNumber;

@property (assign, nonatomic) NSInteger operationType;
@property (assign, nonatomic) BOOL didFinishEnteringNumerator;
@property (assign, nonatomic) BOOL didFinishEnteringFirstNumber;
@end

enum typeOfOperation
{
    OFPlusOperation = 1,
    OFMinusOperation = 2,
    OFMultiplyOperation = 3,
    OFDivideOperation = 4
};


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.enterAreaLabel
    
    self.myCalculator = [OFCalculator createCalculator];
    self.resultNumber = [[RationalNumbers alloc]init];
    self.nextNumber = [[RationalNumbers alloc]init];
    self.temporaryNumber = 0;
    self.didFinishEnteringNumerator = NO;
    self.didFinishEnteringFirstNumber = NO;
    self.operationType = 0;
    self.enterAreaLabel.text=@"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Inner methods
- (void) defineNumeratorOrDenominator
{
    RationalNumbers * temporaryFraction;
    if (self.didFinishEnteringFirstNumber)
        temporaryFraction = self.nextNumber;
    else
        temporaryFraction = self.resultNumber;
    
    if (self.didFinishEnteringNumerator)
    {
        temporaryFraction.denominator = self.temporaryNumber;
    }
    else
    {
        temporaryFraction.numerator = self.temporaryNumber;
        temporaryFraction.denominator = 1;
    }
}

- (void) finishFirstNumber
{
    self.temporaryNumber = 0;
    self.didFinishEnteringFirstNumber = YES;
    self.didFinishEnteringNumerator = NO;
}

#pragma mark - UICalculator methods
-(IBAction)enterDigitAction:(UIButton*)sender
{
    self.temporaryNumber = self.temporaryNumber * 10 + sender.tag;
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:[NSString stringWithFormat:@"%ld", sender.tag]];
}

-(IBAction)addSlashAction:(UIButton*)sender
{
    self.didFinishEnteringNumerator = YES;
    if (self.operationType)
    {
        self.nextNumber.numerator = self.temporaryNumber;
    }
    else
    {
        self.resultNumber.numerator = self.temporaryNumber;
    }
    self.temporaryNumber = 0;
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:@"/"];
}

-(IBAction)equalsAction:(UIButton*)sender
{
    [self defineNumeratorOrDenominator];
    switch (self.operationType)
    {
        case OFPlusOperation:
            self.resultNumber = [self.myCalculator add:self.resultNumber and:self.nextNumber];
            break;
        case OFMinusOperation:
            self.resultNumber = [self.myCalculator subtract:self.resultNumber and:self.nextNumber];
            break;
        case OFMultiplyOperation:
            self.resultNumber = [self.myCalculator multiply:self.resultNumber and:self.nextNumber];
            break;
        case OFDivideOperation:
            self.resultNumber = [self.myCalculator divide:self.resultNumber and:self.nextNumber];
            break;
        default:
            break;
    }
    
    [self finishFirstNumber];
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:[NSString stringWithFormat:@"= %ld/%ld", self.resultNumber.numerator, self.resultNumber.denominator]];
}

-(IBAction)plusAction:(UIButton*)sender
{
    self.operationType = OFPlusOperation;
    [self defineNumeratorOrDenominator];
    [self finishFirstNumber];
    
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:@"+"];
}

- (IBAction) subtractAction: (UIButton*)sender
{
    self.operationType = OFMinusOperation;
    [self defineNumeratorOrDenominator];
    [self finishFirstNumber];
    
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:@"-"];
}

- (IBAction) multiplyAction: (UIButton*)sender
{
    self.operationType = OFMultiplyOperation;
    [self defineNumeratorOrDenominator];
    [self finishFirstNumber];
    
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:@"*"];
}
- (IBAction) divideAction: (UIButton*)sender
{
    self.operationType = OFDivideOperation;
    [self defineNumeratorOrDenominator];
    [self finishFirstNumber];
    
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:@":"];
}
-(IBAction)clearAllAction:(UIButton*)sender
{
    self.temporaryNumber = 0;
    self.resultNumber.numerator = 0;
    self.resultNumber.denominator = 1;
    self.nextNumber.numerator = 0;
    self.nextNumber.denominator = 1;
    self.didFinishEnteringNumerator = NO;
    self.didFinishEnteringFirstNumber = NO;
    self.operationType = 0;
    self.enterAreaLabel.text=@"";
}

@end
