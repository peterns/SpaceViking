//
//  GampleayLayer.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 6/30/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "GameplayLayer.h"

@implementation GameplayLayer


-(void) dealloc
{
    [leftJoystick release];
    [jumpButton release];
    [attackButton release];
    [super dealloc];
}

-(void) initJoystickAndButtons
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 128.0f, 128.0f);
    CGRect jumpButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    CGRect attackButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    
    CGPoint joystickBasePosition;
    CGPoint jumpButtonPosition;
    CGPoint attackButtonPosition;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // The device is an iPad running iPhone 3.2 or later
        CCLOG(@"Positioning Joystick and Buttons for iPad");
        joystickBasePosition = ccp(screenSize.width * 0.0625f, screenSize.height * 0.052f);
        
        jumpButtonPosition = ccp(screenSize.width * 0.946f, screenSize.height * 0.052f);
        
        attackButtonPosition = ccp(screenSize.width * 0.946f, screenSize.height * 0.169f);
        
    } else {
        // The device is an iPhone or iPod touch
        CCLOG(@"Positioning Joystick and Buttons for iPhone");
        
        joystickBasePosition = ccp(screenSize.width * 0.07f, screenSize.height * 0.11f);
        jumpButtonPosition = ccp(screenSize.width * 0.93f, screenSize.height * 0.11f);
        attackButtonPosition = ccp(screenSize.width * 0.93f, screenSize.height * 0.35f);
    }
    
    SneakyJoystickSkinnedBase *joystickBase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    joystickBase.position = joystickBasePosition;
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"dpadDown.png"];
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"joystickDown.png"];
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    
    leftJoystick = [joystickBase.joystick retain];
    [self addChild:joystickBase];
    
    SneakyButtonSkinnedBase *jumpButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    jumpButtonBase.position = jumpButtonPosition;
    jumpButtonBase.defaultSprite = [CCSprite spriteWithFile:@"jumpUp.png"];
    jumpButtonBase.activatedSprite = [CCSprite spriteWithFile:@"jumpDown.png"];
    jumpButtonBase.pressSprite = [CCSprite spriteWithFile:@"jumpDown.png"];
    jumpButtonBase.button = [[SneakyButton alloc] initWithRect:jumpButtonDimensions];
    jumpButton = [jumpButtonBase.button retain];
    jumpButton.isToggleable = NO;
    [self addChild:jumpButtonBase];
    
    SneakyButtonSkinnedBase *attackButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    attackButtonBase.position = attackButtonPosition;
    attackButtonBase.defaultSprite = [CCSprite spriteWithFile:@"handUp.png"];
    attackButtonBase.activatedSprite = [CCSprite spriteWithFile:@"handDown.png"];
    attackButtonBase.pressSprite = [CCSprite spriteWithFile:@"handDown.png"];
    attackButtonBase.button = [[SneakyButton alloc] initWithRect:attackButtonDimensions];
    attackButton = [attackButtonBase.button retain];
    attackButton.isToggleable = NO;
    [self addChild:attackButtonBase];
    
    
}

/*
-(void) applyJoystick:(SneakyJoystick *) aJoystick toNode:(CCNode *)tempNode forTimeDelta:(float)deltaTime
{
    CGPoint scaledVelocity = ccpMult(aJoystick.velocity, 1024.0f);
    
    CGPoint newPosition = ccp(tempNode.position.x + scaledVelocity.x * deltaTime, 
                              tempNode.position.y);
    
    if(newPosition.x > 0 && newPosition.x < screenSize.width)
    {
        [tempNode setPosition:newPosition];
    }
    if(jumpButton.active == YES)
    {
        CCLOG(@"Jump button is pressed");
    }
    if(attackButton.active == YES)
    {
        CCLOG(@"Attack button is pressed");
    }
    
}

 */
 
#pragma mark -
#pragma mark Update Method
-(void) update:(ccTime)deltaTime
{
    CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
    
    for(GameCharacter *tempChar in listOfGameObjects) {
        [tempChar updateStateWithDeltaTime:deltaTime andListOfGameObjects:listOfGameObjects];
    }
}

