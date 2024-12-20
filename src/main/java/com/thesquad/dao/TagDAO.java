package com.thesquad.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.thesquad.models.TagModel;
import com.thesquad.connection.DBConnection;

public class TagDAO {

    public TagDAO() {

    }

    public void create(TagModel tag, DBConnection connection) {
        String sql = "INSERT INTO descritores(nome) values(?)";
        try {
            PreparedStatement ps = connection.getConnection().prepareStatement(sql);
            ps.setString(1, tag.getName());

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(TagModel tag, DBConnection connection) {
        String sql = "UPDATE descritores SET nome = ? WHERE pk_descritores = ?";
        try {
            PreparedStatement ps = connection.getConnection().prepareStatement(sql);
            ps.setString(1, tag.getName());
            ps.setInt(2, tag.getTagId());

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int tagId, DBConnection connection) {
        String sql = "DELETE FROM descritores WHERE pk_descritores = ?";
        try {
            PreparedStatement ps = connection.getConnection().prepareStatement(sql);
            ps.setInt(1, tagId);

            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<TagModel> getAll(DBConnection connection) {
        String sql = "SELECT * FROM descritores";

        List<TagModel> tagList = new ArrayList<>();

        try {
            PreparedStatement ps = connection.getConnection().prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                TagModel tag = new TagModel();
                tag.setTagId(resultSet.getInt(1));
                tag.setName(resultSet.getString(2));
                tag.setCreationDate(resultSet.getTimestamp(3).toLocalDateTime());

                tagList.add(tag);
            }
            ps.close();
            resultSet.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tagList;
    }

    public TagModel getTagById(int tagId, DBConnection connection) {
        String sql = "SELECT * FROM descritores WHERE pk_descritores = ?";

        try {
            TagModel tag = new TagModel();
            PreparedStatement ps = connection.getConnection().prepareStatement(sql);
            ps.setInt(1, tagId);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                tag.setTagId(resultSet.getInt(1));
                tag.setName(resultSet.getString(2));
                tag.setCreationDate(resultSet.getTimestamp(3).toLocalDateTime());
            }

            ps.close();
            resultSet.close();
            return tag;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
