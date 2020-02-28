//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <shared_preferences/SharedPreferencesPlugin.h>
#import <sms_maintained/SmsPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [SmsPlugin registerWithRegistrar:[registry registrarForPlugin:@"SmsPlugin"]];
}

@end