#pragma mark -
-(void) createObjectOfType:(GameObjectType)objectType
                withHealth:(int)initialHealth
                atLocation:(CGPoint)spawnLocation
                withZValue:(int)ZValue
{
    
    if(objectType == kEnemyTypeRadarDish) {
        CCLOG(@"Creating the Radar Enem");
        RadarDish *radarDish = [[RadarDish alloc] initWithSpriteFrameName:@"radar_1.png"];
        [radarDish setCharacterHealth:initialHealth];
        [radarDish setPosition:spawnLocation];
        [sceneSpriteBatchNode addChild:radarDish
                                     z:ZValue
                                   tag:kRadarDishTagValue];
        [radarDish release];
    } else if (objectType == kEnemyTypeAlienRobot) {
        CCLOG(@"Creating the Alien Robot");
        EnemyRobot *enemyRobot = [[EnemyRobot alloc] initWithSpriteFrameName:@"an1_anim1.png"];
        [enemyRobot setCharacterHealth:initialHealth];
        [enemyRobot setPosition:spawnLocation];
        [enemyRobot setCharacterState:kStateSpawning];
        [sceneSpriteBatchNode addChild:enemyRobot z:ZValue];
        [enemyRobot setDelegate:self];
        CCLabelBMFont *debugLabel = [CCLabelBMFont labelWithString:@"NoneNonde" fntFile:@"SpaceVikingFont.fnt"];
        [self addChild:debugLabel];
        [enemyRobot setMyDebugLabel:debugLabel];
        //[debugLabel release];
        [enemyRobot release];
    }
    
    // added by me
    else if(objectType == kPowerUpTypeMallet) {
        CCLOG(@"Creating the Mallet PowerUP");
        Mallet *mallet = [[Mallet alloc] initWithSpriteFrameName:@"mallet_1.png"];
        [mallet setPosition:spawnLocation];
        [sceneSpriteBatchNode addChild:mallet z:ZValue tag:kMalletTagValie];
        [mallet release];
    }
    
    else if (objectType == kPowerUpTypeHealth) {
        CCLOG(@"Creating the Health PowerUP");
        Health *health = [[Health alloc] initWithSpriteFrameName:@"sandwich_1.png"];
        [health setPosition:spawnLocation];
        [sceneSpriteBatchNode addChild:health z:ZValue tag:kPowerUpTypeHealth];
        [health release];
        
    }
    
    else if (objectType == kEnemyTypeSpaceCargoShip) {
        CCLOG(@"Creating the SpaceCargoShip");
        SpaceCargoShip *ship = [[SpaceCargoShip alloc] initWithSpriteFrameName:@"ship_2.png"];
        [ship setPosition:spawnLocation];
        ship.delegate = self;
        [sceneSpriteBatchNode addChild:ship z:ZValue tag:kEnemyTypeSpaceCargoShip];
    }
    
}

-(void) createPhaserWithDirection:(PhaserDirection)phaserDirection andPosition:(CGPoint)spawnPosition
{
    PhaserBullet *phaserBullet = [[PhaserBullet alloc] initWithSpriteFrameName:@"beam_1.png"];
    [phaserBullet setPosition:spawnPosition];
    [phaserBullet setMyDirection:phaserDirection];
    [phaserBullet setCharacterState:kStateSpawning];
    [sceneSpriteBatchNode addChild:phaserBullet];
    [phaserBullet release];
}

-(void) addEnemy {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    RadarDish *radarDish = (RadarDish*) [sceneSpriteBatchNode getChildByTag:kRadarDishTagValue];
    
    if (radarDish != nil) {
        if ([radarDish characterState] != kStateDead) {
            [self createObjectOfType:kEnemyTypeAlienRobot withHealth:100 atLocation:ccp(screenSize.width * 0.195f, screenSize.height * 0.1432f) withZValue:2];
        } else {
            [self unschedule:@selector(addEnemy)];
        }
    }
}



