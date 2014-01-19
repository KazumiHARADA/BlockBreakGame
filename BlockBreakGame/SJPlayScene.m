//
//  SJPlayScene.m
//  BlockBreakGame
//
//  Created by 原田一美 on 2014/01/19.
//  Copyright (c) 2014年 kazumi harada. All rights reserved.
//

#import "SJPlayScene.h"

@implementation SJPlayScene

- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        [self addBlocks];
    }
    return self;
}

static NSDictionary *config = nil;
+ (void)initialize {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!config) {
        config = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
}

# pragma mark - Block

- (void)addBlocks {
    
    int rows = [config[@"block"][@"rows"] intValue];
    CGFloat margin = [config[@"block"][@"margin"] floatValue];
    CGFloat width = [config[@"block"][@"width"] floatValue];
    CGFloat height = [config[@"block"][@"height"] floatValue];
    
    int cols = floor(CGRectGetWidth(self.frame) - margin) / (width + margin);
    
    CGFloat y = CGRectGetHeight(self.frame) - margin - height / 2;
    
    for (int i = 0; i < rows; i++) {
        CGFloat x = margin + width / 2;
        for (int j = 0; j < cols; j++) {
            SKNode *block = [self newBlock];
            block.position = CGPointMake(x, y);
            x += width + margin;
        }
        y -= height + margin;
    }
}

- (SKNode *)newBlock {
    CGFloat width = [config[@"block"][@"width"] floatValue];
    CGFloat height = [config[@"block"][@"height"] floatValue];
    int maxLife = [config[@"block"][@"max_life"] floatValue];
    
    SKSpriteNode *block = [SKSpriteNode spriteNodeWithColor:[SKColor cyanColor] size:CGSizeMake(width, height)];
    block.name = @"block";
    
    int life = (arc4random() % maxLife) + 1;
    block.userData = @{ @"life" : @(life) }.mutableCopy;
    [self updateBlockAlpha:block];
    
    [self addChild:block];
    
    return block;
}

- (void)updateBlockAlpha:(SKNode *)block {
    int life = [block.userData[@"life"] intValue];
    block.alpha = life * 0.2f;
}

@end
