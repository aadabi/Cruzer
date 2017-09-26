//
//  BMediaChatOption.h
//  Pods
//
//  Created by Benjamin Smiley-andrews on 17/12/2016.
//
//

#import <ChatSDKUI/BChatOption.h>
#import <ChatSDKCore/bPictureTypes.h>

#import <TOCropViewController/TOCropViewController.h>

@class RXPromise;
@protocol TOCropViewControllerDelegate;

@interface BMediaChatOption : BChatOption<UIImagePickerControllerDelegate, TOCropViewControllerDelegate> {
    UIImagePickerController * _picker;
    RXPromise * _promise;
    bPictureType _type;
}

-(id) initWithType: (bPictureType) type;

@end
