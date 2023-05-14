package sk.kmikt.webovy_portal_na_streamovanie_hudby.music;

public class Music {
    private Integer song_id;
    private String title;
    private String artist;
    private String genre;
    private Integer year;
    private boolean is_hidden;
    private boolean is_downloadable;
    private String url;
    private String uploaded_by;

    public Music(Integer song_id, String title, String artist, String genre, Integer year, boolean is_hidden, boolean is_downloadable, String url, String uploaded_by) {
        this.song_id = song_id;
        this.title = title;
        this.artist = artist;
        this.genre = genre;
        this.year = year;
        this.is_hidden = is_hidden;
        this.is_downloadable = is_downloadable;
        this.url = url;
        this.uploaded_by = uploaded_by;
    }

    public Music(Integer song_id, String title, String artist, String genre, Integer year, boolean is_hidden, boolean is_downloadable, String url) {
        this.song_id = song_id;
        this.title = title;
        this.artist = artist;
        this.genre = genre;
        this.year = year;
        this.is_hidden = is_hidden;
        this.is_downloadable = is_downloadable;
        this.url = url;
    }

    public Music(Integer song_id, String title, String artist, String genre, Integer year, boolean is_hidden, boolean is_downloadable) {
        this.song_id = song_id;
        this.title = title;
        this.artist = artist;
        this.genre = genre;
        this.year = year;
        this.is_hidden = is_hidden;
        this.is_downloadable = is_downloadable;
    }

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

    public Music(String title, String artist, String genre, Integer year, boolean is_downloadable, String url, String uploaded_by) {
        this.title = title;
        this.artist = artist;
        this.genre = genre;
        this.year = year;
        this.is_downloadable = is_downloadable;
        this.url = url;
        this.uploaded_by = uploaded_by;
    }

    public Music(String title, String artist, String genre, Integer year, boolean is_downloadable, String url) {
        this.title = title;
        this.artist = artist;
        this.genre = genre;
        this.year = year;
        this.is_downloadable = is_downloadable;
        this.url = url;
    }

    public Music(String title, String artist, String genre, Integer year, boolean is_hidden, boolean is_downloadable, String url) {
        this.title = title;
        this.artist = artist;
        this.genre = genre;
        this.year = year;
        this.is_hidden = is_hidden;
        this.is_downloadable = is_downloadable;
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

    public boolean isIs_hidden() {
        return is_hidden;
    }

    public void setIs_hidden(boolean is_hidden) {
        this.is_hidden = is_hidden;
    }

    public boolean isIs_downloadable() {
        return is_downloadable;
    }

    public void setIs_downloadable(boolean is_downloadable) {
        this.is_downloadable = is_downloadable;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getUploaded_by() {
        return uploaded_by;
    }

    public void setUploaded_by(String uploaded_by) {
        this.uploaded_by = uploaded_by;
    }
}
