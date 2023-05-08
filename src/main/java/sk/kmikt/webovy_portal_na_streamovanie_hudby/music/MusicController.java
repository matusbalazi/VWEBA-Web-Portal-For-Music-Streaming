package sk.kmikt.webovy_portal_na_streamovanie_hudby.music;

import sk.kmikt.webovy_portal_na_streamovanie_hudby.helper.DataSourceConnection;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MusicController {
    public boolean insertMusic(Music music) throws SQLException, NamingException {
        String sql = "INSERT INTO songs (title, artist, genre, year, url) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, music.getTitle());
            ps.setString(2, music.getArtist());
            ps.setString(3, music.getGenre());
            ps.setInt(4, music.getYear());
            ps.setString(5, music.getUrl());

            return ps.executeUpdate() > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public ArrayList<Music> getAllSongs() throws SQLException, NamingException {
        ArrayList<Music> allSongs = new ArrayList<>();
        String sql = "SELECT * FROM songs";
        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next())
            {
                Music song = new Music(
                        rs.getInt("song_id"),
                        rs.getString("title"),
                        rs.getString("artist"),
                        rs.getString("genre"),
                        rs.getInt("year"),
                        rs.getString("url")
                );

                allSongs.add(song);
            }

            return allSongs;
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return allSongs;
        }
    }
}
