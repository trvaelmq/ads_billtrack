// Protocol Buffers - Google's data interchange format
// Copyright 2008 Google Inc.  All rights reserved.
// https://developers.google.com/protocol-buffers/
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//     * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <WindFoundation/WindGPBBootstrap.h>
#import <WindFoundation/WindGPBArray.h>
#import <WindFoundation/WindGPBCodedInputStream.h>
#import <WindFoundation/WindGPBCodedOutputStream.h>
#import <WindFoundation/WindGPBDescriptor.h>
#import <WindFoundation/WindGPBDictionary.h>
#import <WindFoundation/WindGPBExtensionRegistry.h>
#import <WindFoundation/WindGPBMessage.h>
#import <WindFoundation/WindGPBRootObject.h>
#import <WindFoundation/WindGPBUnknownField.h>
#import <WindFoundation/WindGPBUnknownFieldSet.h>
#import <WindFoundation/WindGPBUtilities.h>
#import <WindFoundation/WindGPBWellKnownTypes.h>
#import <WindFoundation/WindGPBWireFormat.h>

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(WindGPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define WindGPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

// Well-known proto types
#if WindGPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <WindFoundation/WindGPBAny.pbobjc.h>
 #import <WindFoundation/WindGPBApi.pbobjc.h>
 #import <WindFoundation/WindGPBDuration.pbobjc.h>
 #import <WindFoundation/WindGPBEmpty.pbobjc.h>
 #import <WindFoundation/WindGPBFieldMask.pbobjc.h>
 #import <WindFoundation/WindGPBSourceContext.pbobjc.h>
 #import <WindFoundation/WindGPBStruct.pbobjc.h>
 #import <WindFoundation/WindGPBTimestamp.pbobjc.h>
 #import <WindFoundation/WindGPBType.pbobjc.h>
 #import <WindFoundation/WindGPBWrappers.pbobjc.h>
#else
 #import "WindGPBAny.pbobjc.h"
 #import "WindGPBApi.pbobjc.h"
 #import "WindGPBDuration.pbobjc.h"
 #import "WindGPBEmpty.pbobjc.h"
 #import "WindGPBFieldMask.pbobjc.h"
 #import "WindGPBSourceContext.pbobjc.h"
 #import "WindGPBStruct.pbobjc.h"
 #import "WindGPBTimestamp.pbobjc.h"
 #import "WindGPBType.pbobjc.h"
 #import "WindGPBWrappers.pbobjc.h"
#endif
