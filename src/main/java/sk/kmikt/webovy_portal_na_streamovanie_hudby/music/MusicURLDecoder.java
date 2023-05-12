package sk.kmikt.webovy_portal_na_streamovanie_hudby.music;

public class MusicURLDecoder {
    public String decode(String url) {
        return url.substring(url.lastIndexOf(".") + 1);
    }
}
