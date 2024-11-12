package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Employee;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class EmployeeDao {

    private final DataSource dataSource;

    public EmployeeDao(DataSource dataSource) {
        super();
        this.dataSource = dataSource;
    }

    public Optional<Employee> getByCode(Long customerCode) {
        String sql = "select employee_code, name, cpf, email, password from employee where employee_code=?";
        Optional<Employee> optional;
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, customerCode);
            optional = getCustomer(ps);
        } catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no BD", e);
        }
        return optional;
    }

    public Optional<Employee> getByEmail(String email) {
        String sql = "select employee_code, name, cpf, email, password from employee where email=?";
        Optional<Employee> optional;
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            optional = getCustomer(ps);
        } catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no BD", e);
        }
        return optional;
    }

    public Boolean save(Employee customer) {
        Optional<Employee> optional = getByEmail(customer.getEmail());
        if (optional.isPresent()) {
            return false;
        }

        String sql = "insert into employee (name, cpf, email, password) values (?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getCpf());
            ps.setString(3, customer.getEmail());
            ps.setString(4, customer.getPassword());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao salvar o cliente: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return false;
        }
        return true;
    }

    public Boolean update(Employee employee) {

        String sql = """
                update employee
                set name = ?,
                    cpf = ?,
                    email = ?,
                    password = ?
                where employee_code = ?""";

        try (Connection conn = dataSource.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, employee.getName());
            ps.setString(2, employee.getCpf());
            ps.setString(3, employee.getEmail());
            ps.setString(4, employee.getPassword());
            ps.setLong(5, employee.getCode());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar o cliente: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return false;
        }

        return true;
    }

    public Boolean delete(Long code) {
        Optional<Employee> optional = getByCode(code);
        if (optional.isEmpty()) return false;
        String sql = "delete from employee where employee_code = ?";

        try (Connection conn = dataSource.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, code);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao deletar funcionario: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return false;
        }

        return true;
    }

    public List<Employee> getAll() {
        List<Optional<Employee>> customers = new ArrayList<>();
        try {
            Connection conn = dataSource.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select customer_code, name, email, phone, cpf, address_code from customer");
            while (rs.next()) {
                customers.add(Optional.of(creatEmployee(rs)));
            }
        } catch (RuntimeException | SQLException e) {
            System.err.println("Erro ao buscar todos os clientes: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return List.of();
        }

        List<Employee> customersList = new ArrayList<>();
        for (Optional<Employee> customer : customers) {
            customer.ifPresent(customersList::add);
        }

        return customersList;
    }

    private Employee creatEmployee(ResultSet rs) throws SQLException, RuntimeException {
        Employee employee = new Employee();
        employee.setCode(rs.getLong(1));
        employee.setName(rs.getString(2));
        employee.setCpf(rs.getString(3));
        employee.setEmail(rs.getString(4));
        employee.setPassword(rs.getString(5));

        return employee;
    }

    private Optional<Employee> getCustomer(PreparedStatement ps) throws SQLException {
        Optional<Employee> customer = Optional.empty();
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                customer = Optional.of(creatEmployee(rs));
            }
        }
        return customer;
    }

}