#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import <IOKit/graphics/IOGraphicsLib.h>
#import <ApplicationServices/ApplicationServices.h>

CFStringRef key = CFSTR(kIODisplayBrightnessKey);

double lastCheckTime;
double checkDelta = 1.0;

float expectedBrightness;
float baselineBrightness;

#define fatal(fmt, ...) do { fprintf(stderr, fmt, ## __VA_ARGS__); exit(1); } while(0);


int main(int argc, char **argv)
{
  io_service_t      service;
  CGDirectDisplayID targetDisplay;
  targetDisplay = CGMainDisplayID();
  service = CGDisplayIOServicePort(targetDisplay);
  BOOL shocked = NO;
  NSString *activeApp = [[[NSWorkspace sharedWorkspace] activeApplication] objectForKey:@"NSApplicationName"];      
  printf("frontApp=%s", [activeApp UTF8String]);
}


