package sk.kmikt.webovy_portal_na_streamovanie_hudby.music;

import sk.kmikt.webovy_portal_na_streamovanie_hudby.helper.DataSourceConnection;
import sk.kmikt.webovy_portal_na_streamovanie_hudby.user.User;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class MusicController {
    public boolean insertMusic(Music music) throws SQLException, NamingException {
        String sqlInsertMusic = "INSERT INTO songs (title, artist, genre, year, is_downloadable, url, uploaded_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlInsertMusic);

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

    public boolean insertDownloadedMusic(User user, Music music) throws SQLException, NamingException {
        String sqlInsertDownloadedMusic = "INSERT INTO downloaded_songs (user_id, song_id, dod) " +
                "VALUES (?, ?, ?)";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlInsertDownloadedMusic);

            ps.setInt(1, user.getUser_id());
            ps.setInt(2, music.getSong_id());

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();

            ps.setDate(3, new java.sql.Date(dateFormat.parse(dateFormat.format(date)).getTime()));

            return ps.executeUpdate() > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateDownloadedMusic(User user, Music music) throws SQLException, NamingException {
        String sqluUpdateDownloadedMusic = "UPDATE downloaded_songs SET dod = ? WHERE user_id = ? AND song_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqluUpdateDownloadedMusic);

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();

            ps.setDate(1, new java.sql.Date(dateFormat.parse(dateFormat.format(date)).getTime()));

            ps.setInt(2, user.getUser_id());
            ps.setInt(3, music.getSong_id());

            return ps.executeUpdate() > 0;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return false;
    }

    public Music getDownloadedMusicById(User user, Music music) throws SQLException, NamingException {
        String sqlGetDownloadedMusicById = "SELECT * FROM downloaded_songs WHERE song_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlGetDownloadedMusicById);
            ps.setInt(1, music.getSong_id());
            ResultSet rs = ps.executeQuery();

            while (rs.next())
            {
                int user_id = rs.getInt("user_id");
                int song_id = rs.getInt("song_id");

                return (music.getSong_id() == song_id && user.getUser_id() == user_id) ? new Music(song_id) : null;
            }

            return null;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }

        return null;
    }

    public java.util.Date getDownloadedMusicDoD(int userID, Music music) throws SQLException, NamingException {
        String sqlGetDownloadedMusicById = "SELECT * FROM downloaded_songs WHERE user_id = ? AND song_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlGetDownloadedMusicById);
            ps.setInt(1, userID);
            ps.setInt(2, music.getSong_id());
            ResultSet rs = ps.executeQuery();

            while (rs.next())
            {
                int user_id = rs.getInt("user_id");
                int song_id = rs.getInt("song_id");
                java.util.Date dod = new java.util.Date(rs.getDate("dod").getTime());

                return (music.getSong_id() == song_id && userID == user_id) ? dod : null;
            }

            return null;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }

        return null;
    }

    public ArrayList<Music> getAllDownloadedSongs(int userID) throws SQLException, NamingException {
        ArrayList<Music> allDownloadedSongs = new ArrayList<>();
        String sqlGetAllDownloadedSongs = "SELECT songs.* FROM songs JOIN downloaded_songs " +
                "ON songs.song_id = downloaded_songs.song_id " +
                "WHERE downloaded_songs.user_id = ?;";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlGetAllDownloadedSongs);
            ps.setInt(1, userID);
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

                allDownloadedSongs.add(song);
            }

            return allDownloadedSongs;
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return allDownloadedSongs;
        }
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
        String sqlDeleteDownloadedMusic = "DELETE FROM downloaded_songs WHERE song_id = ?";
        String sqlDeleteMusic = "DELETE FROM songs WHERE song_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps1 = conn.prepareStatement(sqlDeleteDownloadedMusic);
            ps1.setInt(1, id);

            if (ps1.executeUpdate() > 0)
            {
                PreparedStatement ps2 = conn.prepareStatement(sqlDeleteMusic);
                ps2.setInt(1, id);

                return ps2.executeUpdate() > 0;
            }
            else
            {
                PreparedStatement ps2 = conn.prepareStatement(sqlDeleteMusic);
                ps2.setInt(1, id);

                return ps2.executeUpdate() > 0;
            }
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
