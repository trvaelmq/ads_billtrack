#import <Foundation/Foundation.h>
#import "WindHTTPResponse.h"


@interface WindHTTPDataResponse : NSObject <WindHTTPResponse>
{
	NSUInteger offset;
	NSData *data;
}

- (id)initWithData:(NSData *)data;

@end
