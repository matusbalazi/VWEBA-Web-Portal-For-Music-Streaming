package sk.kmikt.webovy_portal_na_streamovanie_hudby.music;

import sk.kmikt.webovy_portal_na_streamovanie_hudby.helper.DataSourceConnection;
import sk.kmikt.webovy_portal_na_streamovanie_hudby.user.User;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MusicController {
    public boolean insertMusic(Music music) throws SQLException, NamingException {
        String sql = "INSERT INTO songs (title, artist, genre, year, is_downloadable, url, uploaded_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, music.getTitle());
            ps.setString(2, music.getArtist());
            ps.setString(3, music.getGenre());
            ps.setInt(4, music.getYear());
            ps.setBoolean(5, music.isIs_downloadable());
            ps.setString(6, music.getUrl());
            ps.setString(7, music.getUploaded_by());

            return ps.executeUpdate() > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateMusic(Music music) throws SQLException, NamingException
    {
        String sqlUpdateMusic = "UPDATE songs SET title = ?, artist = ?, genre = ?, year = ?, is_hidden = ?, is_downloadable = ? WHERE song_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlUpdateMusic);

            ps.setString(1, music.getTitle());
            ps.setString(2, music.getArtist());
            ps.setString(3, music.getGenre());
            ps.setInt(4, music.getYear());
            ps.setBoolean(5, music.isIs_hidden());
            ps.setBoolean(6, music.isIs_downloadable());
            ps.setInt(7, music.getSong_id());

            return ps.executeUpdate() > 0;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return false;
    }

    public boolean changeFile(Music music) throws SQLException, NamingException
    {
        String sqlChangeFile = "UPDATE songs SET url = ? WHERE song_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlChangeFile);

            ps.setString(1, music.getUrl());
            ps.setInt(2, music.getSong_id());

            return ps.executeUpdate() > 0;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteMusic(int id) throws SQLException, NamingException
    {
        String sqlDeleteMusic = "DELETE FROM songs WHERE song_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlDeleteMusic);

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;
        }
        catch (Exception e)
        {
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
                        rs.getBoolean("is_hidden"),
                        rs.getBoolean("is_downloadable"),
                        rs.getString("url"),
                        rs.getString("uploaded_by")
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

    public Music getMusicById(int id) throws SQLException, NamingException
    {
        String sqlGetMusicById = "SELECT * FROM songs WHERE song_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlGetMusicById);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next())
            {
                int song_id = rs.getInt("song_id");
                String title = rs.getString("title");
                String artist = rs.getString("artist");
                String genre = rs.getString("genre");
                int year = rs.getInt("year");
                boolean is_hidden = rs.getBoolean("is_hidden");
                boolean is_downloadable = rs.getBoolean("is_downloadable");
                String url = rs.getString("url");

                return id == song_id ? new Music(song_id, title, artist, genre, year, is_hidden, is_downloadable, url) : null;
            }

            return null;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }

        return null;
    }
}
