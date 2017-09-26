//
//  BFirebaseNetworkAdapter.m
//  Pods
//
//  Created by Benjamin Smiley-andrews on 13/11/2016.
//
//

#import "BFirebaseNetworkAdapter.h"

#import <ChatSDKCore/ChatCore.h>
#import "ChatFirebaseAdapter.h"

@implementation BFirebaseNetworkAdapter

-(id) init {
    if((self = [super init])) {
        
        // Configure app for Facebook login
        [FIRApp configure];
        
//        [[FIRAuth auth] signOut:Nil];
        
        self.core = [[BFirebaseCoreHandler alloc] init];
        self.auth = [[BFirebaseAuthenticationHandler alloc] init];
        self.search = [[BFirebaseSearchHandler alloc] init];
        self.moderation = [[BFirebaseModerationHandler alloc] init];
        self.contact = [[BBaseContactHandler alloc] init];
        self.publicThread = [[BFirebasePublicThreadHandler alloc] init];
        self.users = [[BFirebaseUsersHandler alloc] init];

    }
    return self;
}

@end
