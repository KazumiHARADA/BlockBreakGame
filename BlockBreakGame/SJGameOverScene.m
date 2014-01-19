//
//  SJGameOverScene.m
//  BlockBreakGame
//
//  Created by 原田一美 on 2014/01/20.
//  Copyright (c) 2014年 kazumi harada. All rights reserved.
//

#import "SJGameOverScene.h"
#import "SJPlayScene.h"

@implementation SJGameOverScene

- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
        titleLabel.text = @"GAVE OVER...";
        titleLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        titleLabel.fontSize = 40.0f;
        [self addChild:titleLabel];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKScene *scene = [SJPlayScene sceneWithSize:self.size];
    SKTransition *transition = [SKTransition pushWithDirection:SKTransitionDirectionUp duration:1.0f];
    [self.view presentScene:scene transition:transition];
}

@end
