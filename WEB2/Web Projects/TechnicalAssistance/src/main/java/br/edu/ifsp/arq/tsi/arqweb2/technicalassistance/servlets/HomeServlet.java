package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Order;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.CustomerDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.OrderDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.StatusDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        CustomerDao customerDao = new CustomerDao(DataSourceSearcher.getInstance().getDataSource());
        List<Customer> customers = customerDao.getAllCustomers();

        OrderDao orderDao = new OrderDao(DataSourceSearcher.getInstance().getDataSource());
        List<Order> orders = orderDao.getAllOrders();

        StatusDao statusDao = new StatusDao(DataSourceSearcher.getInstance().getDataSource());
        List<Status> statuses = statusDao.getAllStatuses();

        req.setAttribute("customers", customers);
        req.setAttribute("orders", orders);
        req.setAttribute("statuses", statuses);
        req.getRequestDispatcher("./pages/home/page.jsp").forward(req, resp);
    }
}
