package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.employee;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Address;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Employee;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.AddressDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.EmployeeDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.Encoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.Util.dispatcherForward;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private static final String url = "/pages/signup/page.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/pages/signup/page.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name, cpf, email, password;


        try{
            name = req.getParameter("name");
            cpf = req.getParameter("cpf");
            email = req.getParameter("email");
            password = Encoder.encode(req.getParameter("password"));
        } catch (NumberFormatException e) {
            dispatcherForward(req, resp, url,"error");
            return;
        }

        Employee e = new Employee();

        e.setName(name);
        e.setEmail(email);
        e.setCpf(cpf);
        e.setPassword((password));

        EmployeeDao employeeDao = new EmployeeDao(DataSourceSearcher.getInstance().getDataSource());


        if (!employeeDao.save(e)) {
            dispatcherForward(req, resp, url,"error");
            return;
        }

        dispatcherForward(req, resp, "/signin","success");
    }
}
