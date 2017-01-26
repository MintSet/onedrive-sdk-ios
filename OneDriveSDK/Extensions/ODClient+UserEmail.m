//  Copyright 2015 Microsoft Corporation
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "ODClient+UserEmail.h"
#import "ODAppConfiguration+DefaultConfiguration.h"
#import "ODAccountSession.h"
#import "ODAuthProvider.h"
#import "ODServiceInfo.h"

static NSDictionary *decodeJWT(NSString *jwt)
{
    NSString *payload = [[jwt componentsSeparatedByString:@"."] objectAtIndex:1];
    int requiredLength = (int)(4 * ceil((float)payload.length / 4.0));
    int numberOfPads = requiredLength - (int)payload.length;
    if (numberOfPads > 0) {
        NSString *paddings = [[NSString string] stringByPaddingToLength:numberOfPads withString:@"=" startingAtIndex:0];
        payload = [payload stringByAppendingString:paddings];
    }
    NSData *jwtData = [[NSData alloc] initWithBase64EncodedString:payload options:0];
    
    return [NSJSONSerialization JSONObjectWithData:jwtData options:0 error:nil];
}

@implementation ODClient (UserEmail)

+ (void)setMicrosoftAccountAppId:(NSString *)microsoftAppId scopesIncludingOpenId:(NSArray *)microsoftAccountScopes
{
    microsoftAccountScopes = [microsoftAccountScopes arrayByAddingObject:@"openid"];
    [ODClient setMicrosoftAccountAppId:microsoftAppId scopes:microsoftAccountScopes];
}

+ (void)namedClientWithCompletion:(ODClientAuthenticationCompletion)completion
{
    NSParameterAssert(completion);
    
    ODClient *client = [ODClient loadCurrentClient];
    if (client){
        completion(client, nil);
    }
    else{
        [ODClient authenticatedClientWithCompletion:^(ODClient *client, NSError *error) {
            // Decode account id
            if (client) {
                NSDictionary *payload = decodeJWT(client.accountId);
                
                // Set and store user email to service info
                ODAccountSession *session = client.authProvider.accountSession;
                session.serviceInfo.userEmail = payload[@"email"];
                [[ODAppConfiguration defaultConfiguration].accountStore storeCurrentAccount:session];
            }
            completion(client, error);
        }];
    }
}

- (NSString *)userEmail
{
    return self.authProvider.accountSession.serviceInfo.userEmail;
}

@end
