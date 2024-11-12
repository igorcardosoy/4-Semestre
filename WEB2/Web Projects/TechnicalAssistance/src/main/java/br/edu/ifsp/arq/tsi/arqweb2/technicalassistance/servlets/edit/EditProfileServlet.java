package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.edit;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Employee;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.EmployeeDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.Encoder;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/home/edit/profile")
public class EditProfileServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        EmployeeDao employeeDao = new EmployeeDao(DataSourceSearcher.getInstance().getDataSource());
        req.setAttribute("employee", employeeDao.getByCode((Long) req.getSession().getAttribute("employeeCode")).get());
        req.setAttribute("employeeCode", req.getSession().getAttribute("employeeCode"));
        req.setAttribute("action", "edit");

        req.getRequestDispatcher("/pages/signup/page.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name, email, password, cpf;

        try{
            name = req.getParameter("name");
            email = req.getParameter("email");
            cpf = req.getParameter("cpf");
            password = Encoder.encode(req.getParameter("password"));
        } catch (NumberFormatException e) {
            req.getRequestDispatcher("/pages/signup/page.jsp").forward(req, resp);
            return;
        }

        Employee employee = new Employee();
        employee.setName(name);
        employee.setEmail(email);
        employee.setPassword(password);
        employee.setCpf(cpf);
        employee.setCode((Long) req.getSession().getAttribute("employeeCode"));

        Employee oldEmployee = new EmployeeDao(DataSourceSearcher.getInstance().getDataSource()).getByCode(employee.getCode()).get();

        if (!employee.getPassword().equals(oldEmployee.getPassword())) {
            Util.dispatcherForward(req, resp, "/home/edit/profile", "error");
            return;
        }

        EmployeeDao employeeDao = new EmployeeDao(DataSourceSearcher.getInstance().getDataSource());
        if (!employeeDao.update(employee)) {
            Util.dispatcherForward(req, resp, "/home/edit/profile", "error");
            return;
        }


        Util.dispatcherForward(req, resp, "/home/view/profile", "success");
    }
}
