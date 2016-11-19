//
//  BRRequestView.m
//  CodeAndStudy
//
//  Created by bori－applepc on 2016/11/17.
//  Copyright © 2016年 forr. All rights reserved.
//

#import "BRRequestView.h"

@implementation BRRequestView

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)loadFromNib {
    BRRequestView *requestView = [[NSBundle mainBundle] loadNibNamed:@"BRRequestView" owner:nil options:nil].lastObject;
    return requestView;
}

- (IBAction)sureAction:(id)sender {
    [self removeFromSuperview];
}


@end
