package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.PaymentMethod;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class PaymentMethodDao {

    private final DataSource dataSource;

    public PaymentMethodDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public Optional<PaymentMethod> getPaymentMethodByCode(Long code) {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM PAYMENT_METHOD WHERE code = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setLong(1, code);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        PaymentMethod paymentMethod = new PaymentMethod();
                        paymentMethod.setCode(rs.getLong("code"));
                        paymentMethod.setName(rs.getString("name"));
                        return Optional.of(paymentMethod);
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return Optional.empty();
    }

    public Boolean save(PaymentMethod paymentMethod) throws RuntimeException {
        Optional<PaymentMethod> optional = getPaymentMethodByCode(paymentMethod.getCode());
        if (optional.isPresent()) {
            return false;
        }

        String sql = "INSERT INTO PAYMENT_METHOD (code, name) VALUES (?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, paymentMethod.getCode());
            ps.setString(2, paymentMethod.getName());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return true;
    }

    public List<PaymentMethod> getAllPaymentMethods() {
        List<PaymentMethod> paymentMethods = new LinkedList<>();
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM PAYMENT_METHOD";
            try (PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PaymentMethod paymentMethod = new PaymentMethod();
                    paymentMethod.setCode(rs.getLong("code"));
                    paymentMethod.setName(rs.getString("name"));
                    paymentMethods.add(paymentMethod);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return paymentMethods;
    }
}
