//
//  MKAByteBuffer.m
//
//
//  Created by Masaki Ando on 2017/03/21.
//

#import "MKAByteBuffer.h"

@interface MKAByteBuffer ()
@property (nonatomic) NSUInteger capacity;
@property (nonatomic) NSMutableData *buff;
@end

@implementation MKAByteBuffer

+ (instancetype)allocate:(NSUInteger)capacity {
    return [[MKAByteBuffer alloc] initWithCapacity:capacity];
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
                                   reason:@"-init is an invalid initializer. Please use +allocate: method instead."
                                 userInfo:nil];
}

#pragma mark - property

- (void)setPosition:(NSUInteger)position {
    if (position > self.limit) {
        @throw [NSException exceptionWithName:NSRangeException reason:@"position > limit" userInfo:nil];
    }
    
    _position = position;
}

- (void)setLimit:(NSUInteger)limit {
    if (limit > self.capacity) {
        @throw [NSException exceptionWithName:NSRangeException reason:@"limit > capacity" userInfo:nil];
    }
    
    _limit = limit;
}

- (NSData *)buffer {
    return [self.buff copy];
}

#pragma mark - public

- (void)putData:(NSData *)data {
    if (self.position + data.length > self.limit) {
        @throw [NSException exceptionWithName:NSRangeException reason:@"Overflow." userInfo:nil];
    }
    
    [self.buff replaceBytesInRange:NSMakeRange(self.position, data.length) withBytes:data.bytes];
    self.position += data.length;
}

- (void)flip {
    self.limit = self.position;
    self.position = 0;
}

- (NSData *)getData {
    if (self.position >= self.limit) {
        @throw [NSException exceptionWithName:NSRangeException reason:@"Overflow." userInfo:nil];
    }
    
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, 1)];
    self.position++;
    return data;
}

- (void)rewind {
    self.position = 0;
}

- (void)clear {
    self.position = 0;
    self.limit = self.capacity;
}

- (void)compact {
    NSData *data = [self.buff subdataWithRange:NSMakeRange(self.position, self.buff.length - self.position)];
    [self.buff replaceBytesInRange:NSMakeRange(0, data.length) withBytes:data.bytes];
    self.position = self.limit - self.position;
    self.limit = self.capacity;
}

- (NSInteger)remaining {
    return self.limit - self.position;
}

- (BOOL)hasRemaining {
    return self.remaining > 0;
}

@end
