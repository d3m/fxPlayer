package com.dynamicflash.util
{
    import flash.utils.*;

    public class Base64 extends Object
    {
        public static const version:String = "1.1.0";
        private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

        public function Base64()
        {
            throw new Error("Base64 class is static container only");
        }// end function

        private static function enc_replace_ab(param1:String, param2:String, param3:String) : String
        {
            var _loc_4:* = new RegExp(param1, "g");
            var _loc_5:* = new RegExp(param2, "g");
            param3 = param3.replace(_loc_4, "___");
            param3 = param3.replace(_loc_5, param1);
            param3 = param3.replace(/___/g, param2);
            return param3;
        }// end function

        public static function encode(param1:String) : String
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeUTFBytes(param1);
            return enc_replace(encodeByteArray(_loc_2), "e");
        }// end function

        private static function decodeToByteArray(param1:String) : ByteArray
        {
            var _loc_6:uint;
            var _loc_7:uint;
            var _loc_2:* = new ByteArray();
            var _loc_3:* = new Array(4);
            var _loc_4:* = new Array(3);
            var _loc_5:uint;
            while (_loc_5 < param1.length)
            {
                // label
                _loc_6 = 0;
                while (_loc_6++ < 4 && _loc_5 + _loc_6 < param1.length)
                {
                    // label
                    _loc_3[_loc_6] = BASE64_CHARS.indexOf(param1.charAt(_loc_5 + _loc_6));
                }// end while
                _loc_4[0] = (_loc_3[0] << 2) + ((_loc_3[1] & 48) >> 4);
                _loc_4[1] = ((_loc_3[1] & 15) << 4) + ((_loc_3[2] & 60) >> 2);
                _loc_4[2] = ((_loc_3[2] & 3) << 6) + _loc_3[3];
                _loc_7 = 0;
                while (_loc_7++ < _loc_4.length)
                {
                    // label
                    if (_loc_3[_loc_7 + 1] == 64)
                    {
                        break;
                    }// end if
                    _loc_2.writeByte(_loc_4[_loc_7]);
                }// end while
                _loc_5 = _loc_5 + 4;
            }// end while
            _loc_2.position = 0;
            return _loc_2;
        }// end function

        private static function encodeByteArray(param1:ByteArray) : String
        {
            var _loc_3:Array;
            var _loc_5:uint;
            var _loc_6:uint;
            var _loc_7:uint;
            var _loc_2:String;
            var _loc_4:* = new Array(4);
            param1.position = 0;
            while (param1.bytesAvailable > 0)
            {
                // label
                _loc_3 = new Array();
                _loc_5 = 0;
                while (_loc_5++ < 3 && param1.bytesAvailable > 0)
                {
                    // label
                    _loc_3[_loc_5] = param1.readUnsignedByte();
                }// end while
                _loc_4[0] = (_loc_3[0] & 252) >> 2;
                _loc_4[1] = (_loc_3[0] & 3) << 4 | _loc_3[1] >> 4;
                _loc_4[2] = (_loc_3[1] & 15) << 2 | _loc_3[2] >> 6;
                _loc_4[3] = _loc_3[2] & 63;
                _loc_6 = _loc_3.length;
                while (_loc_6++ < 3)
                {
                    // label
                    _loc_4[_loc_6 + 1] = 64;
                }// end while
                _loc_7 = 0;
                while (_loc_7++ < _loc_4.length)
                {
                    // label
                    _loc_2 = _loc_2 + BASE64_CHARS.charAt(_loc_4[_loc_7]);
                }// end while
            }// end while
            return _loc_2;
        }// end function

        public static function decode(param1:String) : String
        {
            param1 = enc_replace(param1, "d");
            var _loc_2:* = decodeToByteArray(param1);
            return _loc_2.readUTFBytes(_loc_2.length);
        }// end function

        private static function enc_replace(param1:String, param2:String, param3:Boolean = false) : String
        {
            var _loc_4:Array;
            var _loc_5:Array;
            var _loc_6:Array;
            var _loc_7:Array;
            if (param2 == "e")
            {
                _loc_4 = _loc_6;
                _loc_5 = _loc_7;
            }// end if
            if (param2 == "d")
            {
                _loc_4 = _loc_7;
                _loc_5 = _loc_6;
            }// end if
            var _loc_8:int;
            while (_loc_8 < _loc_4.length)
            {
                // label
                param1 = enc_replace_ab(_loc_4[_loc_8], _loc_5[_loc_8], param1);
                _loc_8++;
            }// end while
            return param1;
        }// end function

    }
}
