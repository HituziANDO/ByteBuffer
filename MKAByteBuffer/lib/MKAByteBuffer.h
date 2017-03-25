//
//  MKAByteBuffer.h
//
//
//  Created by Masaki Ando on 2017/03/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 ByteBuffer class like Java.
 */
@interface MKAByteBuffer : NSObject

/**
 */
@property (nonatomic) NSUInteger limit;
/**
 */
@property (nonatomic) NSUInteger position;
/**
 */
@property (nonatomic, readonly) NSData *buffer;

/**
 Initializer with a given capacity.
 */
+ (instancetype)allocate:(NSUInteger)capacity;

/**
 */
- (void)putData:(NSData *)data;
/**
 */
- (void)flip;
/**
 */
- (NSData *)getData;
/**
 */
- (void)rewind;
/**
 */
- (void)clear;
/**
 */
- (void)compact;
/**
 
 @return limit - position
 */
- (NSInteger)remaining;
/**
 
 @return true if self.remaining > 0
 */
- (BOOL)hasRemaining;

@end

NS_ASSUME_NONNULL_END
