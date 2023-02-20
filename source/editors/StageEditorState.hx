package editors;

import flixel.FlxG;
import flixel.FlxBasic;

/*typedef Object
{
    object1:BGSprite,
    object2:Dynamic,
    animated:Bool,
    args:Array<Dynamic>
}*/

typedef Stage
    public var name:String;
    public var directory:String;
	public var alpha:Float;
	public var xAxis:Float;
	public var yAxis:Float;
	public var scrollX:Float;
	public var scrollY:Float;
	public var scaleX:Float;
	public var scaleY:Float;
	public var flipX:Bool;
	public var flipY:Bool;
	public var beforeChars:Bool;    
}

class StageEditorState extends MusicBeatState {
    public static var instance:StageEditorState = null;

    // var objects:Array<Object> = [];

    public function new(){
        instance = this;

        super();
    }

    override function create(){
        /*objects = [
            getObjects();
        ];*/

        super.create();
    }

    /*inline function getObjects(daObj1:Dynamic, daObj2:Dynamic, anim:Bool = false, cum:Array<Dynamic>):Object{
        return {object1:daObj1, object2:daObj2, animated:anim, args:cum};
    }*/

    override function destroy(){
        instance = null;

        return super.destroy();
    }    
}
