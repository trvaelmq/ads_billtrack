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

#import <Foundation/Foundation.h>

#import <WindFoundation/WindGPBArray.h>
#import <WindFoundation/WindGPBMessage.h>
#import <WindFoundation/WindGPBRuntimeTypes.h>

@class WindGPBOneofDescriptor;

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

/**
 * Generates a string that should be a valid "TextFormat" for the C++ version
 * of Protocol Buffers.
 *
 * @param message    The message to generate from.
 * @param lineIndent A string to use as the prefix for all lines generated. Can
 *                   be nil if no extra indent is needed.
 *
 * @return An NSString with the TextFormat of the message.
 **/
NSString *WindGPBTextFormatForMessage(WindGPBMessage *message,
                                  NSString * __nullable lineIndent);

/**
 * Generates a string that should be a valid "TextFormat" for the C++ version
 * of Protocol Buffers.
 *
 * @param unknownSet The unknown field set to generate from.
 * @param lineIndent A string to use as the prefix for all lines generated. Can
 *                   be nil if no extra indent is needed.
 *
 * @return An NSString with the TextFormat of the unknown field set.
 **/
NSString *WindGPBTextFormatForUnknownFieldSet(WindGPBUnknownFieldSet * __nullable unknownSet,
                                          NSString * __nullable lineIndent);

/**
 * Checks if the given field number is set on a message.
 *
 * @param self        The message to check.
 * @param fieldNumber The field number to check.
 *
 * @return YES if the field number is set on the given message.
 **/
BOOL WindGPBMessageHasFieldNumberSet(WindGPBMessage *self, uint32_t fieldNumber);

/**
 * Checks if the given field is set on a message.
 *
 * @param self  The message to check.
 * @param field The field to check.
 *
 * @return YES if the field is set on the given message.
 **/
