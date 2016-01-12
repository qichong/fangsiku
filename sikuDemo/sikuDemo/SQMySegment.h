//
//  SQMySegment.h
//  sikuDemo
//
//  Created by 齐冲 on 16/1/11.
//  Copyright © 2016年 齐冲. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^segmentSelectedBlokc)(NSInteger index);
@interface SQMySegment : UIView
@property (nonatomic,copy)segmentSelectedBlokc block;
@property (nonatomic,strong) UIColor *normalTextColor;
@property (nonatomic,strong) UIColor *selectTextColor;
- (instancetype)initWithFrame:(CGRect)frame andTitleArrary:(NSArray *)titleArrary andSelectedBlock:(segmentSelectedBlokc)block;
- (void)makeLineGoWithIndex:(CGFloat)proportion;
@end
