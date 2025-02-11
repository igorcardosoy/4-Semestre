package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.PaymentMethod;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
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
            String sql = "SELECT * FROM payment_method WHERE payment_method_code = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setLong(1, code);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        PaymentMethod paymentMethod = new PaymentMethod();
                        paymentMethod.setCode(rs.getLong(1));
                        paymentMethod.setName(rs.getString(2));
                        return Optional.of(paymentMethod);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar o método de pagamento: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return Optional.empty();
        }
        return Optional.empty();
    }

    public Boolean save(PaymentMethod paymentMethod) throws RuntimeException {
        String sql = "INSERT INTO payment_method (name) VALUES (?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, paymentMethod.getName());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao salvar o método de pagamento: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return false;
        }

        return true;
    }

    public List<PaymentMethod> getAllPaymentMethods() {
        List<PaymentMethod> paymentMethods = new LinkedList<>();
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM payment_method";
            try (PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PaymentMethod paymentMethod = new PaymentMethod();
                    paymentMethod.setCode(rs.getLong(1));
                    paymentMethod.setName(rs.getString(2));
                    paymentMethods.add(paymentMethod);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar todos os métodos de pagamento: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return List.of();
        }

        return paymentMethods;
    }

    public Boolean update(PaymentMethod paymentMethod){
        String sql = "update payment_method set name=? where payment_method_code=?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, paymentMethod.getName());
            ps.setLong(2, paymentMethod.getCode());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar o método de pagamento: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return false;
        }
        return true;
    }

    public Boolean delete(Long code){
        Optional<PaymentMethod> optional = getPaymentMethodByCode(code);
        if(optional.isEmpty()) {
            return false;
        }

        String sql = "delete from payment_method where payment_method_code = ?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, code);
            ps.executeUpdate();
        }catch (SQLException e) {
            System.err.println("Erro ao deletar o método de pagamento: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return false;
        }
        return true;
    }
}
