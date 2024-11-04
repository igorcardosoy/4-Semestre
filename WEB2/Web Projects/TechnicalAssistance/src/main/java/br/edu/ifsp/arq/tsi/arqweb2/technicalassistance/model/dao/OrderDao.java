package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Order;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.PaymentMethod;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status;

import javax.sql.DataSource;
import java.sql.*;
import java.util.Arrays;
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

    public Optional<Order> getByCode(Long code) {
        String sql = "select * from customer_order where customer_order_code = ?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, code);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {

                CustomerDao customerDao = new CustomerDao(dataSource);
                PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);
                StatusDao statusDao = new StatusDao(dataSource);

                Optional<Customer> customer = customerDao.getByCode(rs.getLong("customer_code"));
                Optional<PaymentMethod> paymentMethod = paymentMethodDao.getPaymentMethodByCode(rs.getLong("payment_method_code"));
                Optional<Status> status = statusDao.getByCode(rs.getLong("status_code"));

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

    public List<Order> getAllByCustomerCode(Long customerCode){
        String sql = "select * from customer_order where customer_code = ?";
        List<Order> orders = new LinkedList<>();
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, customerCode);
            ResultSet rs = ps.executeQuery();
            if (!getOrders(orders, rs)) return List.of();
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a leitura no BD", e);
        }

        return orders;
    }

    public Boolean save(Order order){

        String sql = "insert into customer_order(description, price, issue_date, end_date, customer_code, payment_method_code, status_code, observation) values(?, ?, ?, ?, ?, ?, ?, ?)";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            creatOrder(order, ps);
            ps.executeUpdate();
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a escrita no BD", e);
        }
        return true;
    }

    public Boolean update(Order order){
        Optional<Order> optional = getByCode(order.getCode());
        if(optional.isEmpty()) {
            return false;
        }

        String sql = "update customer_order set description = ?, price = ?, issue_date = ?, end_date = ?, customer_code = ?, payment_method_code = ?, status_code = ?, observation = ? where customer_order_code = ?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            creatOrder(order, ps);
            ps.setLong(9, order.getCode());
            ps.executeUpdate();
        }catch (SQLException e) {
            System.err.println("Erro ao atualizar o pedido: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return false;
        }

        return true;
    }

    private void creatOrder(Order order, PreparedStatement ps) throws SQLException {
        ps.setString(1, order.getDescription());
        ps.setDouble(2, order.getPrice());
        ps.setDate(3, Date.valueOf(order.getIssueDate()));
        ps.setDate(4, Date.valueOf(order.getEndDate()));
        ps.setLong(5, order.getCustomer().getCode());
        ps.setLong(6, order.getPaymentMethod().getCode());
        ps.setLong(7, order.getStatus().getCode());
        ps.setString(8, order.getObservation());
    }

    public Boolean delete(Long code){
        Optional<Order> optional = getByCode(code);
        if(optional.isEmpty()) {
            return false;
        }

        String sql = "delete from customer_order where customer_order_code = ?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, code);
            ps.executeUpdate();
        }catch (SQLException e) {
            System.err.println("Erro ao deletar o pedido: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
        }
        return true;
    }

    public List<Order> getAll() {
        List<Order> orders = new LinkedList<>();
        String sql = "select * from customer_order";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){
            if (!getOrders(orders, rs)) return List.of();
        }catch (SQLException e) {
            System.err.println("Erro ao buscar todos os pedidos: " + e.getMessage() + Arrays.toString(e.getStackTrace()));
            return List.of();
        }

        return orders;
    }

    private boolean getOrders(List<Order> orders, ResultSet rs) throws SQLException {
        while(rs.next()) {
            Optional<Customer> customer = customerDao.getByCode(rs.getLong("customer_code"));
            Optional<PaymentMethod> paymentMethod = paymentMethodDao.getPaymentMethodByCode(rs.getLong("payment_method_code"));
            Optional<Status> status = statusDao.getByCode(rs.getLong("status_code"));

            if (customer.isEmpty() || paymentMethod.isEmpty() || status.isEmpty()) {
                return false;
            }

            Optional<Order> order = createOrder(rs, customer.get(), paymentMethod.get(), status.get());
            if (order.isEmpty()) {
                return false;
            }

            orders.add(order.get());
        }

        return true;
    }

    private Optional<Order> createOrder(ResultSet rs, Customer customer, PaymentMethod paymentMethod, Status status) throws SQLException {
        Order order = new Order();
        order.setCode(rs.getLong("customer_order_code"));
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
}
