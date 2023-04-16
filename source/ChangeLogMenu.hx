package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.text.FlxText;
import github.*;

using StringTools;

class ChangeLogMenu extends MusicBeatState {
    var changeLogText:FlxText = new FlxText(0, 0, FlxG.width, '', 20);
    var releaseArray:Array<GithubRelease> = new Array<GithubRelease>();

    var unfinishedTxt:FlxText = new FlxText(0, -50, FlxG.width, 'This menu is unfinished currently', 20);

    override function create(){
        super.create();

        changeLogText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        changeLogText.screenCenter(X);

        releaseArray = GithubAPI.getReleases('LilDrippyMyFnf', 'FNF-KysikiEngine', (e) -> {
            trace("Failed to get releases for changelog " + e.message);
        });

        for (i in releaseArray)
            changeLogText.text = i.body.trim();

        add(changeLogText);
        add(unfinishedTxt);
    }

    override function update(elapsed:Float){
        if (controls.BACK){
            MusicBeatState.switchState(new MainMenuState());
            FlxG.sound.play(Paths.sound('cancelMenu', 'preload'));
        }
        
        super.update(elapsed);
    }
}