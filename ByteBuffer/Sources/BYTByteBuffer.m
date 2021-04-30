//
//  BYTByteBuffer.m
//  ByteBuffer
//
//  Created by Masaki Ando on 2019/01/05.
//  Copyright (c) 2019 Hituzi Ando. All rights reserved.
//

#import "BYTByteBuffer.h"

#import "NSData+BYTExtension.h"

@interface BYTByteBuffer ()

@property (nonatomic) NSUInteger capacity;
@property (nonatomic) NSMutableData *buff;

@end

@implementation BYTByteBuffer

+ (instancetype)allocateWithCapacity:(NSUInteger)capacity {
    return [[BYTByteBuffer alloc] initWithCapacity:capacity];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];

    if (self) {
        _capacity = capacity;
        _limit = capacity;
        _position = 0;
        _buff = [NSMutableData dataWithCapacity:capacity];
        [_buff resetBytesInRange:NSMakeRange(0, capacity)];
    }

    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"`-init` is invalid initializer. Please uses `+allocateWithCapacity:` instead."
                                 userInfo:nil];
}

#pragma mark - property

- (void)setPosition:(NSUInteger)position {
    if (position > self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"`position` must be less than or equal to `limit`."
                                     userInfo:nil];
    }

    _position = position;
}

- (void)setLimit:(NSUInteger)limit {
    if (limit > self.capacity) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"`limit` must be less than or equal to `capacity`."
                                     userInfo:nil];
    }

    _limit = limit;
}

- (NSData *)buffer {
    return [self.buff copy];
}

- (NSInteger)remaining {
    return self.limit - self.position;
}

- (BOOL)hasRemaining {
    return self.remaining > 0;
}

#pragma mark - public method

- (instancetype)putInteger:(NSInteger)i {
    return [self putData:[NSData byt_dataWithInteger:i]];
}

- (instancetype)putUInteger:(NSUInteger)i {
    return [self putData:[NSData byt_dataWithUInteger:i]];
}

- (instancetype)putShort:(short)s {
    return [self putData:[NSData byt_dataWithShort:s]];
}

- (instancetype)putInt8:(int8_t)i {
    return [self putData:[NSData byt_dataWithInt8:i]];
}

- (instancetype)putUInt8:(uint8_t)i {
    return [self putData:[NSData byt_dataWithUInt8:i]];
}

- (instancetype)putInt16:(int16_t)i {
    return [self putData:[NSData byt_dataWithInt16:i]];
}

- (instancetype)putUInt16:(uint16_t)i {
    return [self putData:[NSData byt_dataWithUInt16:i]];
}

- (instancetype)putInt32:(int32_t)i {
    return [self putData:[NSData byt_dataWithInt32:i]];
}

- (instancetype)putUInt32:(uint32_t)i {
    return [self putData:[NSData byt_dataWithUInt32:i]];
}

- (instancetype)putInt64:(int64_t)i {
    return [self putData:[NSData byt_dataWithInt64:i]];
}

- (instancetype)putUInt64:(uint64_t)i {
    return [self putData:[NSData byt_dataWithUInt64:i]];
}

- (instancetype)putInt:(int)i {
    return [self putData:[NSData byt_dataWithInt:i]];
}

- (instancetype)putUInt:(unsigned int)i {
    return [self putData:[NSData byt_dataWithUInt:i]];
}

- (instancetype)putLong:(long)l {
    return [self putData:[NSData byt_dataWithLong:l]];
}

- (instancetype)putLongLong:(long long)ll {
    return [self putData:[NSData byt_dataWithLongLong:ll]];
}

- (instancetype)putFloat:(float)f {
    return [self putData:[NSData byt_dataWithFloat:f]];
}

- (instancetype)putDouble:(double)d {
    return [self putData:[NSData byt_dataWithDouble:d]];
}

- (instancetype)putUTF8String:(NSString *)string {
    return [self putData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

- (instancetype)putData:(NSData *)data {
    if (self.position + data.length > self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    [self.buff replaceBytesInRange:NSMakeRange(self.position, data.length) withBytes:data.bytes];
    self.position += data.length;

    return self;
}

- (NSInteger)getInteger {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    NSInteger value = [self.buff byt_toIntegerWithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (NSUInteger)getUInteger {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    NSUInteger value = [self.buff byt_toUIntegerWithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (short)getShort {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    short value = [self.buff byt_toShortWithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (int8_t)getInt8 {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    int8_t value = [self.buff byt_toInt8WithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (uint8_t)getUInt8 {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    uint8_t value = [self.buff byt_toUInt8WithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (int16_t)getInt16 {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    int16_t value = [self.buff byt_toInt16WithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (uint16_t)getUInt16 {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    uint16_t value = [self.buff byt_toUInt16WithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (int32_t)getInt32 {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    int32_t value = [self.buff byt_toInt32WithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (uint32_t)getUInt32 {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    uint32_t value = [self.buff byt_toUInt32WithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (int64_t)getInt64 {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    int64_t value = [self.buff byt_toInt64WithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (uint64_t)getUInt64 {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    uint64_t value = [self.buff byt_toUInt64WithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (int)getInt {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    int value = [self.buff byt_toIntWithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (unsigned int)getUInt {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    unsigned int value = [self.buff byt_toUIntWithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (long)getLong {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    long value = [self.buff byt_toLongWithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (long long)getLongLong {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    long long value = [self.buff byt_toLongLongWithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (float)getFloat {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    float value = [self.buff byt_toFloatWithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (double)getDouble {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    double value = [self.buff byt_toDoubleWithLocation:self.position];
    self.position += sizeof(value);

    return value;
}

- (NSData *)getData {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, 1)];
    self.position++;

    return data;
}

- (instancetype)flip {
    self.limit = self.position;
    self.position = 0;

    return self;
}

- (instancetype)rewind {
    self.position = 0;

    return self;
}

- (instancetype)clear {
    self.position = 0;
    self.limit = self.capacity;

    return self;
}

- (instancetype)compact {
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, self.buff.length - self.position)];
    [self.buff replaceBytesInRange:NSMakeRange(0, data.length) withBytes:data.bytes];
    self.position = self.limit - self.position;
    self.limit = self.capacity;

    return self;
}

@end
