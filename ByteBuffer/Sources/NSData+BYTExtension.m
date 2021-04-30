//
//  NSData+BYTExtension.m
//  ByteBuffer
//
//  Created by Masaki Ando on 2019/01/06.
//  Copyright (c) 2019 Hituzi Ando. All rights reserved.
//

#import "NSData+BYTExtension.h"

@implementation NSData (BYTExtension)

#pragma mark - property

- (NSInteger)byt_toInteger {
    NSInteger value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (NSUInteger)byt_toUInteger {
    NSUInteger value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (short)byt_toShort {
    short value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (int8_t)byt_toInt8 {
    int8_t value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (uint8_t)byt_toUInt8 {
    uint8_t value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (int16_t)byt_toInt16 {
    int16_t value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (uint16_t)byt_toUInt16 {
    uint16_t value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (int32_t)byt_toInt32 {
    int32_t value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (uint32_t)byt_toUInt32 {
    uint32_t value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (int64_t)byt_toInt64 {
    int64_t value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (uint64_t)byt_toUInt64 {
    uint64_t value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (int)byt_toInt {
    int value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (unsigned int)byt_UInt {
    unsigned int value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (long)byt_toLong {
    long value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (long long)byt_toLongLong {
    long long value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (float)byt_toFloat {
    float value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (double)byt_toDouble {
    double value;
    [self getBytes:&value length:sizeof(value)];

    return value;
}

- (Byte *)byt_toBytes {
    NSUInteger len = self.length;
    Byte *bytes = (Byte *) malloc(len);
    memcpy(bytes, self.bytes, len);

    return bytes;
}

#pragma mark - Initializer

+ (instancetype)byt_dataWithInteger:(NSInteger)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithUInteger:(NSUInteger)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithShort:(short)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithInt8:(int8_t)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithUInt8:(uint8_t)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithInt16:(int16_t)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithUInt16:(uint16_t)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithInt32:(int32_t)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithUInt32:(uint32_t)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithInt64:(int64_t)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithUInt64:(uint64_t)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithInt:(int)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithUInt:(unsigned int)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithLong:(long)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithLongLong:(long long)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithFloat:(float)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

+ (instancetype)byt_dataWithDouble:(double)value {
    return [NSData dataWithBytes:&value length:sizeof(value)];
}

#pragma mark - public method

- (NSInteger)byt_toIntegerWithLocation:(NSUInteger)loc {
    NSInteger value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (NSUInteger)byt_toUIntegerWithLocation:(NSUInteger)loc {
    NSUInteger value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (short)byt_toShortWithLocation:(NSUInteger)loc {
    short value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (int8_t)byt_toInt8WithLocation:(NSUInteger)loc {
    int8_t value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (uint8_t)byt_toUInt8WithLocation:(NSUInteger)loc {
    uint8_t value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (int16_t)byt_toInt16WithLocation:(NSUInteger)loc {
    int16_t value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (uint16_t)byt_toUInt16WithLocation:(NSUInteger)loc {
    uint16_t value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (int32_t)byt_toInt32WithLocation:(NSUInteger)loc {
    int32_t value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (uint32_t)byt_toUInt32WithLocation:(NSUInteger)loc {
    uint32_t value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (int64_t)byt_toInt64WithLocation:(NSUInteger)loc {
    int64_t value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (uint64_t)byt_toUInt64WithLocation:(NSUInteger)loc {
    uint64_t value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (int)byt_toIntWithLocation:(NSUInteger)loc {
    int value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (unsigned int)byt_toUIntWithLocation:(NSUInteger)loc {
    unsigned int value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (long)byt_toLongWithLocation:(NSUInteger)loc {
    long value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (long long)byt_toLongLongWithLocation:(NSUInteger)loc {
    long long value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (float)byt_toFloatWithLocation:(NSUInteger)loc {
    float value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

- (double)byt_toDoubleWithLocation:(NSUInteger)loc {
    double value;
    NSData *data = [self subdataWithRange:NSMakeRange(loc, sizeof(value))];
    [data getBytes:&value length:sizeof(value)];

    return value;
}

@end
