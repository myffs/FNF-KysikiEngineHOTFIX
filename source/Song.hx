package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var events:Array<Dynamic>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var gfVersion:String;
	var stage:String;

	var arrowSkin:String;
	var splashSkin:String;
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var events:Array<Dynamic>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var arrowSkin:String;
	public var splashSkin:String;
	public var speed:Float = 1;
	public var stage:String;
	public var player1:String = 'bf';
	public var player2:String = 'dad';
	public var gfVersion:String = 'gf';

	public static var isYoshChart = false;

	private static function onLoadJson(songJson:Dynamic) // Convert old charts to newest format
	{
		if(songJson.gfVersion == null)
		{
			songJson.gfVersion = songJson.player3;
			songJson.player3 = null;
		}

		if (songJson.noteTypes != null || songJson.keyNumber != null || songJson.sectionLength != null || songJson.scripts != null){
			isYoshChart = true; // found out it's a yoshicrafter engine chart
		}

		if(songJson.events == null)
		{
			songJson.events = [];
			for (secNum in 0...songJson.notes.length)
			{
				var sec:SwagSection = songJson.notes[secNum];

				var i:Int = 0;
				var notes:Array<Dynamic> = sec.sectionNotes;
				var len:Int = notes.length;
				while(i < len)
				{
					var note:Array<Dynamic> = notes[i];
					if(note[1] < 0)
					{
						songJson.events.push([note[0], [[note[2], note[3], note[4]]]]);
						notes.remove(note);
						len = notes.length;
					}
					else i++;
				}
			}
		}
	}

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
	{
		var rawJson = null;
		
		var formattedFolder:String = Paths.formatToSongPath(folder);
		var formattedSong:String = Paths.formatToSongPath(jsonInput);
		#if MODS_ALLOWED
		var moddyFile:String = Paths.modsJson(formattedFolder + '/' + formattedSong);
		if(FileSystem.exists(moddyFile)) {
			rawJson = File.getContent(moddyFile).trim();
		}
		#end

		if(rawJson == null) {
			#if sys
			rawJson = File.getContent(Paths.json(formattedFolder + '/' + formattedSong)).trim();
			#else
			rawJson = Assets.getText(Paths.json(formattedFolder + '/' + formattedSong)).trim();
			#end
		}

		if (rawJson == null)
			throw "Failed to locate JSON in " + formattedSong;

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
		}

		var songJson:Dynamic = parseJSONshit(rawJson);
		if(jsonInput != 'events') StageData.loadDirectory(songJson);
		onLoadJson(songJson);
		return songJson;
	}
	
	/*inline static function convertYoshChart(rawJson:String){
		var songJson:SwagSong;
		var yoshChart:YoshSong;
		yoshChart = cast Json.parse(rawJson).song;

		for (i in yoshChart.noteTypes){
			switch (i){
				case 'Default Note':
					i = editors.ChartingState.noteTypeList[0];
				case 'Alt Anim Note':
					i = editors.ChartingState.noteTypeList[1];
				case 'Hurt Note':
					i = editors.ChartingState.noteTypeList[3];
				case 'GF Note':
					i = editors.ChartingState.noteTypeList[4];
				case 'No Anim Note':
					i = editors.ChartingState.noteTypeList[5];
				case _:
					i = editors.ChartingState.noteTypeList[0];
					trace("Unsupported Type found!");
			}
		}
		songJson = null;
		songJson = {
			bpm: Math.abs(yoshChart.bpm),
			needsVoices: yoshChart.needsVoices,
			stage: yoshChart.stage,
			speed: yoshChart.speed,
			player1: yoshChart.player1,
			player2: yoshChart.player2,
			arrowSkin: 'NOTE_assets',
			splashSkin: 'noteSplashes'
		}
		yoshChart = null;
		return songJson;
	}*/

	inline private function parseYoshChart(rawJson:String):YoshSong
		return cast Json.parse(rawJson).song;

	inline public static function parseJSONshit(rawJson:String):SwagSong
		// return isYoshChart ? convertYoshChart(rawJson) : cast Json.parse(rawJson).song;
		return cast Json.parse(rawJson).song;
}

typedef YoshSong =
{
	var events:Array<Dynamic>;
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Int;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var keyNumber:Null<Int>;
	var noteTypes:Array<String>;

	var stage:String;

	@:optional var sectionLength:Null<Int>;
	@:optional var scripts:Array<String>;
	@:optional var gfVersion:String;
	@:optional var noGF:Bool;
	@:optional var noBF:Bool;
	@:optional var noDad:Bool;
}