package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Order;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.PaymentMethod;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status;

import javax.sql.DataSource;
import java.sql.*;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class OrderDao {

    private final DataSource dataSource;

    private final CustomerDao customerDao;
    private final PaymentMethodDao paymentMethodDao;
    private final StatusDao statusDao;

    public OrderDao(DataSource dataSource) {
        super();
        this.dataSource = dataSource;
        this.customerDao = new CustomerDao(dataSource);
        this.paymentMethodDao = new PaymentMethodDao(dataSource);
        this.statusDao = new StatusDao(dataSource);
    }

    public Optional<Order> getOrderByCode(Long code) {
        String sql = "select * from CUSTOMER_ORDER where code = ?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, code);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {

                CustomerDao customerDao = new CustomerDao(dataSource);
                PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);
                StatusDao statusDao = new StatusDao(dataSource);

                Optional<Customer> customer = customerDao.getCustomerByCode(rs.getLong("customer_code"));
                Optional<PaymentMethod> paymentMethod = paymentMethodDao.getPaymentMethodByCode(rs.getLong("payment_method_code"));
                Optional<Status> status = statusDao.getStatusdByName(rs.getString("status_name"));

                if (customer.isEmpty() || paymentMethod.isEmpty() || status.isEmpty()) {
                    return Optional.empty();
                }

                return createOrder(rs, customer.get(), paymentMethod.get(), status.get());
            }
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a leitura no BD", e);
        }
        return Optional.empty();
    }

    public List<Order> getAllOrderByCustomerCode(Long customerCode){
        String sql = "select * from CUSTOMER_ORDER where customer_code = ?";
        List<Order> orders = new LinkedList<>();
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, customerCode);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {

                Optional<Customer> customer = customerDao.getCustomerByCode(rs.getLong("customer_code"));
                Optional<PaymentMethod> paymentMethod = paymentMethodDao.getPaymentMethodByCode(rs.getLong("payment_method_code"));
                Optional<Status> status = statusDao.getStatusdByName(rs.getString("status_name"));

                if (customer.isEmpty() || paymentMethod.isEmpty() || status.isEmpty()) {
                    return List.of();
                }

                Optional<Order> order = createOrder(rs, customer.get(), paymentMethod.get(), status.get());
                if (order.isEmpty()) {
                    return List.of();
                }

                orders.add(order.get());
            }
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a leitura no BD", e);
        }

        return orders;
    }



    public Boolean save(Order order){
        Optional<Order> optional = getOrderByCode(order.getCode());
        if(optional.isPresent()) {
            return false;
        }

        String sql = "insert into CUSTOMER_ORDER(code, description, price, issue_date, end_date, customer_code, payment_method_code, status_name, observation) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, order.getCode());
            ps.setString(2, order.getDescription());
            ps.setDouble(3, order.getPrice());
            ps.setDate(4, Date.valueOf(order.getIssueDate()));
            ps.setDate(5, Date.valueOf(order.getEndDate()));
            ps.setLong(6, order.getCustomer().getCode());
            ps.setLong(7, order.getPaymentMethod().getCode());
            ps.setString(8, order.getStatus().name());
            ps.setString(9, order.getObservation());
            ps.executeUpdate();
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a escrita no BD", e);
        }
        return true;
    }

    private static Optional<Order> createOrder(ResultSet rs, Customer customer, PaymentMethod paymentMethod, Status status) throws SQLException {
        Order order = new Order();
        order.setCode(rs.getLong("code"));
        order.setDescription(rs.getString("description"));
        order.setPrice(rs.getDouble("price"));
        order.setIssueDate(rs.getDate("issue_date").toLocalDate());
        order.setEndDate(rs.getDate("end_date").toLocalDate());
        order.setCustomer(customer);
        order.setPaymentMethod(paymentMethod);
        order.setStatus(status);
        order.setObservation(rs.getString("observation"));

        return Optional.of(order);
    }

    public Boolean update(Order order){
        Optional<Order> optional = getOrderByCode(order.getCode());
        if(optional.isEmpty()) {
            return false;
        }

        String sql = "update CUSTOMER_ORDER set description = ?, price = ?, issue_date = ?, end_date = ?, customer_code = ?, payment_method_code = ?, status_name = ?, observation = ? where code = ?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, order.getDescription());
            ps.setDouble(2, order.getPrice());
            ps.setDate(3, Date.valueOf(order.getIssueDate()));
            ps.setDate(4, Date.valueOf(order.getEndDate()));
            ps.setLong(5, order.getCustomer().getCode());
            ps.setLong(6, order.getPaymentMethod().getCode());
            ps.setString(7, order.getStatus().name());
            ps.setString(8, order.getObservation());
            ps.setLong(9, order.getCode());
            ps.executeUpdate();
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a escrita no BD", e);
        }
        return true;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new LinkedList<>();
        String sql = "select * from CUSTOMER_ORDER";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){
            while(rs.next()) {

                Optional<Customer> customer = customerDao.getCustomerByCode(rs.getLong("customer_code"));
                Optional<PaymentMethod> paymentMethod = paymentMethodDao.getPaymentMethodByCode(rs.getLong("payment_method_code"));
                Optional<Status> status = statusDao.getStatusdByName(rs.getString("status_name"));

                if (customer.isEmpty() || paymentMethod.isEmpty() || status.isEmpty()) {
                    return List.of();
                }

                Optional<Order> order = createOrder(rs, customer.get(), paymentMethod.get(), status.get());
                if (order.isEmpty()) {
                    return List.of();
                }

                orders.add(order.get());
            }
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a leitura no BD", e);
        }

        return orders;
    }
}
