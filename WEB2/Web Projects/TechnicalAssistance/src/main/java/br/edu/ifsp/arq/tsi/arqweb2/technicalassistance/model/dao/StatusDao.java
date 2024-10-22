package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class StatusDao {

    private final DataSource dataSource;

    public StatusDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public Optional<Status> getStatusdByCode(Long code) {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM ORDER_STATUS WHERE code = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setLong(1, code);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        Status status = new Status();
                        status.setCode(rs.getLong("code"));
                        status.setName(rs.getString("name"));
                        return Optional.of(status);
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return Optional.empty();
    }

    public Boolean save(Status status) throws RuntimeException {
        Optional<Status> optional = getStatusdByCode(status.getCode());
        if (optional.isPresent()) {
            return false;
        }

        String sql = "INSERT INTO ORDER_STATUS (code, name) VALUES (?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, status.getCode());
            ps.setString(2, status.getName());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public List<Status> getAllStatuses() {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM ORDER_STATUS";
            try (PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                List<Status> statuses = new LinkedList<>();
                while (rs.next()) {
                    Status status = new Status();
                    status.setCode(rs.getLong("code"));
                    status.setName(rs.getString("name"));
                    statuses.add(status);
                }
                return statuses;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return List.of();
        }
    }

    public Boolean update(Status status) {
        Optional<Status> optional = getStatusdByCode(status.getCode());
        if (optional.isEmpty()) {
            return false;
        }

        String sql = "UPDATE ORDER_STATUS SET name = ? WHERE code = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status.getName());
            ps.setLong(2, status.getCode());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public Boolean delete(Long code) {
        Optional<Status> optional = getStatusdByCode(code);
        if (optional.isEmpty()) return false;

        String sql = "DELETE FROM ORDER_STATUS WHERE code = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, code);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }
}
