//
//  BFActor.m
//  Briefs
//
//  Created by Rob Rhyne on 7/17/09.
//  Copyright Digital Arch Design, 2009. See LICENSE file for details.
//

#import "BFActor.h"
#import "BFDispatch.h"
#import "BFConstants.h"


@implementation BFActor

@synthesize bg, name, size, action, touchedBg, disabledBg, releasedBg;



///////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Action Support

+ (NSArray *)copyOfAvailableActions {
	// FIXME Best way to represent this?
	return [[NSArray alloc] initWithObjects:kBFACTOR_GOTO_ACTION, kBFACTOR_TOGGLE_ACTION,
					kBFACTOR_RESIZE_ACTION, kBFACTOR_MOVE_ACTION, nil];
}


///////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject overrides

- (id)init:(NSString*)name withDictionary:(NSDictionary*)dict
{
	isActive = true; 
	
	// TODO: Refactor this into a Briefs data formatter
	if (self = [super init]) {
		self.name = [dict valueForKey:@"name"];

		// backgrounds
		self.bg = [dict valueForKey:@"img"];
		
		self.touchedBg = [dict valueForKey:@"touched"];
		self.disabledBg = [dict	valueForKey:@"disabled"];
		self.releasedBg = [dict	valueForKey:@"released"];
		
		// Dimensions
		NSNumber *x = [dict valueForKey:@"x"];
		NSNumber *y = [dict valueForKey:@"y"];
		NSNumber *width = [dict valueForKey:@"width"];
		NSNumber *height = [dict valueForKey:@"height"];
		self.size = CGRectMake([x floatValue], [y floatValue], [width floatValue], [height floatValue]);
		
		// Action
		// TODO: generalize this as well?
		self.action = [dict valueForKey:@"action"];
		
	}
	return self;
}

- (void)dealloc 
{
	[bg release];
	[name release];
	[action release];
	[touchedBg release];
	[disabledBg release];
	[releasedBg release];
	[super dealloc];
}

- (NSDictionary *)copyAsDictionary
{
  NSNumber *x = [NSNumber numberWithDouble:[self size].origin.x];
  NSNumber *y = [NSNumber numberWithDouble:[self size].origin.y];
  NSNumber *width = [NSNumber numberWithDouble:[self size].size.width];
  NSNumber *height = [NSNumber numberWithDouble:[self size].size.height];
  
  NSArray *keys = [NSArray arrayWithObjects:@"img", @"x", @"y", @"width", @"height", @"name", @"action", nil];
  NSArray *values = [NSArray arrayWithObjects:[self bg], x, y, width, height, [self name], [self action], nil];

  NSDictionary *dict = [[NSDictionary dictionaryWithObjects:values forKeys:keys] retain];
  return dict;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark State Management

- (void) activate
{
	isActive = true;
}

- (void) deactivate 
{
	isActive = false;
}

- (NSString *) background
{
	if (isActive)
		return [self bg];
	else
		return [self disabledBg];
}

///////////////////////////////////////////////////////////////////////////////
@end
