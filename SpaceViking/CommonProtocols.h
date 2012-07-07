//
//  CommonProtocols.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/3/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#ifndef SpaceViking_CommonProtocols_h
#define SpaceViking_CommonProtocols_h


typedef enum  {
    kDirectionLeft,
    kDirectionRight
} PhaserDirection;

typedef enum {
    kStateSpawning,
    kStateIdle,
    kStateCrouching,
    kStateStandingUp,
    kStateWalking,
    kStateAttacking,
    kStateJumping,
    kStateBreating,
    kStateTakingDamage,
    kStateDead,
    kStateTraveling,
    kStateRotating,
    kStateDrilling,
    kStateAfterJumping
} CharacterStates;

typedef enum {
    kObjectTypeNone,
    kPowerUpTypeHealth,
    kPowerUpTypeMallet,
    kEnemyTypeRadarDish,
    kEnemyTypeSpaceCargoShip,
    kEnemyTypeAlienRobot,
    kEnemyTypePhaser,
    kVikingType,
    kSkullType,
    kRockType,
    kMeteorType,
    kFrozenVikingType,
    kIceType,
    kLongBlockType,
    kCartType,
    kSpikesType,
    kDiggerType,
    kGroundType
} GameObjectType;

@protocol GameplayLayerDelegate

-(void) createObjectOfType:(GameObjectType) objectType
                withHealth:(int) initialHealth
                atLocation:(CGPoint) spawnLocation
                withZValue:(int)ZValue;

-(void) createPhaserWithDirection:(PhaserDirection) phaserDirection 
                      andPosition:(CGPoint) spawnPosition;


@end


#endif
