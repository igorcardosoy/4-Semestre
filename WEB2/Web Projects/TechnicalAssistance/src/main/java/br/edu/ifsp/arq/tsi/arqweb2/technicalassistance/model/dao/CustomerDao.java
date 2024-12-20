package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Address;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class CustomerDao {

    private final DataSource dataSource;

    public CustomerDao(DataSource dataSource) {
        super();
        this.dataSource = dataSource;
    }

    public Optional<Customer> getByCode(Long customerCode) {
        String sql = "select customer_code, name, email, phone, cpf, address_code from customer where customer_code=?";
        Optional<Customer> optional;
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, customerCode);
            optional = getCustomer(ps);
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no BD", e);
        }
        return optional;
    }

    public Optional<Customer> getByEmail(String email){
        String sql = "select customer_code, name, email, phone, cpf, address_code from customer where email=?";
        Optional<Customer> optional;
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, email);
            optional = getCustomer(ps);
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no BD", e);
        }
        return optional;
    }

    public Boolean save(Customer customer){
        Optional<Customer> optional = getByEmail(customer.getEmail());
        if(optional.isPresent()) {
            return false;
        }

        String sql = "insert into customer (name, email, phone, cpf, address_code) values (?, ?, ?, ?, ?)";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPhone());
            ps.setString(4, customer.getCpf());
            ps.setLong(5, customer.getAddress().getCode());
            ps.executeUpdate();
        }catch (SQLException e) {
            System.err.println("Erro ao salvar o cliente: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return false;
        }
        return true;
    }

    public Boolean update(Customer customer) {
        Optional<Customer> optional = getByCode(customer.getCode());
        if (optional.isEmpty()) return false;

        String sql = """
                        update customer
                        set name = ?,
                            email = ?,
                            phone = ?,
                            cpf = ?,
                            address_code = ?
                        where customer_code = ?""";

        try (Connection conn = dataSource.getConnection()){
             PreparedStatement ps = conn.prepareStatement(sql);
             ps.setString(1, customer.getName());
             ps.setString(2, customer.getEmail());
             ps.setString(3, customer.getPhone());
             ps.setString(4, customer.getCpf());
             ps.setLong(5, customer.getAddress().getCode());
             ps.setLong(6, customer.getCode());
             ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar o cliente: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return false;
        }

        return true;
    }

    public Boolean delete(Long code) {
        Optional<Customer> optional = getByCode(code);
        if (optional.isEmpty()) return false;
        String sql = "delete from customer where customer_code = ?";

        try (Connection conn = dataSource.getConnection()){
             PreparedStatement ps = conn.prepareStatement(sql);
             ps.setLong(1, code);
             ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao deletar o cliente: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return false;
        }

        return true;
    }

    public List<Customer> getAll() {
        List<Optional<Customer>> customers = new ArrayList<>();
        try {
            Connection conn = dataSource.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select customer_code, name, email, phone, cpf, address_code from customer");
            while (rs.next()) {
                Customer customer = creatCustomer(rs);
                if (customer == null) continue;

                customers.add(Optional.of(customer));
            }
        } catch (RuntimeException | SQLException e) {
            System.err.println("Erro ao buscar todos os clientes: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return List.of();
        }

        List<Customer> customersList = new ArrayList<>();
        for (Optional<Customer> customer : customers) {
            customer.ifPresent(customersList::add);
        }

        return customersList;
    }

    private Customer creatCustomer(ResultSet rs) throws SQLException, RuntimeException {
        AddressDao addressDao = new AddressDao(dataSource);
        Optional<Address> address = addressDao.getByCode(rs.getLong(6));

        if (address.isEmpty()) {
            return null;
        }

        Customer customer = new Customer();
        customer.setCode(rs.getLong(1));
        customer.setName(rs.getString(2));
        customer.setEmail(rs.getString(3));
        customer.setPhone(rs.getString(4));
        customer.setCpf(rs.getString(5));
        customer.setAddress(address.get());
        return customer;
    }

    private Optional<Customer> getCustomer(PreparedStatement ps) throws SQLException {
        Optional<Customer> customer = Optional.empty();
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                customer = Optional.ofNullable(creatCustomer(rs));
            }
        }
        return customer;
    }

}