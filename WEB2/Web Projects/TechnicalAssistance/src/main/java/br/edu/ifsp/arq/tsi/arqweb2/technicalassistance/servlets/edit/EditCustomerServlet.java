package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.edit;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Address;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.AddressDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.CustomerDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/home/edit/customer")
public class EditCustomerServlet extends HttpServlet {
    private static final String url = "/pages/home/register/customer/page.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));
        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();

        CustomerDao customerDao = new CustomerDao(dataSource);
        Optional<Customer> customer = customerDao.getByCode((long) code);
        if (customer.isEmpty()) {
            req.setAttribute("error", "Customer not found");
            req.getRequestDispatcher(url).forward(req, resp);
            return;
        }

        req.setAttribute("customer", customer.get());
        req.setAttribute("action", "edit");

        req.getRequestDispatcher(url).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();

        CustomerDao customerDao = new CustomerDao(dataSource);
        AddressDao addressDao = new AddressDao(dataSource);

        Customer customer = new Customer();

        customer.setCode(Integer.valueOf(req.getParameter("code")));
        customer.setName(req.getParameter("name"));
        customer.setEmail(req.getParameter("email"));
        customer.setPhone(req.getParameter("phone"));
        customer.setCpf(req.getParameter("cpf"));

        Address address = new Address();

        address.setId(Long.parseLong(req.getParameter("addressId")));
        address.setNumber(req.getParameter("number"));
        address.setStreet(req.getParameter("street"));
        address.setNeighborhood(req.getParameter("neighborhood"));
        address.setCity(req.getParameter("city"));
        address.setState(req.getParameter("state"));
        address.setZipCode(req.getParameter("zipcode"));
        address.setComplement(req.getParameter("complement"));

        if (!addressDao.update(address)) {
            req.setAttribute("result", "error");
            req.getRequestDispatcher(url).forward(req, resp);
            return;
        }

        customer.setAddress(address);

        if (!customerDao.update(customer)){
            req.setAttribute("result", "error");
            req.getRequestDispatcher(url).forward(req, resp);
            return;
        }

        req.setAttribute("result", "success");
        resp.sendRedirect(req.getContextPath() + "/home");
    }
}