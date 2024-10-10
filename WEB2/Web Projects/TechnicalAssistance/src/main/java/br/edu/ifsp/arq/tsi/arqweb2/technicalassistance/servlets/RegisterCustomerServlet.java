package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.CustomerDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register-customer")
public class RegisterCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("./pages/register-customer/register-customer.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int code;
        long cpf;
        String name, email, phone;

        try{
            code = Integer.parseInt(req.getParameter("code"));
            name = req.getParameter("name");
            email = req.getParameter("email");
            phone = req.getParameter("phone");
            cpf = Long.parseLong(req.getParameter("cpf"));
        } catch (NumberFormatException e) {
            dispatcherForward(req, resp, "error");
            return;
        }

        Customer customer = new Customer();

        customer.setCode(code);
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setCpf(cpf);

        CustomerDao customerDao = new CustomerDao(DataSourceSearcher.getInstance().getDataSource());

        if (!customerDao.save(customer)) {
            dispatcherForward(req, resp, "error");
            return;
        }

        dispatcherForward(req, resp, "success");
    }

    private void dispatcherForward(HttpServletRequest req, HttpServletResponse resp, String message) throws ServletException, IOException {
        req.setAttribute("result", message);
        req.getRequestDispatcher("./pages/register-customer/register-customer.jsp").forward(req, resp);
    }
}
