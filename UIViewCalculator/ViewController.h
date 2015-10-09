//
//  ViewController.h
//  UIViewCalculator
//
//  Created by Admin on 01.10.15.
//  Copyright (c) 2015 Olha Fizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView * calculatorBaseView;
@property (weak, nonatomic) IBOutlet UILabel * calculatorLabel;
@property (weak, nonatomic) IBOutlet UILabel * enterAreaLabel;

@property (strong, nonatomic) IBOutletCollection (UIButton) NSArray * numberButtons;

@property (weak, nonatomic) IBOutlet UIButton * addSlashButton;

@property (weak, nonatomic) IBOutlet UIButton * plusButton;
@property (weak, nonatomic) IBOutlet UIButton * minusButton;
@property (weak, nonatomic) IBOutlet UIButton * multiplyButton;
@property (weak, nonatomic) IBOutlet UIButton * divideButton;
@property (weak, nonatomic) IBOutlet UIButton * equalsButton;
@property (weak, nonatomic) IBOutlet UIButton * clearButton;
@property (weak, nonatomic) IBOutlet UIButton * changeSignButton;

@end

