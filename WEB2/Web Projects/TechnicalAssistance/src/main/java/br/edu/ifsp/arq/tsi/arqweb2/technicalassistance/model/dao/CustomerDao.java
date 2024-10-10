package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CustomerDao {

    private final DataSource dataSource;

    public CustomerDao(DataSource dataSource) {
        super();
        this.dataSource = dataSource;
    }

    private Optional<Customer> getCustomer(Optional<Customer> optional, PreparedStatement ps) throws SQLException {
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                optional = Optional.of(creatCustomer(rs));
            }
        }
        return optional;
    }

    public Optional<Customer> getCustomerByEmail(String email){
        String sql = "select code, name, email, phone, cpf from CUSTOMER where email=?";
        Optional<Customer> optional = Optional.empty();
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, email);
            optional = getCustomer(optional, ps);
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no BD", e);
        }
        return optional;
    }

    public Boolean save(Customer user){
        Optional<Customer> optional = getCustomerByEmail(user.getEmail());
        if(optional.isPresent()) {
            return false;
        }

        String sql = "insert into CUSTOMER (code, name, email, phone, cpf) values (?, ?, ?, ?, ?)";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, user.getCode());
            ps.setString(2, user.getName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setLong(5, user.getCpf());
            ps.executeUpdate();
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a escrita no BD", e);
        }
        return true;
    }

    public List<Optional<Customer>> getAllCustomers() {
        List<Optional<Customer>> customers = new ArrayList<>();
        try {
            Connection conn = dataSource.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select code, name, email, phone, cpf from CUSTOMER");
            while (rs.next()) {
                Customer customer = creatCustomer(rs);
                customers.add(Optional.of(customer));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no BD", e);
        }

        return customers;
    }

    private Customer creatCustomer(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setCode(rs.getInt(1));
        customer.setName(rs.getString(2));
        customer.setEmail(rs.getString(3));
        customer.setPhone(rs.getString(4));
        customer.setCpf(rs.getLong(5));
        return customer;
    }
}