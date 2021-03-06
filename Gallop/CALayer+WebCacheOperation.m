/*
 https://github.com/waynezxcv/Gallop
 
 Copyright (c) 2016 waynezxcv <liuweiself@126.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */




#import "CALayer+WebCacheOperation.h"
#import <objc/runtime.h>


static char loadOperationKey;

typedef NSMutableDictionary<NSString *, id> LWOperationsDictionary;

@implementation CALayer (WebCacheOperation)

- (LWOperationsDictionary *)operationDictionary {
    LWOperationsDictionary *operations = objc_getAssociatedObject(self, &loadOperationKey);
    if (operations) {
        return operations;
    }
    operations = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, &loadOperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return operations;
}

- (void)lw_setImageLoadOperation:(nullable id)operation forKey:(nullable NSString *)key {
    if (key) {
        [self lw_cancelImageLoadOperationWithKey:key];
        if (operation) {
            LWOperationsDictionary *operationDictionary = [self operationDictionary];
            operationDictionary[key] = operation;
        }
    }
}

- (void)lw_cancelImageLoadOperationWithKey:(nullable NSString *)key {
    LWOperationsDictionary *operationDictionary = [self operationDictionary];
    id operations = operationDictionary[key];
    if (operations) {
        if ([operations isKindOfClass:[NSArray class]]) {
            for (id <SDWebImageOperation> operation in operations) {
                if (operation) {
                    [operation cancel];
                }
            }
        } else if ([operations conformsToProtocol:@protocol(SDWebImageOperation)]) {
            [(id <SDWebImageOperation>) operations cancel];
        }
        [operationDictionary removeObjectForKey:key];
    }
}

- (void)lw_removeImageLoadOperationWithKey:(nullable NSString *)key {
    if (key) {
        LWOperationsDictionary *operationDictionary = [self operationDictionary];
        [operationDictionary removeObjectForKey:key];
    }
}


@end
