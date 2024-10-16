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

    public Optional<Status> getStatusdByName(String name) {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM ORDER_STATUS WHERE name = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, name);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        Status status = Status.valueOf(rs.getString("name"));
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
        Optional<Status> optional = getStatusdByName(status.name());
        if (optional.isPresent()) {
            return false;
        }

        String sql = "INSERT INTO ORDER_STATUS (name) VALUES (?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status.name());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
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
                    Status status = Status.valueOf(rs.getString("name"));
                    statuses.add(status);
                }
                return statuses;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
