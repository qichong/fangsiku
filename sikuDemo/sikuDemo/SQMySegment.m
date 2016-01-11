//
//  SQMySegment.m
//  sikuDemo
//
//  Created by 齐冲 on 16/1/11.
//  Copyright © 2016年 齐冲. All rights reserved.
//

#import "SQMySegment.h"
static CGFloat linHeight = 2;
@interface SQMySegment()
{
    segmentSelectedBlokc _block;
    NSArray *_titleArrary;
    NSMutableArray *_btnArrary;
    UIButton *_agoBtn;
    UIView *_animateLine;
}
@end
@implementation SQMySegment

- (instancetype)initWithFrame:(CGRect)frame andTitleArrary:(NSArray *)titleArrary andSelectedBlock:(segmentSelectedBlokc)block
{
    if (self = [super initWithFrame:frame]) {
        _titleArrary = titleArrary;
        _block = block;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    _btnArrary = @[].mutableCopy;
    CGFloat btnwith = self.frame.size.width / _titleArrary.count;
    for (NSInteger i = 0; i < _titleArrary.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnwith * i, 0, btnwith, self.frame.size.height);
        [btn setTitle:_titleArrary[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_btnArrary addObject:btn];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - linHeight, self.frame.size.width, linHeight)];
    line.backgroundColor = [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1];
    [self addSubview:line];
    
    _animateLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - linHeight, self.frame.size.width / _titleArrary.count , linHeight)];
    _animateLine.backgroundColor = [UIColor redColor];
    [self addSubview:_animateLine];
}

- (void)pressBtn:(UIButton *)sender
{
    if (_agoBtn == sender) {
        return;
    }
    sender.selected = YES;
    _agoBtn.selected = NO;
    _agoBtn = sender;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _animateLine.frame = CGRectMake(sender.frame.origin.x, _animateLine.frame.origin.y,_animateLine.frame.size.width,_animateLine.frame.size.height);
    } completion:nil];
    if (_block) {
        _block(sender.tag);
    }
}

- (void)makeLineGoWithIndex:(NSInteger)index
{
    if (_animateLine) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
          _animateLine.frame = CGRectMake(self.frame.size.width / _titleArrary.count * index, _animateLine.frame.origin.y,_animateLine.frame.size.width,_animateLine.frame.size.height);
        } completion:nil];
       
        if (_agoBtn.tag == index) {
            return;
        }
        _agoBtn.selected = NO;
        UIButton *currentBtn = _btnArrary[index];
        currentBtn.selected = YES;
        _agoBtn = currentBtn;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