-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        // enable touches
        self.isTouchEnabled = YES;
        
        srandom(time(NULL)); // Seeds the random number generator
        //vikingSprite = [CCSprite spriteWithFile:@"sv_anim_1.png"];

        
        //[self addChild:vikingSprite];

        //CCSpriteBatchNode *chapter2SpriteBatchNode;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        }
        else 
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlasiPhone.plist"];
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlasiPhone.png"];
        }
        
        vikingSprite = [CCSprite spriteWithSpriteFrameName:@"sv_anim_1.png"];
        
        [self addChild:sceneSpriteBatchNode];
        
        [self initJoystickAndButtons];
        
        Viking *viking = [[Viking alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_1.png"]];
        
        [viking setJoystick:leftJoystick];
        [viking setJumpButton:jumpButton];
        [viking setAttackButton:attackButton];
        [viking setPosition:ccp(screenSize.width * 0.35f, screenSize.height * 0.14f)];
        [viking setCharacterHealth:100];
        
        [sceneSpriteBatchNode addChild:viking
                                     z:kVikingSpriteZValue
                                   tag:kVikingSpriteTagValue];
        
        [self createObjectOfType:kEnemyTypeRadarDish withHealth:100 atLocation:ccp(screenSize.width * 0.878f, screenSize.height * 0.13f) withZValue:10];
        
        [self createObjectOfType:kEnemyTypeRadarDish withHealth:100 atLocation:ccp(screenSize.width * 0.10f, screenSize.height * 0.13f) withZValue:11];
            
        //id wavesAction = [CCWaves actionWithWaves:5 amplitude:20 horizontal:NO vertical:YES grid:ccg(15,10) duration:20];
        
        //[sceneSpriteBatchNode runAction:[CCRepeatForever actionWithAction:wavesAction]];
        
        //CCLabelTTF *gameBeginLabel = [CCLabelTTF labelWithString:@"Game Start" fontName:@"Helvetica" fontSize:64];
        // Better to use atlas bmp 
        CCLabelBMFont *gameBeginLabel = [CCLabelBMFont labelWithString:@"Game Start" fntFile:@"SpaceVikingFont.fnt"];
        
        [gameBeginLabel setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:gameBeginLabel];
        
        id labelAction = [CCSpawn actions:[CCScaleBy actionWithDuration:2.0f scale:4], [CCFadeOut actionWithDuration:2.0f], 
                           nil];
     
        [gameBeginLabel runAction:labelAction];
        
        [self scheduleUpdate];
        [self schedule:@selector(addEnemy) interval:10.0f];
        
        
        //Could add mallet directly to the scene
        //[self createObjectOfType:kPowerUpTypeMallet withHealth:100 atLocation:ccp(screenSize.width * 0.621f, screenSize.height * 0.82f) withZValue:10];
        
        [self createObjectOfType:kEnemyTypeSpaceCargoShip withHealth:100 atLocation:ccp(screenSize.width * -1.0f, screenSize.height) withZValue:40];
        
        
        //[chapter2SpriteBatchNode addChild:vikingSprite];
        
        
        //[vikingSprite setPosition:CGPointMake(screenSize.width/2, screenSize.height*0.17f)];
        
        /* LISTING 3.1
        // Animation example with Sprites form files
        CCSprite *animatingRobot = [CCSprite spriteWithFile:@"an1_anim1.png"];
        [animatingRobot setPosition: ccp([vikingSprite position].x + 50.0f, [vikingSprite position].y)];
        
        [self addChild:animatingRobot];
        
        CCAnimation *robotAnim = [CCAnimation animation];
        [robotAnim addFrameWithFilename:@"an1_anim2.png"];
        [robotAnim addFrameWithFilename:@"an1_anim3.png"];
        [robotAnim addFrameWithFilename:@"an1_anim4.png"];
        
        id robotAnimationAction = [CCAnimate actionWithDuration:0.5f animation:robotAnim restoreOriginalFrame:YES];
        
        id repeatRobotAnimation = [CCRepeatForever actionWithAction:robotAnimationAction];
        
        [animatingRobot runAction:repeatRobotAnimation];
        */
        /* LISTING 3.2
        // Animation example with a CCSpriteBatchNode
        CCAnimation *exampleAnim = [CCAnimation animation];
        [exampleAnim addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_2.png"]];
        [exampleAnim addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_3.png"]];
        [exampleAnim addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_4.png"]];

        id animateAction = [CCAnimate actionWithDuration:0.5f animation:exampleAnim restoreOriginalFrame:NO];
        
        id repeatAction = [CCRepeatForever actionWithAction:animateAction];
        
        [vikingSprite runAction:repeatAction];
        */
        
        //[self initJoystickAndButtons];
        //[self scheduleUpdate];
        
        //if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            // if not on iPad, scale down Ole
            // In your games use this to load art sized to for the device
        //    [vikingSprite setScaleX:screenSize.width/1024.0f];
        //    [vikingSprite setScaleY:screenSize.height/768.0f];
        //}
        
        
        
    }
    
    return self;
}



@end



















