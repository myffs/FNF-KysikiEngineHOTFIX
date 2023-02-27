package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class CustomMenus { 
	public static var MenuStuff:Array<Dynamic> = [ //Menu Name, Menu Discription, Menu Image
 ["Story Mode", "Main beginning menu.", 'menu_story_mode'],
 ["Freeplay",   "Freely play any story mode songs.", 'menu_freeplay'],
 ["Mods",       "Main modding menu.",      'menu_mods'],
 ["Awards",     "Main Awards menu.",    'menu_awards'],
 ["Credits",    "Developer + Creators menu.",  'menu_credits'],
 ["Options",    "freely change anything in game to your style.",  'menu_options']
   ];
}