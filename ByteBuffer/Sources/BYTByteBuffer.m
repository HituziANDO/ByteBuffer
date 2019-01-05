//
//  BYTByteBuffer.m
//  ByteBuffer
//
//  Created by Masaki Ando on 2019/01/05.
//  Copyright (c) 2019 Hituzi Ando. All rights reserved.
//

#import "BYTByteBuffer.h"

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
    return [self putData:[NSData dataWithBytes:&i length:sizeof(i)]];
}

- (instancetype)putUInteger:(NSUInteger)i {
    return [self putData:[NSData dataWithBytes:&i length:sizeof(i)]];
}

- (instancetype)putInt:(int)i {
    return [self putData:[NSData dataWithBytes:&i length:sizeof(i)]];
}

- (instancetype)putUInt:(unsigned int)i {
    return [self putData:[NSData dataWithBytes:&i length:sizeof(i)]];
}

- (instancetype)putLong:(long)l {
    return [self putData:[NSData dataWithBytes:&l length:sizeof(l)]];
}

- (instancetype)putLongLong:(long long)ll {
    return [self putData:[NSData dataWithBytes:&ll length:sizeof(ll)]];
}

- (instancetype)putFloat:(float)f {
    return [self putData:[NSData dataWithBytes:&f length:sizeof(f)]];
}

- (instancetype)putDouble:(double)d {
    return [self putData:[NSData dataWithBytes:&d length:sizeof(d)]];
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

    NSInteger i;
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, sizeof(i))];
    [data getBytes:&i length:sizeof(i)];
    self.position += data.length;

    return i;
}

- (NSUInteger)getUInteger {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    NSUInteger i;
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, sizeof(i))];
    [data getBytes:&i length:sizeof(i)];
    self.position += data.length;

    return i;
}

- (int)getInt {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    int i;
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, sizeof(i))];
    [data getBytes:&i length:sizeof(i)];
    self.position += data.length;

    return i;
}

- (unsigned int)getUInt {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    unsigned int i;
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, sizeof(i))];
    [data getBytes:&i length:sizeof(i)];
    self.position += data.length;

    return i;
}

- (long)getLong {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    long l;
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, sizeof(l))];
    [data getBytes:&l length:sizeof(l)];
    self.position += data.length;

    return l;
}

- (long long)getLongLong {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    long long ll;
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, sizeof(ll))];
    [data getBytes:&ll length:sizeof(ll)];
    self.position += data.length;

    return ll;
}

- (float)getFloat {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    float f;
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, sizeof(f))];
    [data getBytes:&f length:sizeof(f)];
    self.position += data.length;

    return f;
}

- (double)getDouble {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Overflow."
                                     userInfo:nil];
    }

    double d;
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, sizeof(d))];
    [data getBytes:&d length:sizeof(d)];
    self.position += data.length;

    return d;
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
