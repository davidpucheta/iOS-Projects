//
//  GameScene.m
//  PingPongDemo
//
//  Created by David Reyes Pucheta on 15/04/16.
//  Copyright (c) 2016 David Reyes Pucheta. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

@property (strong, nonatomic) UITouch *leftPaddleMotivatingTouch;
@property (strong, nonatomic) UITouch *rightPaddleMotivatingtouch;

@end

@implementation GameScene

static const CGFloat kTrackPixelsPerSecond = 500;

-(void)didMoveToView:(SKView *)view {
   
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
    SKNode *ball = [self childNodeWithName:@"ball"];
    ball.physicsBody.angularVelocity = 1.0;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInNode:self];
        NSLog(@"\n%f %f %f %f", p.x, p.y, self.frame.size.width, self.frame.size.height);
        
        if (p.x < self.frame.size.width * 0.3){
            self.leftPaddleMotivatingTouch = touch;
            NSLog(@"left");
        } else if (p.x > self.frame.size.width * 0.7) {
            self.rightPaddleMotivatingtouch = touch;
            NSLog(@"right");
        }
        else {
            SKNode *ball = [self childNodeWithName:@"ball"];
            ball.physicsBody.velocity = CGVectorMake(ball.physicsBody.velocity.dx * 2.0, ball.physicsBody.velocity.dy);
        }
        
    }
    
    [self trackPaddlesToMotivatingTouches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self trackPaddlesToMotivatingTouches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches containsObject:self.leftPaddleMotivatingTouch]) {
        self.leftPaddleMotivatingTouch = nil;
    }
    
    if ([touches containsObject:self.rightPaddleMotivatingtouch]) {
        self.rightPaddleMotivatingtouch = nil;
    }
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches containsObject:self.leftPaddleMotivatingTouch]) {
        self.leftPaddleMotivatingTouch = nil;
    }
    
    if ([touches containsObject:self.rightPaddleMotivatingtouch]) {
        self.rightPaddleMotivatingtouch = nil;
    }

}

- (void)trackPaddlesToMotivatingTouches {
    id a = @[
             @{@"node" : [self childNodeWithName:@"left_paddle"],
               @"touch" : self.leftPaddleMotivatingTouch ?: [NSNull null]},
             @{@"node" : [self childNodeWithName:@"right_paddle"],
               @"touch" : self.rightPaddleMotivatingtouch ?: [NSNull null]}
             ];
    
    for (NSDictionary *o in a) {
        SKNode *node = o[@"node"];
        UITouch *touch = o[@"touch"];
        
        if ([[NSNull null] isEqual:touch]){
            continue;
        }
        
        CGFloat yPos = [touch locationInNode:self].y;
        NSTimeInterval duration = ABS(yPos - node.position.y) / kTrackPixelsPerSecond;
        
        SKAction *moveAction = [SKAction moveToY:yPos duration:duration];
        [node runAction:moveAction withKey:@"moving!"];
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}
@end