BOOL WindGPBMessageHasFieldSet(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Clears the given field for the given message.
 *
 * @param self  The message for which to clear the field.
 * @param field The field to clear.
 **/
void WindGPBClearMessageField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Clears the given oneof field for the given message.
 *
 * @param self  The message for which to clear the field.
 * @param oneof The oneof to clear.
 **/
void WindGPBClearOneof(WindGPBMessage *self, WindGPBOneofDescriptor *oneof);

//%PDDM-EXPAND WindGPB_ACCESSORS()
// This block of code is generated, do not edit it directly.
// clang-format off


//
// Get/Set a given field from/to a message.
//

// Single Fields

/**
 * Gets the value of a bytes field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
NSData *WindGPBGetMessageBytesField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of a bytes field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageBytesField(WindGPBMessage *self, WindGPBFieldDescriptor *field, NSData *value);

/**
 * Gets the value of a string field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
NSString *WindGPBGetMessageStringField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of a string field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageStringField(WindGPBMessage *self, WindGPBFieldDescriptor *field, NSString *value);

/**
 * Gets the value of a message field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
WindGPBMessage *WindGPBGetMessageMessageField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of a message field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageMessageField(WindGPBMessage *self, WindGPBFieldDescriptor *field, WindGPBMessage *value);

/**
 * Gets the value of a group field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
WindGPBMessage *WindGPBGetMessageGroupField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of a group field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageGroupField(WindGPBMessage *self, WindGPBFieldDescriptor *field, WindGPBMessage *value);

/**
 * Gets the value of a bool field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
BOOL WindGPBGetMessageBoolField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of a bool field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageBoolField(WindGPBMessage *self, WindGPBFieldDescriptor *field, BOOL value);

/**
 * Gets the value of an int32 field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
int32_t WindGPBGetMessageInt32Field(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of an int32 field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageInt32Field(WindGPBMessage *self, WindGPBFieldDescriptor *field, int32_t value);

/**
 * Gets the value of an uint32 field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
uint32_t WindGPBGetMessageUInt32Field(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of an uint32 field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageUInt32Field(WindGPBMessage *self, WindGPBFieldDescriptor *field, uint32_t value);

/**
 * Gets the value of an int64 field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
int64_t WindGPBGetMessageInt64Field(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of an int64 field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageInt64Field(WindGPBMessage *self, WindGPBFieldDescriptor *field, int64_t value);

/**
 * Gets the value of an uint64 field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
uint64_t WindGPBGetMessageUInt64Field(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of an uint64 field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageUInt64Field(WindGPBMessage *self, WindGPBFieldDescriptor *field, uint64_t value);

/**
 * Gets the value of a float field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
float WindGPBGetMessageFloatField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of a float field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageFloatField(WindGPBMessage *self, WindGPBFieldDescriptor *field, float value);

/**
 * Gets the value of a double field.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 **/
double WindGPBGetMessageDoubleField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of a double field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The to set in the field.
 **/
void WindGPBSetMessageDoubleField(WindGPBMessage *self, WindGPBFieldDescriptor *field, double value);

/**
 * Gets the given enum field of a message. For proto3, if the value isn't a
 * member of the enum, @c kWindGPBUnrecognizedEnumeratorValue will be returned.
 * WindGPBGetMessageRawEnumField will bypass the check and return whatever value
 * was set.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 *
 * @return The enum value for the given field.
 **/
int32_t WindGPBGetMessageEnumField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Set the given enum field of a message. You can only set values that are
 * members of the enum.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The enum value to set in the field.
 **/
void WindGPBSetMessageEnumField(WindGPBMessage *self,
                            WindGPBFieldDescriptor *field,
                            int32_t value);

/**
 * Get the given enum field of a message. No check is done to ensure the value
 * was defined in the enum.
 *
 * @param self  The message from which to get the field.
 * @param field The field to get.
 *
 * @return The raw enum value for the given field.
 **/
int32_t WindGPBGetMessageRawEnumField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Set the given enum field of a message. You can set the value to anything,
 * even a value that is not a member of the enum.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param value The raw enum value to set in the field.
 **/
void WindGPBSetMessageRawEnumField(WindGPBMessage *self,
                               WindGPBFieldDescriptor *field,
                               int32_t value);

// Repeated Fields

/**
 * Gets the value of a repeated field.
 *
 * @param self  The message from which to get the field.
 * @param field The repeated field to get.
 *
 * @return A WindGPB*Array or an NSMutableArray based on the field's type.
 **/
id WindGPBGetMessageRepeatedField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of a repeated field.
 *
 * @param self  The message into which to set the field.
 * @param field The field to set.
 * @param array A WindGPB*Array or NSMutableArray based on the field's type.
 **/
void WindGPBSetMessageRepeatedField(WindGPBMessage *self,
                                WindGPBFieldDescriptor *field,
                                id array);

// Map Fields

/**
 * Gets the value of a map<> field.
 *
 * @param self  The message from which to get the field.
 * @param field The repeated field to get.
 *
 * @return A WindGPB*Dictionary or NSMutableDictionary based on the field's type.
 **/
id WindGPBGetMessageMapField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

/**
 * Sets the value of a map<> field.
 *
 * @param self       The message into which to set the field.
 * @param field      The field to set.
 * @param dictionary A WindGPB*Dictionary or NSMutableDictionary based on the
 *                   field's type.
 **/
void WindGPBSetMessageMapField(WindGPBMessage *self,
                           WindGPBFieldDescriptor *field,
                           id dictionary);

// clang-format on
//%PDDM-EXPAND-END WindGPB_ACCESSORS()

/**
 * Returns an empty NSData to assign to byte fields when you wish to assign them
 * to empty. Prevents allocating a lot of little [NSData data] objects.
 **/
NSData *WindGPBEmptyNSData(void) __attribute__((pure));

/**
 * Drops the `unknownFields` from the given message and from all sub message.
 **/
void WindGPBMessageDropUnknownFieldsRecursively(WindGPBMessage *message);

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END


//%PDDM-DEFINE WindGPB_ACCESSORS()
//%
//%//
//%// Get/Set a given field from/to a message.
//%//
//%
//%// Single Fields
//%
//%WindGPB_ACCESSOR_SINGLE_FULL(Bytes, NSData, , *)
//%WindGPB_ACCESSOR_SINGLE_FULL(String, NSString, , *)
//%WindGPB_ACCESSOR_SINGLE_FULL(Message, WindGPBMessage, , *)
//%WindGPB_ACCESSOR_SINGLE_FULL(Group, WindGPBMessage, , *)
//%WindGPB_ACCESSOR_SINGLE(Bool, BOOL, )
//%WindGPB_ACCESSOR_SINGLE(Int32, int32_t, n)
//%WindGPB_ACCESSOR_SINGLE(UInt32, uint32_t, n)
//%WindGPB_ACCESSOR_SINGLE(Int64, int64_t, n)
//%WindGPB_ACCESSOR_SINGLE(UInt64, uint64_t, n)
//%WindGPB_ACCESSOR_SINGLE(Float, float, )
//%WindGPB_ACCESSOR_SINGLE(Double, double, )
//%/**
//% * Gets the given enum field of a message. For proto3, if the value isn't a
//% * member of the enum, @c kWindGPBUnrecognizedEnumeratorValue will be returned.
//% * WindGPBGetMessageRawEnumField will bypass the check and return whatever value
//% * was set.
//% *
//% * @param self  The message from which to get the field.
//% * @param field The field to get.
//% *
//% * @return The enum value for the given field.
//% **/
//%int32_t WindGPBGetMessageEnumField(WindGPBMessage *self, WindGPBFieldDescriptor *field);
//%
//%/**
//% * Set the given enum field of a message. You can only set values that are
//% * members of the enum.
//% *
//% * @param self  The message into which to set the field.
//% * @param field The field to set.
//% * @param value The enum value to set in the field.
//% **/
//%void WindGPBSetMessageEnumField(WindGPBMessage *self,
//%                            WindGPBFieldDescriptor *field,
//%                            int32_t value);
//%
//%/**
//% * Get the given enum field of a message. No check is done to ensure the value
//% * was defined in the enum.
//% *
//% * @param self  The message from which to get the field.
//% * @param field The field to get.
//% *
//% * @return The raw enum value for the given field.
//% **/
//%int32_t WindGPBGetMessageRawEnumField(WindGPBMessage *self, WindGPBFieldDescriptor *field);
//%
//%/**
//% * Set the given enum field of a message. You can set the value to anything,
//% * even a value that is not a member of the enum.
//% *
//% * @param self  The message into which to set the field.
//% * @param field The field to set.
//% * @param value The raw enum value to set in the field.
//% **/
//%void WindGPBSetMessageRawEnumField(WindGPBMessage *self,
//%                               WindGPBFieldDescriptor *field,
//%                               int32_t value);
//%
//%// Repeated Fields
//%
//%/**
//% * Gets the value of a repeated field.
//% *
//% * @param self  The message from which to get the field.
//% * @param field The repeated field to get.
//% *
//% * @return A WindGPB*Array or an NSMutableArray based on the field's type.
//% **/
//%id WindGPBGetMessageRepeatedField(WindGPBMessage *self, WindGPBFieldDescriptor *field);
//%
//%/**
//% * Sets the value of a repeated field.
//% *
//% * @param self  The message into which to set the field.
//% * @param field The field to set.
//% * @param array A WindGPB*Array or NSMutableArray based on the field's type.
//% **/
//%void WindGPBSetMessageRepeatedField(WindGPBMessage *self,
//%                                WindGPBFieldDescriptor *field,
//%                                id array);
//%
//%// Map Fields
//%
//%/**
//% * Gets the value of a map<> field.
//% *
//% * @param self  The message from which to get the field.
//% * @param field The repeated field to get.
//% *
//% * @return A WindGPB*Dictionary or NSMutableDictionary based on the field's type.
//% **/
//%id WindGPBGetMessageMapField(WindGPBMessage *self, WindGPBFieldDescriptor *field);
//%
//%/**
//% * Sets the value of a map<> field.
//% *
//% * @param self       The message into which to set the field.
//% * @param field      The field to set.
//% * @param dictionary A WindGPB*Dictionary or NSMutableDictionary based on the
//% *                   field's type.
//% **/
//%void WindGPBSetMessageMapField(WindGPBMessage *self,
//%                           WindGPBFieldDescriptor *field,
//%                           id dictionary);
//%

//%PDDM-DEFINE WindGPB_ACCESSOR_SINGLE(NAME, TYPE, AN)
//%WindGPB_ACCESSOR_SINGLE_FULL(NAME, TYPE, AN, )
//%PDDM-DEFINE WindGPB_ACCESSOR_SINGLE_FULL(NAME, TYPE, AN, TisP)
//%/**
//% * Gets the value of a##AN NAME$L field.
//% *
//% * @param self  The message from which to get the field.
//% * @param field The field to get.
//% **/
//%TYPE TisP##WindGPBGetMessage##NAME##Field(WindGPBMessage *self, WindGPBFieldDescriptor *field);
//%
//%/**
//% * Sets the value of a##AN NAME$L field.
//% *
//% * @param self  The message into which to set the field.
//% * @param field The field to set.
//% * @param value The to set in the field.
//% **/
//%void WindGPBSetMessage##NAME##Field(WindGPBMessage *self, WindGPBFieldDescriptor *field, TYPE TisP##value);
//%
