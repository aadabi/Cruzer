//
//  BBaseImageMessageHandler.h
//  Pods
//
//  Created by Benjamin Smiley-andrews on 12/11/2016.
//
//

#import <Foundation/Foundation.h>
#import <ChatSDKCore/PImageMessageHandler.h>

@interface BBaseImageMessageHandler : NSObject<PImageMessageHandler>

- (UIImage*)imageWithScaledImage:(UIImage*) image;

@end
