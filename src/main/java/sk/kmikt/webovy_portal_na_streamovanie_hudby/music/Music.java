package sk.kmikt.webovy_portal_na_streamovanie_hudby.music;

public class Music {
    private Integer song_id;
    private String title;
    private String artist;
    private String genre;
    private Integer year;
    private String url;

    public Music(Integer song_id, String title, String artist, String genre, Integer year, String url) {
        this.song_id = song_id;
        this.title = title;
        this.artist = artist;
        this.genre = genre;
        this.year = year;
        this.url = url;
    }

    public Music(Integer song_id, String title, String artist, String genre, Integer year) {
        this.song_id = song_id;
        this.title = title;
        this.artist = artist;
        this.genre = genre;
        this.year = year;
    }

    public Music(Integer song_id, String url) {
        this.song_id = song_id;
        this.url = url;
    }

    public Music(String title, String artist, String genre, Integer year, String url) {
        this.title = title;
        this.artist = artist;
        this.genre = genre;
        this.year = year;
        this.url = url;
    }

    public Integer getSong_id() {
        return song_id;
    }

    public void setSong_id(Integer song_id) {
        this.song_id = song_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
