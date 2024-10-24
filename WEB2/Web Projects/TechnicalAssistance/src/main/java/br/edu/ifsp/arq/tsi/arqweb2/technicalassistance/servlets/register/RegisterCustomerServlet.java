package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.register;

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

import java.io.IOException;

import static br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.Util.dispatcherForward;

@WebServlet("/home/register/customer")
public class RegisterCustomerServlet extends HttpServlet {

    private static final String url = "/pages/home/register/customer/page.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("action", "register");
        req.getRequestDispatcher("/pages/home/register/customer/page.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String cpf; String name, email, phone; // Dados do cliente
        int zipcode; String number, street, neighborhood, city, state, complement; // Dados do endereço do cliente

        try{
            name = req.getParameter("name");
            email = req.getParameter("email");
            phone = req.getParameter("phone");
            cpf = req.getParameter("cpf");
            number = req.getParameter("number");
            street = req.getParameter("street");
            neighborhood = req.getParameter("neighborhood");
            city = req.getParameter("city");
            state = req.getParameter("state");
            zipcode = Integer.parseInt(req.getParameter("zipcode").replace("-", ""));
            complement = req.getParameter("complement");
        } catch (NumberFormatException e) {
            dispatcherForward(req, resp, url,"error");
            return;
        }

        Address address = new Address();

        address.setNumber(number);
        address.setStreet(street);
        address.setNeighborhood(neighborhood);
        address.setCity(city);
        address.setState(state);
        address.setZipCode(Integer.toString(zipcode));
        address.setComplement(complement);

        Customer customer = new Customer();

        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setCpf(cpf);
        customer.setAddress(address);

        CustomerDao customerDao = new CustomerDao(DataSourceSearcher.getInstance().getDataSource());
        AddressDao addressDao = new AddressDao(DataSourceSearcher.getInstance().getDataSource());

        address.setCode(addressDao.getLastId() + 1L);

        if (!addressDao.save(address)) {
            dispatcherForward(req, resp, url,"error");
            return;
        }

        if (!customerDao.save(customer)) {
            dispatcherForward(req, resp, url,"error");
            return;
        }

        dispatcherForward(req, resp, "/home", "success");    }
}
