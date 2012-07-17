//
//  SKPaymentTransaction.m
//  Beeblex-SDK
//
//  Created by Marco Tabini on 2012-07-17.
//  Copyright (c) 2012 Blue Parabola, LLC. All rights reserved.
//

#import "SKPaymentTransaction.h"

#import "_BBXCrypto.h"

@implementation SKPaymentTransaction

- (NSData *) transactionReceipt {
    NSString *transactionData = @"ewoJInNpZ25hdHVyZSIgPSAiQWtwZ3ZiNlZLVHNIdE5RbGZGRkJjZzdUU2NCK2Y3S1VHbGxydTVNdkZBY0RQYWxjbnFnQWVNQnBoa1dXMTdEK2k2alRkUko3aHZUZmt3ZzN0RlBhQkxEaktkVmplcVdHcWR2MW5EczI2OUpONXdVdVNEOXVNMmxxOG9lU3JKbHNMYitrTU16YUp3a0dBYjB0R0dGUWhyQUxKZXNFZkFVWThyVWIxRS84OEFsVUFBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NHVVVrVTNaV0FTMU1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEE1TURZeE5USXlNRFUxTmxvWERURTBNRFl4TkRJeU1EVTFObG93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNclJqRjJjdDRJclNkaVRDaGFJMGc4cHd2L2NtSHM4cC9Sd1YvcnQvOTFYS1ZoTmw0WElCaW1LalFRTmZnSHNEczZ5anUrK0RyS0pFN3VLc3BoTWRkS1lmRkU1ckdYc0FkQkVqQndSSXhleFRldngzSExFRkdBdDFtb0t4NTA5ZGh4dGlJZERnSnYyWWFWczQ5QjB1SnZOZHk2U01xTk5MSHNETHpEUzlvWkhBZ01CQUFHamNqQndNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVOaDNvNHAyQzBnRVl0VEpyRHRkREM1RllRem93RGdZRFZSMFBBUUgvQkFRREFnZUFNQjBHQTFVZERnUVdCQlNwZzRQeUdVakZQaEpYQ0JUTXphTittVjhrOVRBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQUVhU2JQanRtTjRDL0lCM1FFcEszMlJ4YWNDRFhkVlhBZVZSZVM1RmFaeGMrdDg4cFFQOTNCaUF4dmRXLzNlVFNNR1k1RmJlQVlMM2V0cVA1Z204d3JGb2pYMGlreVZSU3RRKy9BUTBLRWp0cUIwN2tMczlRVWU4Y3pSOFVHZmRNMUV1bVYvVWd2RGQ0TndOWXhMUU1nNFdUUWZna1FRVnk4R1had1ZIZ2JFL1VDNlk3MDUzcEdYQms1MU5QTTN3b3hoZDNnU1JMdlhqK2xvSHNTdGNURXFlOXBCRHBtRzUrc2s0dHcrR0szR01lRU41LytlMVFUOW5wL0tsMW5qK2FCdzdDMHhzeTBiRm5hQWQxY1NTNnhkb3J5L0NVdk02Z3RLc21uT09kcVRlc2JwMGJzOHNuNldxczBDOWRnY3hSSHVPTVoydG04bnBMVW03YXJnT1N6UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREV5TFRBM0xURTNJREV6T2pFMU9qRTRJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluVnVhWEYxWlMxcFpHVnVkR2xtYVdWeUlpQTlJQ0ppTURFd01qZzBPQ0k3Q2draWIzSnBaMmx1WVd3dGRISmhibk5oWTNScGIyNHRhV1FpSUQwZ0lqRXdNREF3TURBd05UTXdNVFE1TkRFaU93b0pJbUoyY25NaUlEMGdJakV1TUNJN0Nna2lkSEpoYm5OaFkzUnBiMjR0YVdRaUlEMGdJakV3TURBd01EQXdOVE13TVRRNU5ERWlPd29KSW5GMVlXNTBhWFI1SWlBOUlDSXhJanNLQ1NKdmNtbG5hVzVoYkMxd2RYSmphR0Z6WlMxa1lYUmxMVzF6SWlBOUlDSXhNelF5TlRVMk1URTRNekF6SWpzS0NTSndjbTlrZFdOMExXbGtJaUE5SUNKaVlXSnBiR3hwYjI0aU93b0pJbWwwWlcwdGFXUWlJRDBnSWpVME5EazJPRGswTmlJN0Nna2lZbWxrSWlBOUlDSmpiMjB1WVdacmMzUjFaR2x2TG1sdmN5NUpRVkJVWlhOMElqc0tDU0p3ZFhKamFHRnpaUzFrWVhSbExXMXpJaUE5SUNJeE16UXlOVFUyTVRFNE16QXpJanNLQ1NKd2RYSmphR0Z6WlMxa1lYUmxJaUE5SUNJeU1ERXlMVEEzTFRFM0lESXdPakUxT2pFNElFVjBZeTlIVFZRaU93b0pJbkIxY21Ob1lYTmxMV1JoZEdVdGNITjBJaUE5SUNJeU1ERXlMVEEzTFRFM0lERXpPakUxT2pFNElFRnRaWEpwWTJFdlRHOXpYMEZ1WjJWc1pYTWlPd29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVWlJRDBnSWpJd01USXRNRGN0TVRjZ01qQTZNVFU2TVRnZ1JYUmpMMGROVkNJN0NuMD0iOwoJImVudmlyb25tZW50IiA9ICJTYW5kYm94IjsKCSJwb2QiID0gIjEwMCI7Cgkic2lnbmluZy1zdGF0dXMiID0gIjAiOwp9";
    
    return [_BBXCrypto decodeBase64:[transactionData dataUsingEncoding:NSASCIIStringEncoding] WithNewLines:NO];
}


- (NSString *) transactionIdentifier {
    return @"DUMMYTEST";
}


- (NSInteger) transactionState {
    return 1;
}

@end