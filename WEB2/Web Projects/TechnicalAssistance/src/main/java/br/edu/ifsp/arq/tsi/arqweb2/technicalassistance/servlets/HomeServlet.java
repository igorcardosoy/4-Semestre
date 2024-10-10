package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.CustomerDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        CustomerDao customerDao = new CustomerDao(DataSourceSearcher.getInstance().getDataSource());

        List<Customer> customers = new LinkedList<>();
        List<Optional<Customer>> optionals = customerDao.getAllCustomers();

        for (Optional<Customer> optional : optionals) {
            optional.ifPresent(customers::add);
        }

        req.setAttribute("customers", customers);
        req.getRequestDispatcher("home.jsp").forward(req, resp);
    }
}
