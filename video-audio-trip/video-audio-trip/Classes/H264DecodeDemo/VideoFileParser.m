//
//  VideoFileParser.m
//  video-audio-trip
//
//  Created by 杨俊 on 2018/4/8.
//  Copyright © 2018年 qq756585379. All rights reserved.
//

#import "VideoFileParser.h"

const uint8_t KStartCode[4] = {0, 0, 0, 1};

@interface VideoFileParser ()
@property (nonatomic,   copy) NSString *fileName;
@property (nonatomic, strong) NSInputStream *fileStream;
@end

@implementation VideoFileParser
{
    uint8_t *_buffer;
    NSInteger _bufferSize;
    NSInteger _bufferCap;
}

-(void)open:(NSString *)fileName{
    _bufferSize = 0;
    _bufferCap = 512 * 1024;
    //_bufferCap = 1478191;
    _buffer = malloc(_bufferCap);
    
    self.fileName = fileName;
    self.fileStream = [NSInputStream inputStreamWithFileAtPath:fileName];
    [self.fileStream open];
}

-(VideoPacket *)nextPacket{
    if(_bufferSize < _bufferCap && self.fileStream.hasBytesAvailable) {
        
        NSLog(@"_bufferSize: %ld",_bufferSize);
        NSInteger readBytes = [self.fileStream read:_buffer + _bufferSize maxLength:_bufferCap - _bufferSize];
        _bufferSize += readBytes;
        NSLog(@"************ readBytes: %ld   _bufferSize: %ld",readBytes,_bufferSize);
    }
    
    //memcmp是比较内存区域buf1和buf2的前count个字节。该函数是按字节比较的。
    if(memcmp(_buffer, KStartCode, 4) != 0) {
        return nil;
    }
    
    // 00 00 00 01 06 05 45 DC 45 E9 BD E6 D9 48 B7 96 2C D8 20 D9 23 EE EF 20 54 56 2E 53 4F 48 55 2E 43 4F 4D 20 2D 20 48 2E 32 36 34 2F 4D 50 45 47 2D 34 20 41 56 43 20 63 6F 64 65 63 20 2D 20 76 65 72 73 69 6F 6E 20 31 32 30 20 00 80
    
    // 00 00 00 01 67 4D 40 1F E8 80 78 08 B4 D4 04 04 05 00 00 03 00 01 00 00 03 00 32 8F 18 31 12
    
    // 00 00 00 01 68 EB EC xx xx xx ....
    
    // 00 00 00 01 06 xxxxx 00 00 00 01 67 xxxxx  00 00 00 01 68 xxxxx  00 00 00 01 01 xxxxx  00 00 00 01 68 xxxxx	00 00 00 01 65 xxxxx
    
    // 处理后的数据格式
    // 00 00 00 01 06 xxxxx
    // 00 00 00 01 67 xxxxx			SPS
    // 00 00 00 01 41 xxxxx
    // 00 00 00 01 01 xxxxx
    // 00 00 00 01 68 xxxxx			PPS
    // 00 00 00 01 65 xxxxx			IDR
    
    if(_bufferSize >= 5) {
        // 第一个是 00 00 00 01 06 xxxxx，_buffer + 4 从06开始往后找下一个01,再回退三个看是不是 00 00 00 01，是的话就可以把前面第一个起始码的数据截取出来了
        uint8_t *bufferBegin = _buffer + 4;
        uint8_t *bufferEnd = _buffer + _bufferSize;
        
        while(bufferBegin != bufferEnd) {
            if(*bufferBegin == 0x01) {
                if(memcmp(bufferBegin - 3, KStartCode, 4) == 0) {  	//获得第二个 00 00 00 01 67
                    NSInteger packetSize = bufferBegin - 3 - _buffer;  //从 00 00 00 01 67 的00开始往前取到第一个 00 00 00 01 06 xxxxxx 的数据长度 = 77
                    VideoPacket *vp = [[VideoPacket alloc] initWithSize:packetSize];
                    memcpy(vp.buffer, _buffer, packetSize);
                    memmove(_buffer, _buffer + packetSize, _bufferSize - packetSize);
                    _bufferSize -= packetSize;
                    
                    return vp;
                }
            }
            ++bufferBegin;  //继续往后偏移 取到下一个 00 00 00 01
        }
    }
    
    return nil;
}

-(void)close{
    free(_buffer);
    [self.fileStream close];
}

@end
