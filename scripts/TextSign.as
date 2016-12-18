package
{
   public class TextSign
   {
       
      
      private var _text:String = "";
      
      private var _type:int = -1;
      
      public function TextSign(param1:String, param2:int)
      {
         super();
         this._text = param1;
         this._type = param2;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get type() : int
      {
         return this._type;
      }
   }
}
