package;

import haxe.Json;
import haxe.Http;
import haxe.Exception;
import github.*;

using StringTools;

// based on Codename Engine
class GithubAPI {
    public static function getReleases(user:String, repo:String, ?onError:Exception->Void):Array<GithubRelease>{
        try {
            var url = 'https://api.github.com/repos/${user}/${repo}/releases';

            var data:Dynamic = Json.parse(__requestOnGitHubServers(url));
            if (!(data is Array))
                throw new Exception("Failed to retrieve Github releases from " + url + ": " + data);

            return data;
        } 
        catch(e) {
            if (onError != null)
                onError(e);
        }
        return [];
    }

    private static function __requestOnGitHubServers(url:String){
        var h = new Http(url);
        h.setHeader("User-Agent", "request");
		var r = null;
		h.onData = (d) -> r = d;
		h.onError = (e) -> throw e;
		h.request(false);
		return r;
    }

    inline function filterRelease(release:GithubRelease, filter:String):Dynamic {
        return switch (filter.toLowerCase()) {
            case 'url':
                release.url;
            case 'html_url':
                release.html_url;
            case 'assets_url':
                release.assets_url;
            case 'upload_url':
                release.upload_url;
            case 'tarball_url':
                release.tarball_url;
            case 'zipball_url':
                release.zipball_url;
            case 'id':
                release.id;
            case 'tag_name':
                release.tag_name;
            case 'target_commitish':
                release.target_commitish;
            case 'name':
                release.name;
            case 'body':
                release.body;
            case 'draft':
                release.draft;
            case 'prelease':
                release.prelease;
            case 'created_at':
                release.created_at;
            case 'published_at':
                release.published_at;
            case 'author':
                release.author;
            case 'assets':
                release.assets;
            default:
                null;    
        }
    }
}