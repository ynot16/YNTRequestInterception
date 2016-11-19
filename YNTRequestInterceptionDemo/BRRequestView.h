//
//  BRRequestView.h
//  CodeAndStudy
//
//  Created by bori－applepc on 2016/11/17.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRRequestView : UIView
// 用textView是方便复制
@property (weak, nonatomic) IBOutlet UITextView *urlView;


+ (instancetype)loadFromNib;

@end
