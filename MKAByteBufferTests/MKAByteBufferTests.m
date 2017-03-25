//
//  MKAByteBufferTests.m
//  MKAByteBufferTests
//
//  Created by Masaki Ando on 2017/03/25.
//  Copyright © 2017年 Hituzi Ando. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MKAByteBuffer.h"

@interface MKAByteBufferTests : XCTestCase
@property (nonatomic) MKAByteBuffer *byteBuff;
@end

@implementation MKAByteBufferTests

- (void)setUp {
    [super setUp];
    
    self.byteBuff = [MKAByteBuffer allocate:256];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Can't use 'init' initializer.
- (void)testInit {
    XCTAssertThrows([[MKAByteBuffer alloc] init]);
}

- (void)testPosition {
    [self.byteBuff putData:[@"a" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"b" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"c" dataUsingEncoding:NSASCIIStringEncoding]];
    
    XCTAssertEqual(self.byteBuff.position, 3);
}

- (void)testPutData {
    NSData *A = [@"a" dataUsingEncoding:NSASCIIStringEncoding];
    
    for (NSInteger i = 0; i < 256; i++) {
        [self.byteBuff putData:A];
    }
    
    // Overflow!
    XCTAssertThrows([self.byteBuff putData:A]);
}

- (void)testFlip {
    [self.byteBuff putData:[@"a" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"b" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"c" dataUsingEncoding:NSASCIIStringEncoding]];
    
    [self.byteBuff flip];
    
    BOOL ret = self.byteBuff.position == 0 && self.byteBuff.limit == 3;
    
    XCTAssertTrue(ret);
}

- (void)testGetData {
    [self.byteBuff putData:[@"a" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"b" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"c" dataUsingEncoding:NSASCIIStringEncoding]];
    
    [self.byteBuff flip];
    
    NSString *str;
    
    BOOL ret = YES;
    
    str = [[NSString alloc] initWithData:self.byteBuff.getData encoding:NSASCIIStringEncoding];
    ret &= [str isEqualToString:@"a"];
    
    str = [[NSString alloc] initWithData:self.byteBuff.getData encoding:NSASCIIStringEncoding];
    ret &= [str isEqualToString:@"b"];
    
    str = [[NSString alloc] initWithData:self.byteBuff.getData encoding:NSASCIIStringEncoding];
    ret &= [str isEqualToString:@"c"];
    
    XCTAssertTrue(ret);
}

- (void)testRewind {
    [self.byteBuff putData:[@"a" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"b" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"c" dataUsingEncoding:NSASCIIStringEncoding]];
    
    [self.byteBuff flip];
    
    [self.byteBuff getData];
    [self.byteBuff getData];
    
    [self.byteBuff rewind];
    
    BOOL ret = self.byteBuff.position == 0 && self.byteBuff.limit == 3;
    
    XCTAssertTrue(ret);
}

- (void)testClear {
    [self.byteBuff putData:[@"a" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"b" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"c" dataUsingEncoding:NSASCIIStringEncoding]];
    
    [self.byteBuff flip];
    [self.byteBuff clear];
    
    BOOL ret = self.byteBuff.position == 0 && self.byteBuff.limit == 256;
    
    XCTAssertTrue(ret);
}

- (void)testCompact {
    [self.byteBuff putData:[@"a" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"b" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"c" dataUsingEncoding:NSASCIIStringEncoding]];
    [self.byteBuff putData:[@"d" dataUsingEncoding:NSASCIIStringEncoding]];
    
    [self.byteBuff flip];
    
    NSString *str;
    str = [[NSString alloc] initWithData:self.byteBuff.getData encoding:NSASCIIStringEncoding]; // get "a"
    str = [[NSString alloc] initWithData:self.byteBuff.getData encoding:NSASCIIStringEncoding]; // get "b"
    
    [self.byteBuff compact];
    
    BOOL ret = YES;
    ret &= self.byteBuff.position == 2;
    ret &= self.byteBuff.limit == 256;
    ret &= [[[NSString alloc] initWithData:self.byteBuff.buffer encoding:NSASCIIStringEncoding] hasPrefix:@"cd"];
    
    XCTAssertTrue(ret);
}

@end
