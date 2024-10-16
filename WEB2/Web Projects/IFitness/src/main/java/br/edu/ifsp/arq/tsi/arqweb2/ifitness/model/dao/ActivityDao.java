package br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.dao;

import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.Activity;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.ActivityType;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.User;

import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ActivityDao {

    private final DataSource dataSource;

    public ActivityDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public Boolean save(Activity activity) {
        String sql = "insert into ACTIVITY (type, activity_date, distance, duration, user_id) values(?,?,?,?,?)";
        try (Connection con = dataSource.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, activity.getType().toString());
            ps.setDate(2, Date.valueOf(activity.getDate()));
            ps.setDouble(3, activity.getDistance());
            ps.setInt(4, activity.getDuration());
            ps.setLong(5, activity.getUser().getId());
            ps.executeUpdate();
            return true;
        } catch (SQLException sqlException) {
            throw new RuntimeException("Erro ao inserir dados", sqlException);
        }
    }

    public List<Activity> getActivitiesByUser(User user) {
        String sql = "select * from ACTIVITY where user_id=?";
        List<Activity> activities = new ArrayList<>();
        try (Connection con = dataSource.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, user.getId());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Activity activity = new Activity();
                    setActivityParams(activity, rs);
                    activity.setUser(user);
                    activities.add(activity);
                }
            }
            return activities;
        } catch (SQLException sqlException) {
            throw new RuntimeException("Erro durante a consulta", sqlException);
        }
    }

    public Activity getActivityById(Long id) {
        String sql = "select * from ACTIVITY where id=?";
        Activity activity = null;
        try (Connection con = dataSource.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    activity = new Activity();
                    setActivityParams(activity, rs);
                    User user = new User();
                    user.setId(rs.getLong(6));
                    activity.setUser(user);
                }
            }
            return activity;
        } catch (SQLException sqlException) {
            throw new RuntimeException("Erro durante a consulta", sqlException);
        }
    }

    public Boolean update(Activity activity) {
        String sql = "update ACTIVITY set " + "type=?," + "activity_date=?," + "distance=?," + "duration=?,"
                + "user_id=?" + " where id=?";
        try (Connection con = dataSource.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, activity.getType().toString());
            ps.setDate(2, Date.valueOf(activity.getDate()));
            ps.setDouble(3, activity.getDistance());
            ps.setInt(4, activity.getDuration());
            ps.setLong(5, activity.getUser().getId());
            ps.setLong(6, activity.getId());
            ps.executeUpdate();
            return true;
        } catch (SQLException sqlException) {
            throw new RuntimeException("Erro ao atualizar dados", sqlException);
        }
    }

    public Boolean delete(Activity activity) {
        String sql = "delete from ACTIVITY where id=?";
        try (Connection con = dataSource.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, activity.getId());
            ps.executeUpdate();
            return true;
        } catch (SQLException sqlException) {
            throw new RuntimeException("Erro ao remover dados", sqlException);
        }
    }

    private void setActivityParams(Activity activity, ResultSet rs) throws SQLException {
        activity.setId(rs.getLong(1));
        activity.setType(ActivityType.valueOf(rs.getString(2)));
        activity.setDate(LocalDate.parse(rs.getDate(3).toString()));
        activity.setDistance(rs.getDouble(4));
        activity.setDuration(rs.getInt(5));
    }
}
