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

#import "ODClient+DefaultConfiguration.h"

@interface ODClient (UserEmail)

/**
 The email of the user.
 */
@property (readonly) NSString *userEmail;

/**
 Calls setMicrosoftAccountAppId:scopes:flags: with no flags and add to scopes `openid`. @see https://dev.onedrive.com/auth/msa_oauth.htm
 @param  microsoftAccountAppId The application id. Must not be nil.
 @param  microsoftAccountScopes The scopes to be used with authentication. Must not be nil.
 */
+ (void)setMicrosoftAccountAppId:(NSString *)microsoftAppId
           scopesIncludingOpenId:(NSArray *)microsoftAccountScopes;

/**
 Loads the current client if one exists, if one doesn't it will pop UI and ask for login info. Client contains logined user email.
 @param completion The completion handler to be called when an authenticated client is created.
 @see authenticatedClientWithCompletion: or loadCurrentClient:
 @warning To load a client from disk, you must provide an accountStore. @see ODAccountStoreProtocol.h The default store is the ODAccountStore object.
 @warning This method may invoke the UI. It will present a view controller on the root view controller, unless one is specified in the default app configuration.
 */
+ (void)namedClientWithCompletion:(ODClientAuthenticationCompletion)completion;

@end
